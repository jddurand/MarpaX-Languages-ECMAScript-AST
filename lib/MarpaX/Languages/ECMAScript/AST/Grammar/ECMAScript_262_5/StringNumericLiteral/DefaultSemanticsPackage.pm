use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::DefaultSemanticsPackage;
use Data::Float qw//;

# ABSTRACT: ECMAScript 262, Edition 5, lexical string numeric grammar default semantics package

# VERSION

=head1 DESCRIPTION

This modules provide a default semantics package for the actions associated to ECMAScript_262_5 lexical string numeric grammar.

=cut

=head2 new($class)

Instantiate a new object, initialized to positive zero, and undefined length.

=cut

sub new {
    return bless({_number => 0, length => undef}, $_[0]);
}

=head2 mul($self, $objmul)

Multiply $self by $objmul. Returns $self.

=cut

sub mul {
    $_[0]->{_number} *= $_[1]->{_number};
    return $_[0];
}

=head2 round($self)

Round $self. Returns $self.

=cut

sub round {
    return $_[0];
}

=head2 pos_zero($self)

Set $self to positive zero. Returns $self.

=cut

sub pos_zero {
    $_[0]->{_number} = Data::Float::pos_zero;
    return $_[0];
}

=head2 pos_infinity($self)

Set $self to positive infinity. Return $self.

=cut

sub pos_infinity {
    $_[0]->{_number} = Data::Float::pos_infinity;
    return $_[0];
}

=head2 nan($class)

Class method that returns host's nan value.

=cut

sub nan {
    return Data::Float::nan;
}

=head2 pow($self, $powobj)

Set $self to 10 ** $powobj. Returns $self.

=cut

sub pow {
    $_[0]->{_number} = 10 ** $_[1]->{_number};
    return $_[0];
}

=head2 positive_int($self, $string)

Set $self to positive integer represented in $string. $string is guaranteed to be in the range "0"..."9", or "10", or "16". Automatically initialize length() to the number of characters in input. Returns $self.

=cut

sub positive_int {
    $_[0]->{_number} = int("$_[1]");
    $_[0]->{_length} = length("$_[1]");
    return $_[0];
}

=head2 positive_hex($self, $string)

Set $self to positive hexadecimal integer represented in $string. $string is guaranteed to be in the range "0"..."9", "a"..."f" (case insensitive). Returns $self.

=cut

sub positive_hex {
    $_[0]->{_number} = hex("$_[1]");
    return $_[0];
}

=head2 neg($self)

Change the sign of $self. Returns $self.

=cut

sub neg {
    $_[0]->{_number} *= -1;
    return $_[0];
}

=head2 add($self, $addobj)

Set $self to $self + $addobj. Returns $self.

=cut

sub add {
    $_[0]->{_number} += $_[1]->{_number};
    return $_[0];
}

=head2 sub($self, $subobj)

Set $self to $self - $subobj. Returns $self.

=cut

sub sub {
    $_[0]->{_number} -= $_[1]->{_number};
    return $_[0];
}

=head2 hostValue($self, $host_value?)

Getter/setter of host value in $self. Returns host value.

=cut

sub hostValue {
    if ($#_ > 0) {
	$_[0]->{_number} = $_[1];
    }
    return $_[0]->{_number};
}

=head2 length($self, $length?)

Getter/setter of number of characters used to represent the host value length. Used only in case of decimal digits.

=cut

sub length {
    if ($#_ > 0) {
	$_[0]->{_length} = $_[1];
    }
    return $_[0]->{_length};
}

1;
