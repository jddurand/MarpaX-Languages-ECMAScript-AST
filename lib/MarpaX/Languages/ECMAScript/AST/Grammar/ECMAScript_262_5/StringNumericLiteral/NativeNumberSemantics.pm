use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::NativeNumberSemantics;
use Data::Float qw/have_signed_zero have_infinite/;
use Scalar::Util qw/blessed/;
use Scalar::Util::Numeric qw/isinf/;

our $POS_ZERO = have_signed_zero() ? Data::Float::pos_zero() : 0.0;
#
# C.f. http://computer-programming-forum.com/53-perl/3bbc35c5223c25f7.htm
# On some machine this may give 1.79769313486232e+308 (Alpha/HPUX), i.e.
# when floats on are 64bits when ints are on 32bits
#
our $POS_INF_CANDIDATE1 = (~0)**(~0);
our $POS_INF_CANDIDATE2 = do {my $n = 2; $n *= $n while $n < $n*$n; $n};

our $POS_INF  = have_infinite() ? Data::Float::pos_infinity() : (isinf($POS_INF_CANDIDATE1) ? $POS_INF_CANDIDATE1 : $POS_INF_CANDIDATE2);

# ABSTRACT: ECMAScript 262, Edition 5, lexical string numeric grammar default semantics package, using native perl representations

# VERSION

=head1 DESCRIPTION

This modules provide a default semantics package for the actions associated to ECMAScript_262_5 lexical string numeric grammar, using native number representation. This mean that the notion of Infinity, or positive zero, might not exactly follow ECMAScript specification (which restrict numbers to IEEE 32 bits floats).

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

Host implementation of $self setted to positive zero, defaulting to Data::Float::pos_zero if your host have signed zeroes, 0 otherwise. Returns $self.

=cut

sub host_pos_zero {
    $_[0]->{_number} = $POS_ZERO;
    return $_[0];
}

=head2 host_pos_inf($self)

Host implementation of $self setted to positive infinity, defaulting to Data::Float::pos_infinity if your host have infinity, otherwise a trial between (~0)**(~0) and {my $n = 2; $n *= $n while $n < $n*$n; $n}. Return $self.

=cut

sub host_pos_inf {
    $_[0]->{_number} = $POS_INF;
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
