use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::Base;
use MarpaX::Languages::ECMAScript::AST::Util qw/:all/;
use MarpaX::Languages::ECMAScript::AST::Impl qw//;
use Log::Any qw/$log/;
use constant SEARCH_KEYWORD_IN_GRAMMAR => '# DO NOT REMOVE NOR MODIFY THIS LINE';
use MarpaX::Languages::ECMAScript::AST::Exceptions qw/:all/;

# ABSTRACT: ECMAScript, grammars base package

# VERSION

#
# Note: because this module is usually subclasses, internal methods are called
# using _method($self, ...) instead of $self->_method(...)
#

=head1 DESCRIPTION

This modules returns a base package for all the ECMAScript grammars written in Marpa BNF.

=head1 SYNOPSIS

    use strict;
    use warnings FATAL => 'all';
    use MarpaX::Languages::ECMAScript::AST::Grammar::Base;

    my $grammar = MarpaX::Languages::ECMAScript::AST::Grammar::Base->new("grammar", "My::Package", "ECMAScript_262_5");

    my $grammar_content = $grammar->content();
    my $grammar_option = $grammar->grammar_option();
    my $recce_option = $grammar->recce_option();

=head1 SUBROUTINES/METHODS

=head2 new($grammar, $package, $spec)

Instance a new object. Takes a grammar, a package name and an ECMAScript specification as required parameters.

=cut

