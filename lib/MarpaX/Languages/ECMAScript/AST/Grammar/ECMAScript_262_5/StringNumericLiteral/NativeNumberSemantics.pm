use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::NativeNumberSemantics;
use Data::Float qw/have_signed_zero have_infinite have_nan/;
use Math::BigFloat;
use Scalar::Util qw/blessed/;
use Scalar::Util::Numeric qw/isinf isnan/;

our $POS_ZERO = have_signed_zero() ? Data::Float::pos_zero()     : Math::BigFloat->bzero();
our $NEG_ZERO = have_signed_zero() ? Data::Float::neg_zero()     : Math::BigFloat->bzero();   # No -0 with Math::BigFloat.
our $POS_INF  = have_infinite()    ? Data::Float::pos_infinity() : Math::BigFloat->binf();
our $NEG_INF  = have_infinite()    ? Data::Float::neg_infinity() : Math::BigFloat->binf('-');
our $POS_ONE  = +1;
our $NEG_ONE  = -1;
our $NAN      = have_nan()         ? Data::Float::nan()          : Math::BigFloat->bnan();

# ABSTRACT: ECMAScript 262, Edition 5, lexical string numeric grammar default semantics package, using native perl representations

# VERSION

=head1 DESCRIPTION

This modules provide a default semantics package for the actions associated to ECMAScript_262_5 lexical string numeric grammar, using native number representation, with the possible exceptions of positive zero and positive infinity: if one of them is not available natively, then the Math::BigFloat representation is used.

This module exports more methods, intended to provide a complete set of functions becessarey for ECMAScript runtime.

=cut

=head2 new($class)

Instantiate a new object that has two members: number initialized to host's positive zero, and length initialized to host's positive zero. These two members are independant values. Length is used when evaluation a decimal digit with a dot character '.'. Unless stated, length is unused.

=cut

sub new {
    return bless({_number => 0, _length => 0}, $_[0]);
}

=head2 clone_init($self)

New instance that is a initialized clone of $self, like new().

=cut

sub clone_init {
    return bless({_number => 0, _length => 0}, ref($_[0]));
}

=head2 clone($self)

Cloning of $self (i.e. copy of $self's number and $self's length members). Returns a new instance.

=cut

sub clone {
    return bless({_number => $_[0]->{_number}, _length => $_[0]->{_length}}, ref($_[0]));
}

=head2 host_mul($self, $objmul)

Host implementation of $self's number multiplied by $objmul's number. Returns $self.

=cut

sub host_mul {
    $_[0]->{_number} *= $_[1]->{_number};
    return $_[0];
}

=head2 host_nan($self)

Host implementation of $self's number setted to nan, defaulting to Data::Float::nan if your host have it, Math::BigFloat's implementation otherwise. Returns $self.

=cut

sub host_nan {
    $_[0]->{_number} = $NAN;
    return $_[0];
}

=head2 host_pos_one($self)

Host implementation of $self's number setted to positive one, defaulting to +1. Returns $self.

=cut

sub host_pos_one {
    $_[0]->{_number} = $POS_ONE;
    return $_[0];
}

=head2 host_neg_one($self)

Host implementation of $self's number setted to negative one, defaulting to -1. Returns $self.

=cut

sub host_neg_one {
    $_[0]->{_number} = $NEG_ONE;
    return $_[0];
}

=head2 host_pos_zero($self)

Host implementation of $self's number setted to positive zero, defaulting to Data::Float::pos_zero if your host have signed zeroes, 0 otherwise. Returns $self.

=cut

sub host_pos_zero {
    $_[0]->{_number} = $POS_ZERO;
    return $_[0];
}

=head2 host_pos_inf($self)

Host implementation of $self's number setted to positive infinity, defaulting to Data::Float::pos_infinity if your host have infinity, otherwise a trial between (~0)**(~0) and {my $n = 2; $n *= $n while $n < $n*$n; $n}. Return $self.

=cut

sub host_pos_inf {
    $_[0]->{_number} = $POS_INF;
    return $_[0];
}

=head2 host_round($self)

Host implementation of $self's number rounding, defaulting to no-op. Returns $self.

=cut

sub host_round {
    return $_[0];
}

=head2 host_pow($self, $powobj)

Host implementation of $self's number setted to 10 ** $powobj's number. Returns $self.

=cut

sub host_pow {
    $_[0]->{_number} = 10 ** $_[1]->{_number};
    return $_[0];
}

=head2 host_int($self, $string)

Host implementation of $self's number setted to positive integer represented in $string, length being initialized to the number of characters in $string. Returns $self.

=cut

sub host_int {
    $_[0]->{_number} = int("$_[1]");
    $_[0]->{_length} = length("$_[1]");
    return $_[0];
}

=head2 host_hex($self, $string)

Host implementation of $self's number setted to positive hexadecimal integer represented in $string. Returns $self.

