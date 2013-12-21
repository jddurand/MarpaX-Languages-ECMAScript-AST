use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar;

# ABSTRACT: ECMAScript grammar written in Marpa BNF

use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5;
use MarpaX::Languages::ECMAScript::AST::Exceptions qw/:all/;

# VERSION

=head1 DESCRIPTION

This modules returns ECMAScript grammar(s) written in Marpa BNF.
Current grammars are:
=over
=item *
ECMAScript-262-5. The ECMAScript-262, Edition 5, as of L<http://www.ecma-international.org/publications/standards/Ecma-262.htm>.
=back

=head1 SYNOPSIS

    use MarpaX::Languages::ECMAScript::AST::Grammar;

    my $grammar = MarpaX::Languages::ECMAScript::AST::Grammar->new('ECMAScript-262-5');
    my $grammar_content = $grammar->content();
    my $grammar_option = $grammar->grammar_option();
    my $recce_option = $grammar->recce_option();

=head1 SUBROUTINES/METHODS

=head2 new($class, $grammarName, %grammarSpecificOptions)

Instance a new object. Takes the name of the grammar as argument. Remaining arguments are passed to the sub grammar method. Supported grammars are:

=over

=item ECMAScript-262-5

ECMAScript-262, Edition 5

=back

=cut

sub new {
  my ($class, $grammarName, %grammarSpecificOptions) = @_;

  my $self = {};
  if (! defined($grammarName)) {
    InternalError(error => 'Usage: new($grammar_Name)');
  } elsif ($grammarName eq 'ECMAScript-262-5') {
    $self->{_grammarAlias} = 'ECMAScript_262_5';
    $self->{_grammar} = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5->new(%grammarSpecificOptions);
  } else {
    InternalError(error => "Unsupported grammar name $grammarName");
  }
  bless($self, $class);

  return $self;
}

=head2 program($self)

Returns the program grammar as a reference to hash that is

=over

=item grammar

A MarpaX::Languages::ECMAScript::AST::Grammar::Base object

=item impl

A MarpaX::Languages::ECMAScript::AST::Impl object

=back

=cut

sub program {
    my ($self) = @_;
    return $self->{_grammar}->program;
}

=head2 grammarAlias($self)

Returns the grammar alias, i.e. the one really used in this distribution.

=cut

sub grammarAlias {
    my ($self) = @_;
    return $self->{_grammarAlias};
}

=head2 template($self)

Returns the generic template associated to grammarName.

=cut

sub template {
    my ($self) = @_;
    return $self->{_grammar}->template;
}

=head2 stringNumericLiteral($self)

Returns the generic stringNumericLiteral associated to grammarName.

=cut

sub stringNumericLiteral {
    my ($self) = @_;
    return $self->{_grammar}->stringNumericLiteral;
}

=head1 SEE ALSO

L<Marpa::R2>

L<MarpaX::Languages::ECMAScript::AST>

L<MarpaX::Languages::ECMAScript::AST::Grammar::Base>

L<MarpaX::Languages::ECMAScript::AST::Impl>


=cut

1;
