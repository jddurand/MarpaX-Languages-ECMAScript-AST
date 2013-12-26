use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Impl;

# ABSTRACT: Implementation of Marpa's interface

use Marpa::R2 2.078000;
use MarpaX::Languages::ECMAScript::AST::Exceptions qw/:all/;
use MarpaX::Languages::ECMAScript::AST::Impl::Logger;

# VERSION

our $MARPA_TRACE_FILE_HANDLE;
our $MARPA_TRACE_BUFFER;

sub BEGIN {
    #
    ## We do not want Marpa to pollute STDERR
    #
    ## Autovivify a new file handle
    #
    open($MARPA_TRACE_FILE_HANDLE, '>', \$MARPA_TRACE_BUFFER);
    if (! defined($MARPA_TRACE_FILE_HANDLE)) {
      InternalError(error => "Cannot create temporary file handle to tie Marpa logging, $!\n");
    } else {
      if (! tie ${$MARPA_TRACE_FILE_HANDLE}, 'MarpaX::Languages::ECMAScript::AST::Impl::Logger') {
        InternalError(error => "Cannot tie $MARPA_TRACE_FILE_HANDLE, $!\n");
        if (! close($MARPA_TRACE_FILE_HANDLE)) {
          InternalError(error => "Cannot close temporary file handle, $!\n");
        }
        $MARPA_TRACE_FILE_HANDLE = undef;
      }
    }
}

=head1 DESCRIPTION

This modules implements all needed Marpa calls using its Scanless interface. Please be aware that logging is done via Log::Any.

=head1 SYNOPSIS

    use strict;
    use warnings FATAL => 'all';
    use MarpaX::Languages::ECMAScript::AST::Impl;

    my $marpaImpl = MarpaX::Languages::ECMAScript::AST::Impl->new();

=head1 SUBROUTINES/METHODS

=head2 new($class, $grammarOptionsHashp, $recceOptionsHashp, $cachedG, $noR)

Instantiate a new object. Takes as parameter two references to hashes: the grammar options, the recognizer options. In the recognizer, there is a grammar internal option that will be forced to the grammar object. If the environment variable MARPA_TRACE_TERMINALS is set to a true value, then internal Marpa trace on terminals is activated. If the environment MARPA_TRACE_VALUES is set to a true value, then internal Marpa trace on values is activated. If the environment variable MARPA_TRACE is set to a true value, then both terminals and values internal Marpa traces are activated. $cachedG is an optional parameter that must be a cached value of Marpa::R2::Scanless::G->new($grammarOptionsHashp). If not present, this value can be retrieved for further use with $self->grammar method. As a special case, if the optional $noR is true, no Marpa::R2::Scanless:G recognizer will be created. This can be used to generate a Marpa::R2::Scanless:G only and cache it. Default $noR is false. When $noR is true, $recceOptionsHashp is nevertheless kept for further see (see method R()).

=cut

sub new {
  my ($class, $grammarOptionsHashp, $recceOptionsHashp, $cachedG, $noR) = @_;

  my $self->{grammar} = $cachedG || Marpa::R2::Scanless::G->new($grammarOptionsHashp);

  $noR //= 0;
  if (defined($recceOptionsHashp)) {
      $recceOptionsHashp->{grammar} = $self->{grammar};
  } else {
      $recceOptionsHashp = {grammar => $self->{grammar}};
  }
  $recceOptionsHashp->{trace_terminals} = $ENV{MARPA_TRACE_TERMINALS} || $ENV{MARPA_TRACE} || 0;
  $recceOptionsHashp->{trace_values} = $ENV{MARPA_TRACE_VALUES} || $ENV{MARPA_TRACE} || 0;
  $recceOptionsHashp->{trace_file_handle} = $MARPA_TRACE_FILE_HANDLE;
  #
  # Save recceOptionsHashp for further use
  #
  $self->{_recceOptionsHashp} = $recceOptionsHashp;

  bless($self, $class);

  if (! $noR) {
      $self->make_R;
  }

  return $self;
}

=head2 make_R($self)

Creates a Marpa::R2::Scanless::R recognizer object and store it together with the grammar.

=cut

sub make_R {
    $_[0]->{recce} = Marpa::R2::Scanless::R->new($_[0]->{_recceOptionsHashp});
}

=head2 destroy_R($self)

Destroy an eventual Marpa::R2::Scanless::R recognizer object stored it together with the grammar.

=cut

sub destroy_R {
    $_[0]->{recce} = undef;
}

=head2 value($self)

Returns Marpa's recognizer's value.

=cut