=cut

sub host_hex {
    $_[0]->{_number} = hex("$_[1]");
    return $_[0];
}

=head2 host_neg($self)

Host implementation of $self's number sign change. Returns $self.

=cut

sub host_neg {
    $_[0]->{_number} *= -1;
    return $_[0];
}

=head2 host_abs($self)

Host implementation of absolute value applied to $self's number. Returns $self.

=cut

sub host_abs {
    $_[0]->{_number} = abs($_[0]->{_number});
    return $_[0];
}

=head2 new_from_sign($self)

Host implementation of sign applied to $self. Returns a new instance initialized with host_neg_one() if $self's value is negative, host_pos_one() if $self's value is positive, host_nan() if $self's value is not a number.

=cut

sub new_from_sign {
  if ($_[0]->host_is_nan) {
    return $_[0]->clone_init->host_nan;
  }
  elsif ($_[0]->host_is_pos) {
    return $_[0]->clone_init->host_pos_one;
  }
  else {
    return $_[0]->clone_init->host_neg_one;
  }
}

=head2 new_from_cmp($self, $cmpobj)

Host implementation of comparison between $self and $cmpobj. Returns a new instance initialized with host_neg_one() if $self's value < $cmpobj's value, host_pos_one() if $self's value > $cmpobj's value, host_pos_zero() if $self's value == $cmpobj's value, host_nan() otherwise.

=cut

sub new_from_cmp {
  if ($_[0]->host_is_nan || $_[1]->host_is_nan) {
    return $_[0]->clone_init->host_nan;
  }
  elsif ($_[0]->value < $_[1]->value) {
      print STDERR $_[0]->value  . "<" .  $_[1]->value . "\n";
    return $_[0]->clone_init->host_neg_one;
  }
  elsif ($_[0]->value > $_[1]->value) {
      print STDERR $_[0]->value  . ">" .  $_[1]->value . "\n";
    return $_[0]->clone_init->host_pos_one;
  }
  else {
      print STDERR $_[0]->value  . "==" .  $_[1]->value . "\n";
    return $_[0]->clone_init->host_pos_zero;
  }
}

=head2 host_cmp($self, $cmpobj)

Host implementation of comparison between $self and $cmpobj. Returns a negative number if $self's value < $cmpobj's value, a positive number if $self's value > $cmpobj's value, a positive zero if $self's value == $cmpobj's value, nan otherwise.

=cut

sub host_cmp {
    return $_[0]->new_from_cmp($_[1])->value;
}

=head2 cmp($value1, $value2)

Host implementation of comparison between $value1 and $value2. Returns a negative number if $self's value < $cmpobj's value, a positive number if $self's value > $cmpobj's value, a positive zero if $self's value == $cmpobj's value, nan otherwise.

=cut

sub cmp {
    my $obj1 = __PACKAGE__->new->host_set_value($_[1]);
    my $obj2 = __PACKAGE__->new->host_set_value($_[2]);
    return $obj1->host_cmp($obj2);
}

=head2 host_add($self, $addobj)

Host implementation of $addobj's number added to $self's number. Returns $self.

=cut

sub host_add {
    $_[0]->{_number} += $_[1]->{_number};
    return $_[0];
}

=head2 host_sub($self, $subobj)

Host implementation of $subobj's number substracted from $self's number. Returns $self.

=cut

sub host_sub {
    $_[0]->{_number} -= $_[1]->{_number};
    return $_[0];
}

=head2 host_inc_length($self)

Increase by one the length internal member of $self. This will be the host representation of a number of characters, used to evaluate internal number. Returns $self.

=cut

sub host_inc_length {
    ++$_[0]->{_length};
    return $_[0];
}

=head2 new_from_length($self)

Returns a new instance derived from the length internal member, initialized using host_int(). Returns the new object instance.

=cut

sub new_from_length {
    return $_[0]->clone_init->host_int("$_[0]->{_length}");
}

=head2 value($self)

Returns the internal $self's number hosted in $self. The output is understandable only by the host.

=cut

sub value {
  return $_[0]->{_number};
}

=head2 host_set_value($self, $value)

Sets the internal $self's number hosted in $self. Returns $self.

=cut

sub host_set_value {
    $_[0]->{_number} = $_[1];
    return $_[0];
}

=head2 is_zero($class, $value)

Class method that returns true or false if $value is zero. In case $value would be a blessed object, $value->is_zero() is returned if $value can do this method, otherwise undef is returned.

=cut

sub is_zero {
    my $blessed = blessed($_[1]) || '';
    if (! $blessed) {
	#
	# float_is_zero never fails
	#
	return Data::Float::float_is_zero($_[1]);
    } elsif ($_[1]->can('is_zero')) {
	return $_[1]->is_zero();
    } else {
	return undef;
    }
}

=head2 host_is_zero($self)

