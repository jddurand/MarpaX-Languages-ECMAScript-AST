use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern::DefaultSemanticsPackage;
use Data::Float qw/float_is_finite/;
use MarpaX::Languages::ECMAScript::AST::Exceptions qw/:all/;

# ABSTRACT: ECMAScript 262, Edition 5, pattern grammar default semantics package

# VERSION

=head1 DESCRIPTION

This modules provide default host implementation for the actions associated to ECMAScript_262_5 pattern grammar.

=cut

=head2 new($class)

Instantiate a new object.

=cut

sub new {
    return bless({
                  _input            => undef,
                  _nCapturingParens => 0,
                  _ignoreCase       => 0,
                  _multiline        => 0,
                 }, $_[0]);
}

=head2 evaluate($self, $hostContent)

Evaluates and returns what is in $hostContent. Typically used to return a Matcher. Defaults to eval on the arguments.

=cut

sub evaluate {
  return eval{@_};
}

=head2 true($self)

Returns how the host represent true. Defaults to 1.

=cut

sub true {
  return 1;
}

=head2 false($self)

Returns how the host represent false. Defaults to 0.

=cut

sub false {
  return 0;
}

=head2 success($self)

Returns how the host represent success. Defaults to 1.

=cut

sub success {
  return 1;
}

=head2 isSuccess($self, $value)

Returns true() if $value is the host representation of success, returns false() otherwise.

=cut

sub isSuccess {
  my ($self, $value) = @_;
  return $value ? $self->true : $self->false;
}

=head2 failure($self)

Returns how the host represent failure. Defaults to 0.

=cut

sub failure {
  return 0;
}

=head2 isFailure($self, $value)

Returns true() if $value is the host representation of failure, returns false() otherwise.

=cut

sub isFailure {
  my ($self, $value) = @_;
  return (! $value) ? $self->true : $self->false;
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

Returns how the host represent the undefined.

=cut

sub undefined {
  return undef;
}

=head2 isUndefined($self, $value)

Returns true() if $value is the host representation of undefined, returns false() otherwise.

=cut

sub isUndefined {
  my ($self, $value) = @_;
  return (! defined($value)) ? $self->true : $self->false;
}

=cut

=head2 isFinite($self, $value)

Returns true() if $value is finite, returns false() otherwise. Finite test defaults to Data::Float::float_is_finite.

=cut

sub isFinite {
  my ($self, $value) = @_;
  return float_is_finite($value) ? $self->true : $self->false;
}

=head2 isLt($self, $v1, v2)

Returns true() if $v1 is lower than $v2, returns false() otherwise. Lower than defaults $v1 < $v2.

=cut

sub isLt {
  my ($self, $v1, $v2) = @_;
  return ($v1 < $v2) ? $self->true : $self->false;
}

=head2 syntaxError($self, $msg)

Throw error of type SyntaxError with message $msg.

=cut

sub syntaxError {
  my ($self, $msg) = @_;
  SyntaxError(error => $msg);
}

1;