sub value {
  return $_[0]->{recce}->value(@_[1..$#_]);
}

=head2 read($self, $inputp)

Returns Marpa's recognizer's read. Argument is a reference to input.

=cut

sub read {
  return $_[0]->{recce}->read(@_[1..$#_]);
}

=head2 resume($self)

Returns Marpa's recognizer's resume.

=cut

sub resume {
  return $_[0]->{recce}->resume(@_[1..$#_]);
}

=head2 last_completed($self, $symbol)

Returns Marpa's recognizer's last_completed for symbol $symbol.

=cut

sub last_completed {
  return $_[0]->{recce}->last_completed(@_[1..$#_]);
}

=head2 last_completed_range($self, $symbol)

Returns Marpa's recognizer's last_completed_range for symbol $symbol.

=cut

sub last_completed_range {
  return $_[0]->{recce}->last_completed_range(@_[1..$#_]);
}

=head2 range_to_string($self, $start, $end)

Returns Marpa's recognizer's range_to_string for a start value of $start and an end value of $end.

=cut

sub range_to_string {
  return $_[0]->{recce}->range_to_string(@_[1..$#_]);
}

=head2 event($self, $eventNumber)

Returns Marpa's recognizer's event for event number $eventNumber.

=cut

sub event {
  return $_[0]->{recce}->event(@_[1..$#_]);
}

=head2 events($self)

Returns Marpa's recognizer's events.

=cut

sub events {
  return $_[0]->{recce}->events();
}

=head2 pause_lexeme($self)

Returns Marpa's recognizer's pause_lexeme.

=cut

sub pause_lexeme {
  return $_[0]->{recce}->pause_lexeme(@_[1..$#_]);
}

=head2 pause_span($self)

Returns Marpa's recognizer's pause_span.

=cut

sub pause_span {
  return $_[0]->{recce}->pause_span(@_[1..$#_]);
}

=head2 literal($self, $start, $length)

Returns Marpa's recognizer's literal.

=cut

sub literal {
  return $_[0]->{recce}->literal(@_[1..$#_]);
}

=head2 line_column($self, $start)

Returns Marpa's recognizer's line_column at eventual $start location in the input stream. Default location is current location.

=cut

sub line_column {
  return $_[0]->{recce}->line_column(@_[1..$#_]);
}

=head2 substring($self, $start, $length)

Returns Marpa's recognizer's substring corresponding to g1 span ($start, $length).

=cut

sub substring {
  return $_[0]->{recce}->substring(@_[1..$#_]);
}

=head2 lexeme_read($self, $lexeme, $start, $length, $value)

Returns Marpa's recognizer's lexeme_read for lexeme $lexeme, at start position $start, length $length and value $value.

=cut

sub lexeme_read {
  return $_[0]->{recce}->lexeme_read(@_[1..$#_]);
}

=head2 current_g1_location($self)

Returns Marpa's recognizer's current_g1_location.

=cut

sub current_g1_location {
  return $_[0]->{recce}->current_g1_location(@_[1..$#_]);
}

=head2 g1_location_to_span($self, $g1)

Returns Marpa's recognizer's g1_location_to_span for a g1 location $g1.

=cut

sub g1_location_to_span {
  return $_[0]->{recce}->g1_location_to_span(@_[1..$#_]);
}

=head2 terminals_expected($self)

Returns Marpa's recognizer's terminals_expected.

=cut

sub terminals_expected {
  return $_[0]->{recce}->terminals_expected(@_[1..$#_]);
}

=head2 show_progress($self)

Returns Marpa's recognizer's show_progress.

=cut

sub show_progress {
  return $_[0]->{recce}->show_progress(@_[1..$#_]);
}

=head2 progress($self)

Returns Marpa's recognizer's progress.

=cut

sub progress {
  return $_[0]->{recce}->progress(@_[1..$#_]);
}

=head2 grammar($self)

Returns a Marpa::R2::Scanless::G object of this grammar.

=cut

sub grammar {
  return $_[0]->{grammar};
}

=head2 G($self)

Alias of the grammar() method.

=cut

sub G {
  return $_[0]->grammar;
}

=head2 recce($self)

Returns a Marpa::R2::Scanless::R object of this grammar.

=cut

sub recce {
  return $_[0]->{grammar};
}

=head2 rule_ids($self, $subgrammar)

Returns Marpa's grammar's rule_ids.

=cut

sub rule_ids {
  return $_[0]->{grammar}->rule_ids(@_[1..$#_]);
}

=head2 rule_expand($self, $ruleId)

Returns Marpa's grammar's rule_expand.

=cut

sub rule_expand {
  return $_[0]->{grammar}->rule_expand(@_[1..$#_]);
}

=head2 symbol_name($self, $symbolId)

Returns Marpa's grammar's symbol_name.

=cut

sub symbol_name {
  return $_[0]->{grammar}->symbol_name(@_[1..$#_]);
}

=head1 SEE ALSO

L<Marpa::R2::Scanless::G>

L<Marpa::R2::Scanless::R>

=cut

1;
