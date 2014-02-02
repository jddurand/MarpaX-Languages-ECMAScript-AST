use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::DefaultSemanticsPackage;
use Data::Float qw//;
use Scalar::Util qw/blessed/;

# ABSTRACT: ECMAScript 262, Edition 5, lexical string numeric grammar default semantics package

# VERSION

=head1 DESCRIPTION

This modules provide a default semantics package for the actions associated to ECMAScript_262_5 lexical string numeric grammar.

=cut

=head2 new($class)

Instantiate a new object that has two members: number initialized to host's positive zero, and length initalized to host's positive zero.

=cut

sub new {
    return bless({_number => 0, length => 0}, $_[0]);
}

=head2 host_mul($self, $objmul)

Host implementation of $self multiplied by $objmul. Returns $self.

=cut

sub host_mul {
    $_[0]->{_number} *= $_[1]->{_number};
    return $_[0];
}

=head2 host_round($self)

Host implementation of rounded $self. Returns $self.

=cut

sub host_round {
    return $_[0];
}

=head2 host_pos_zero($self)

Host implementation of $self setted to positive zero, defaulting to Data::Float::pos_zero. Returns $self.

=cut

sub host_pos_zero {
    $_[0]->{_number} = Data::Float::pos_zero;
    return $_[0];
}

=head2 host_pos_inf($self)

Host implementation of $self setted to positive infinity, defaulting to Data::Float::pos_infinity. Return $self.

=cut

sub host_pos_inf {
    $_[0]->{_number} = Data::Float::pos_infinity;
    return $_[0];
}

=head2 host_pow($self, $powobj)

Host implementation of $self setted to 10 ** $powobj. Returns $self.

=cut

sub host_pow {
    $_[0]->{_number} = 10 ** $_[1]->{_number};
    return $_[0];
}

=head2 host_int($self, $string)

Host implementation of $self setted to positive integer represented in $string, length initialized to the number of characters in $string. Returns $self.

=cut

sub host_int {
    $_[0]->{_number} = int("$_[1]");
    $_[0]->{_length} = length("$_[1]");
    return $_[0];
}

=head2 host_hex($self, $string)

Host implementation of $self setted to positive hexadecimal integer represented in $string. Returns $self.

=cut

sub host_hex {
    $_[0]->{_number} = hex("$_[1]");
    return $_[0];
}

=head2 host_neg($self)

Host implementation of $self sign change. Returns $self.

=cut

sub host_neg {
    $_[0]->{_number} *= -1;
    return $_[0];
}

=head2 host_add($self, $addobj)

Host implementation of $addobj added to $self. Returns $self.

=cut

sub host_add {
    $_[0]->{_number} += $_[1]->{_number};
    return $_[0];
}

=head2 host_sub($self, $subobj)

Host implementation of $subobj substracted from $self. Returns $self.

=cut

sub host_sub {
    $_[0]->{_number} -= $_[1]->{_number};
    return $_[0];
}

=head2 host_inc_length($self)

Increase by one the host representation of the number of characters used to evaluate the host value. Returns $self.

=cut

sub host_inc_length {
    ++$_[0]->{_length};
    return $_[0];
}

=head2 host_new_from_length($self)

Returns the a new object derived from the number of characters used to evaluate the host value of $self. Returns the new object instance.

=cut

sub host_new_from_length {
    return $_[0]->host_class->new->host_int("$_[0]->{_length}");
}

=head2 host_class($self)

Returns the host class that, when called as class->new, is creating a new object.

=cut

sub host_class {
  return blessed($_[0]);
}

=head2 host_value($self)

Returns the host implementation of value hosted in $self.

=cut

sub host_value {
  return $_[0]->{_number};
}

1;