sub new {
  my ($class, $grammar, $package, $spec) = @_;

  InternalError(error => 'Missing grammar') if (! defined($grammar));
  InternalError(error => 'Missing package name') if (! defined($package));
  InternalError(error => 'Missing ECMAScript specification') if (! defined($spec));

  my $self  = {
      _content => $grammar,
      _grammar_option => {action_object  => sprintf('%s::%s', $package, 'Actions')},
      _recce_option => {ranking_method => 'high_rule_only'},
      _strict => 0
  };
  #
  # Too painful to write MarpaX::Languages::ECMAScript::AST::Grammar::${spec}::CharacterClasses::IsSomething
  # so I change it on-the-fly here
  #
  my $characterClass = "\\p{MarpaX::Languages::ECMAScript::AST::Grammar::${spec}::CharacterClasses::Is";
  $self->{_content} =~ s/\\p\{Is/$characterClass/g;

  bless($self, $class);

  return $self;
}

=head2 strict($self, [$strict])

Sets/Returns the strict mode of the grammar.

=cut

sub strict {
    my $self = shift;
    if (@_) {
	$self->{_strict} = shift;
    }
    return $self->{_strict};
}

=head2 content($self)

Returns the content of the grammar.

=cut

sub content {
    my ($self) = @_;
    return $self->{_content};
}

=head2 extract($self)

Returns the part of the grammar that can be safely extracted and injected in another.

=cut

sub extract {
    my ($self) = @_;
    my $rc = '';

    my $content = $self->content;
    my $index = index($content, SEARCH_KEYWORD_IN_GRAMMAR);
    if ($index >= 0) {
      $rc = substr($content, $index);
      $rc =~ s/\baction[ \t]*=>[ \t]*\w+//g;
      $rc =~ s/(__\w+)[ \t]*::=[ \t]*/$1 ~ /g;
    }

    return $rc;
}

=head2 grammar_option($self)

Returns recommended option for Marpa::R2::Scanless::G->new(), returned as a reference to a hash.

=cut

sub grammar_option {
    my ($self) = @_;
    return $self->{_grammar_option};
}

=head2 recce_option($self)

Returns recommended option for Marpa::R2::Scanless::R->new(), returned as a reference to a hash.

=cut

sub recce_option {
    my ($self) = @_;
    return $self->{_recce_option};
}

=head2 parse($self, $source, [$optionsp], [$start], [$length])

Parse the source given as reference to a scalar, an optional reference to a options that is a hash that can contain:

=over

=item callbackargsp

Callbak Code Reference

=item callbackargs

Reference to an array of Callback Code Reference first arguments

=item failure

Failure callback Code Reference

=item failureargs

Reference to an array of Failure callback Code Reference first arguments

=item end

End callback Code Reference

=item endargs

Reference to an array of End callback Code Reference first arguments

=back

This method must be called as a super method by grammar using this package as a parent. $self must be a reference to a grammar instantiated via MarpaX::Languages::ECMAScript::AST::Grammar. The callback code will always be called with: per-callback arguments, $source, $pos (i.e. current position), $max (i.e. max position), $impl (i.e. a MarpaX::Languages::ECMAScript::AST::Impl instance). The default and failure callbacks must always return the new position in the stream, and raise a MarpaX::Languages::ECMAScript::AST::Exception::SyntaxError exception if there is an error. In the 'end' and 'failure' callbacks, $pos is not meaningful: this is the last position where external scanning restarted. You might want to look to the getLastLexeme() method. Output of the 'end' callback is ignored.

=cut

sub _callback {
  my ($self, $source, $pos, $max, $impl, $callbackp, $originalErrorString, @args) = @_;

  my $rc = $pos;

  eval {$rc = &$callbackp(@args, $source, $pos, $max, $impl)};
  if ($@) {
    my $callackErrorString = $@;
    my $line_columnp;
    eval {$line_columnp = lineAndCol($impl)};
    if (! $@) {
      if (defined($originalErrorString) && $originalErrorString) {
        SyntaxError(error => sprintf("%s\n%s\n\n%s%s", $originalErrorString, $callackErrorString, showLineAndCol(@{$line_columnp}, $source), _context($self, $impl)));
      } else {
        SyntaxError(error => sprintf("%s\n\n%s%s", $callackErrorString, showLineAndCol(@{$line_columnp}, $source), _context($self, $impl)));
      }
    } else {
      if (defined($originalErrorString) && $originalErrorString) {
        SyntaxError(error => sprintf("%s\n%s\n%s", $originalErrorString, $callackErrorString, _context($self, $impl)));
      } else {
        SyntaxError(error => sprintf("%s\n%s", $callackErrorString, _context($self, $impl)));
      }
    }
  }

  return $rc;
}

sub parse {
  my ($self, $source, $impl, $optionsp, $start, $length) = @_;

  $optionsp //= {};
  my $callbackp = $optionsp->{callback};
  my $callbackargsp = $optionsp->{callbackargs} // [];
  my @callbackargs = @{$callbackargsp};
  my $failurep = $optionsp->{failure};
  my $failureargsp = $optionsp->{failureargs} // [];
  my @failureargs = @{$failureargsp};
  my $endp = $optionsp->{end};
  my $endargsp = $optionsp->{endargs} // [];
  my @endargs = @{$endargsp};
  $start //= 0;
  $length //= -1;

  #
  # This will create a new instance of the string
  #
  $source .= ' ';

  my $pos = $start;
  my $max = length($source) - $start + $length;
  my $stop;
  my $newpos;
  #
  # Space for an eventual last and inserted semicolon
  #
  #
  # Lexer can fail
  #
  eval {$newpos = $impl->read(\$source, $pos, $length)};
  if ($@) {
    #
    # Failure callback
    #
    if (defined($failurep)) {
      $pos = _callback($self, $source, $pos, $max, $impl, $failurep, $@, @failureargs);
    } else {
      my $line_columnp = lineAndCol($impl);
      SyntaxError(error => sprintf("%s\n\n%s%s", $@, showLineAndCol(@{$line_columnp}, $source), _context($self, $impl)));
    }
  } else {
    $pos = $newpos;
  }
  do {
    #
    # Events
    #
    if (defined($callbackp)) {
      $pos = _callback($self, $source, $pos, $max, $impl, $callbackp, undef, @callbackargs);
    }
    #
    # Lexer can fail
    #
    eval {$newpos = $impl->resume($pos)};
    if ($@) {
      if (defined($failurep)) {
        #
        # Failure callback
        #
        $pos = _callback($self, $source, $pos, $max, $impl, $failurep, $@, @failureargs);
      } else {
        my $line_columnp = lineAndCol($impl);
        SyntaxError(error => sprintf("%s\n\n%s%s", $@, showLineAndCol(@{$line_columnp}, $source), _context($self, $impl)));
      }
    } else {
      $pos = $newpos;
    }
  } while ($pos <= $max);

  if (defined($endp)) {
    #
    # End callback
    #
      _callback($self, $source, $pos, $max, $impl, $endp, undef, @endargs);
  }

  return $self;
}

=head2 value($self, $impl)

Return the blessed value. $impl is the recognizer instance for the grammar. Will raise an InternalError exception if there is no parse tree value, or more than one parse tree value.

=cut

sub value {
  my ($self, $impl) = @_;

  my $rc = $impl->value() || InternalError(error => sprintf('%s', _show_last_expression($self, $impl)));
  if (! defined($rc)) {
      InternalError(error => 'Undefined parse tree value');
  }
  if (defined($impl->value())) {
      InternalError(error => 'More than one parse tree value');
  }
  return ${$rc};
}

# ----------------------------------------------------------------------------------------

sub _context {
    my ($self, $impl) = @_;

    my $context = $log->is_debug ?
	sprintf("\n\nContext:\n\n%s", $impl->show_progress()) :
	'';

    return $context;
}

=head2 getLexeme($self, $lexemeHashp, $impl)

Fills a hash with latest paused lexeme:

=over

=item name

Lexeme name

=item start

Start position

=item length

Length

=item line

Line number as per Marpa

=item column

Column number as per Marpa

=item value

Lexeme value

=back

Returns a true value if a lexeme pause information is available.

=cut

# ----------------------------------------------------------------------------------------

sub getLexeme {
  my ($self, $lexemeHashp, $impl) = @_;

  my $rc = 0;
  #
  # Get paused lexeme
  #
  my $lexeme = $impl->pause_lexeme();
  if (defined($lexeme)) {
    $lexemeHashp->{name} = $lexeme;
    ($lexemeHashp->{start}, $lexemeHashp->{length}) = $impl->pause_span();
    ($lexemeHashp->{line}, $lexemeHashp->{column}) = $impl->line_column($lexemeHashp->{start});
    $lexemeHashp->{value} = $impl->literal($lexemeHashp->{start}, $lexemeHashp->{length});
    $rc = 1;
  }

  return $rc;
}

# ----------------------------------------------------------------------------------------

=head2 getLastLexeme($self, $lexemeHashp, $impl)

Fills a hash with latest lexeme (whatever it is, its name is unknown):

=over

=item start

Start position

=item length

Length

=item value

Lexeme value

=back

Returns a true value if a lexeme pause information is available.

=cut

# ----------------------------------------------------------------------------------------

sub getLastLexeme {
  my ($self, $lexemeHashp, $impl) = @_;

  my $rc = 0;
  #
  # Get last lexeme span
  #
  my ($start, $length) = lastLexemeSpan($impl);
  if (defined($start)) {
    ($lexemeHashp->{start}, $lexemeHashp->{length}) = ($start, $length);
    $lexemeHashp->{value} = $impl->literal($lexemeHashp->{start}, $lexemeHashp->{length});
    $rc = 1;
  }

  return $rc;
}

# ----------------------------------------------------------------------------------------

sub _show_last_expression {
  my ($self, $impl) = @_;

  my ($start, $end) = $impl->last_completed_range('SourceElement');
  return 'No source element was successfully parsed' if (! defined($start));
  my $lastExpression = $impl->range_to_string($start, $end);
  return "Last SourceElement successfully parsed was: $lastExpression";
}

=head1 SEE ALSO

L<MarpaX::Languages::ECMAScript::AST::Impl>

L<MarpaX::Languages::ECMAScript::AST::Util>

=cut

1;
