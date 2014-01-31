use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern::DefaultSemanticsPackage;
use Data::Float qw//;
use MarpaX::Languages::ECMAScript::AST::Exceptions qw/:all/;

# ABSTRACT: ECMAScript 262, Edition 5, pattern grammar default semantics package

# VERSION

=head1 DESCRIPTION

This modules provide default host implementation for the actions associated to ECMAScript_262_5 pattern grammar.

=head2 new($class)

Instantiate a new object.

=cut

sub new {
    return bless({
                  _lparen           => [],
                  _rparen           => [],
                  _nCapturingParens => 0,
                  _ignoreCase       => 0,
                  _multiline        => 0,
                 }, $_[0]);
}

=head2 lparen($self)

Returns an array reference of all left parenthesis of atom's disjunctions.

=cut

sub lparen {
  my ($self) = @_;
  return $self->{_lparen};
}

=head2 parenIndex($self, $pos)

Returns the number of left capturing parentheses in the entire regular expression that occur to the left of $pos, not including $pos.

=cut

sub parenIndex {
  my ($self, $pos) = @_;
  return grep {$_ < $pos} @{$self->{_lparen}};
}

=head2 parenCount($self, $pos1, $pos2)

Returns the number of left capturing parentheses in the entire regular expression that occur between $pos1 and $pos2, both inclusive.

=cut

sub parenCount {
  my ($self, $pos1, $pos2) = @_;
  return grep {$_ >= $pos1 && $_ <= $pos2} @{$self->{_lparen}};
}

=head2 rparen($self)

Returns an array reference of all right parenthesis of atom's disjunctions.

=cut

sub rparen {
  my ($self) = @_;
  return $self->{_rparen};
}

=head2 host_eval($self, $hostContent)

Evaluates and returns what is in $hostContent. Typically used to return a Matcher. Defaults to eval on the arguments.

=cut

sub host_eval {
  return eval{@_};
}

=head2 host_true($self)

Returns how the host represent true. Defaults to 1.

=cut

sub host_true {
  return 1;
}

=head2 host_isTrue($self, $value)

Returns something that will always evaluate to a true value for the host if $value is the host representation of true. Defaults to 1, 0 otherwise.

=cut

sub host_isTrue {
  my ($self, $value) = @_;
  return $value ? 1 : 0;
}

=head2 host_false($self)

Returns how the host represent false. Defaults to 0.

=cut

sub host_false {
  return 0;
}

=head2 host_isFalse($self, $value)

Returns something that will always evaluate to a true value for the host if $value is the host representation of false. Defaults to 1, 0 otherwise.

=cut

sub host_isFalse {
  my ($self, $value) = @_;
  return (! $value) ? 1 : 0;
}

=head2 host_success($self)

Returns how the host represent success. Defaults to 1.

=cut

sub host_success {
  return 1;
}

=head2 host_isSuccess($self, $value)

Returns host_isTrue() if $value is the host representation of host_success, returns host_isFalse() otherwise.

=cut

sub host_isSuccess {
  my ($self, $value) = @_;
  return $value ? $self->host_isTrue : $self->host_isFalse;
}

=head2 host_failure($self)

Returns how the host represent failure. Defaults to 0.

=cut

sub host_failure {
  return 0;
}

=head2 host_isFailure($self, $value)

Returns host_isTrue() if $value is the host representation of host_failure, returns host_isFalse() otherwise.

=cut

sub host_isFailure {
  my ($self, $value) = @_;
  return (! $value) ? $self->host_isTrue : $self->host_isFalse;
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

=head2 host_undef($self)

Returns how the host represent the undefined value.

=cut

sub host_undef {
  return undef;
}

=head2 host_isUndef($self, $value)

Returns host_isTrue() if $value is the host representation of undefined, returns host_isFalse() otherwise.

=cut

sub host_isUndef {
  my ($self, $value) = @_;
  return (! defined($value)) ? $self->host_isTrue : $self->host_isFalse;
}

=head2 host_pos_inf($self)

Host implementation of positive infinity, defaulting to Data::Float::pos_infinity. Return $self.

=cut

sub host_pos_inf {
    $_[0]->{_number} = Data::Float::pos_infinity;
    return $_[0];
}

=head2 host_isInf($self)

Returns host_isTrue() if $value is infinite (negative or positive), returns host_isFalse() otherwise. Finite test defaults to Data::Float::float_is_infinite.

=cut

sub host_isInf {
  my ($self, $value) = @_;
  return Data::Float::float_is_infinite($value) ? $self->host_isTrue : $self->host_isFalse;
}

=head2 host_isFinite($self, $value)

Returns host_isTrue() if $value is finite, returns host_isFalse() otherwise. Finite test defaults to Data::Float::float_is_finite.

=cut

sub host_isFinite {
  my ($self, $value) = @_;
  return Data::Float::float_is_finite($value) ? $self->host_isTrue : $self->host_isFalse;
}

=head2 host_isLt($self, $v1, v2)

Returns host_isTrue() if $v1 is lower than $v2, returns host_isFalse() otherwise. Lower than defaults $v1 < $v2.

=cut

sub host_isLt {
  my ($self, $v1, $v2) = @_;
  return ($v1 < $v2) ? $self->host_isTrue : $self->host_isFalse;
}

=head2 syntaxError($self, $msg)

Throw error of type SyntaxError with message $msg.

=cut

sub syntaxError {
  my ($self, $msg) = @_;
  SyntaxError(error => $msg);
}

1;