Returns a true value if $self is hosting a zero number, false otherwise.

=cut

sub host_is_zero {
    return $_[0]->is_zero($_[0]->value);
}

=head2 is_pos_one($class, $value)

Class method that returns true or false if $value is positive one. In case $value would be a blessed object, $value->is_one() is returned if $value can do this method, otherwise undef is returned.

=cut

sub is_pos_one {
    my $blessed = blessed($_[1]) || '';
    if (! $blessed) {
	return ($_[1] == $POS_ONE) ? 1 : 0;
    } elsif ($_[1]->can('is_one')) {
	return $_[1]->is_one();
    } else {
	return undef;
    }
}

=head2 host_is_pos_one($self)

Returns a true value if $self is hosting a positive one, false otherwise.

=cut

sub host_is_pos_one {
    return $_[0]->is_pos_one($_[0]->value);
}

=head2 is_neg_one($class, $value)

Class method that returns true or false if $value is negative one. In case $value would be a blessed object, $value->is_one('-') is returned if $value can do this method, otherwise undef is returned.

=cut

sub is_neg_one {
    my $blessed = blessed($_[1]) || '';
    if (! $blessed) {
	return ($_[1] == $NEG_ONE) ? 1 : 0;
    } elsif ($_[1]->can('is_one')) {
	return $_[1]->is_one('-');
    } else {
	return undef;
    }
}

=head2 host_is_neg_one($self)

Returns a true value if $self is hosting a negative one, false otherwise.

=cut

sub host_is_neg_one {
    return $_[0]->is_neg_one($_[0]->value);
}

=head2 is_pos($class, $value)

Class method that returns a true value if $value is a positive number, false otherwise. In case $value would be a blessed object, $value->is_pos() is returned if $value can do this method, otherwise undef is returned.

=cut

sub is_pos {
    my $blessed = blessed($_[1]) || '';
    if (! $blessed) {
      if ($_[0]->is_nan($_[1])) {
        return 0;
      } else {
        return (Data::Float::signbit($_[1]) == 0) ? 1 : 0;
      }
    } elsif ($_[1]->can('is_pos')) {
	return $_[1]->is_pos();
    } else {
	return undef;
    }
}

=head2 host_is_pos($self)

Returns a true value if $self is hosting a positive number, false otherwise.

=cut

sub host_is_pos {
    return $_[0]->is_pos($_[0]->value);
}

=head2 is_neg($class, $value)

Class method that returns true if $value is a negative number, false otherwise. In case $value would be a blessed object, $value->is_neg() is returned if $value can do this method, otherwise undef is returned.

=cut

sub is_neg {
    my $blessed = blessed($_[1]) || '';
    if (! $blessed) {
      if ($_[0]->is_nan($_[1])) {
        return 0;
      } else {
        return (Data::Float::signbit($_[1]) == 0) ? 0 : 1;
      }
    } elsif ($_[1]->can('is_neg')) {
	return $_[1]->is_neg();
    } else {
	return undef;
    }
}

=head2 host_is_neg($self)

Returns a true value if $self is hosting a negative number, false otherwise.

=cut

sub host_is_neg {
    return $_[0]->is_neg($_[0]->value);
}

=head2 is_infinite($class, $value)

Class method that returns true or false if $value is infinite. In case $value would be a blessed object, $value->is_inf() is returned if $value can do this method, otherwise undef is returned.

=cut

sub is_infinite {
    my $blessed = blessed($_[1]) || '';
    if (! $blessed) {
	#
	# isinf() never fails
	#
	return isinf($_[1]);
    } elsif ($_[1]->can('is_inf')) {
	return $_[1]->is_inf();
    } else {
	return undef;
    }
}

=head2 host_is_infinite($self)

Returns true or false if $self is hosting an infinite value or not, respectively.

=cut

sub host_is_infinite {
    return $_[0]->is_infinite($_[0]->value);
}

=head2 is_inf($class, $value)

Proxy method to is_infinite.

=cut

sub is_inf {
    return $_[0]->is_infinite($_[1]);
}

=head2 host_is_inf($self)

Proxy method to is_infinite($self).

=cut

sub host_is_inf {
    return $_[0]->host_is_infinite();
}

=head2 is_nan($class, $value)

Class method that returns true or false if $value is NaN. In case $value would be a blessed object, $value->is_nan() is returned if $value can do this method, otherwise undef is returned.

=cut

sub is_nan {
    my $blessed = blessed($_[1]) || '';
    if (! $blessed) {
	#
	# isnan() never fails
	#
	return isnan($_[1]);
    } elsif ($_[1]->can('is_nan')) {
	return $_[1]->is_nan();
    } else {
	return undef;
    }
}

=head2 host_is_nan($self)

Returns true or false if $self is hosting a NaN or not, respectively.

=cut

sub host_is_nan {
    return $_[0]->is_nan($_[0]->value);
}

1;
