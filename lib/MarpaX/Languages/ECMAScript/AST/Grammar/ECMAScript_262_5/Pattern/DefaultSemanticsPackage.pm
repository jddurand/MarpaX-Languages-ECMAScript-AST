use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern::DefaultSemanticsPackage;

# ABSTRACT: ECMAScript 262, Edition 5, pattern grammar default semantics package

# VERSION

=head1 DESCRIPTION

This modules provide a default semantics package for the actions associated to ECMAScript_262_5 pattern grammar.

=cut

=head2 new($class)

Instantiate a new object. Has a default nCapturingParens value of 0.

=cut

sub new {
    return bless({
                 _nCapturingParens => 0
                 }, $_[0]);
}

=head2 evaluate($self, $hostContent)

Evaluates what is in $hostContent to a subroutine closure.

=cut

sub evaluate {
  return eval{$_[1]};
}

=head2 nCapturingParens($self, $nCapturingParens?)

Getter/Setter for nCapturingParens.

=cut

sub nCapturingParens {
  if ($#_ > 0) {
    $_[0]->{_nCapturingParens} = $_[1];
  }
  return $_[0]->{_nCapturingParens};
}

=head2 undefined($self)

Returns what is a host undefined value.

=cut

sub undefined {
  return undef;
}

=head2 pattern_closure($self, $m)

Returns a host's pattern closure for matcher $m.

=cut

sub pattern_closure {
  my ($self, $m) = @_;

  return sub {
    my ($str, $index) = @_;
    my $inputLength = length($str);
    my $c = sub {
      my ($state) = @_;
      return $state;
    };
    my $cap = [ $self->undefined x $self->nCapturingParens ];
    my $x = ($index, $cap);
    return $m($x, $c);
  };
}

=head2 pattern_closure($self, $m)

Returns a host's pattern closure for matcher $m.

=cut

1;
