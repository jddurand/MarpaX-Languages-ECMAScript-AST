#!perl
use strict;
use warnings FATAL => 'all';
use Test::More;
use Math::BigFloat;

#
# The "External" semantic package will force zero to nan
#

BEGIN {
    use_ok( 'MarpaX::Languages::ECMAScript::AST' ) || print "Bail out!\n";
}

my $ecmaAst = MarpaX::Languages::ECMAScript::AST->new(
    'StringNumericLiteral' => { semantics_package => 'MyActions'}
    );
my $stringNumericLiteral = $ecmaAst->stringNumericLiteral;

my %DATA = (
    'ff'         => sub {ok(shift->is_nan())},
    '09'         => sub {is(shift, 9)},
    '+09'        => sub {is(shift, 9)},
    '-000000009' => sub {is(shift, -9)},
     '          ' => sub {ok(shift->is_zero())},
    "    \n    " => sub {ok(shift->is_zero())},
    '123.85'     => sub {is(shift, 123.85)},
    '0123.85'    => sub {is(shift, 123.85)},
     '0123.085'   => sub {is(shift, 123.085)},
    '0123.0850'  => sub {is(shift, 123.0850)},
    '$123.85'    => sub {ok(shift->is_nan())},
    'three'      => sub {ok(shift->is_nan())},
    '0xFF'       => sub {is(shift, 255)},
    '3.14'       => sub {is(shift, 3.14)},
    '0.0314E+02' => sub {is(shift, 3.14)},
    '.0314E+02'  => sub {is(shift, 3.14)},
    '314.E-2'    => sub {is(shift, 3.14)},
    '314.E-0002' => sub {is(shift, 3.14)},
    '00314.E-02' => sub {is(shift, 3.14)},
    " 1.0 "      => sub {is(shift, 1)},
    ""           => sub {ok(shift->is_zero())},
    );
foreach (keys %DATA) {
    my $value;
    if (length("$_") <= 0) {
	$value = Math::BigFloat->new()->bzero();
    } else {
	eval{
	    my $parse = $stringNumericLiteral->{grammar}->parse("$_",
								$stringNumericLiteral->{impl});
	    $value = $stringNumericLiteral->{grammar}->value($stringNumericLiteral->{impl});
	};
        $value = $@ ? Math::BigFloat->new()->bnan() : $value->hostValue;
    }
    $DATA{$_}($value);
}

done_testing(1 + scalar(keys %DATA));

1;

#
# Example of externalized package where numbers are all Math::BigFloat objects.
#
package MyActions;
use Math::BigFloat;

use constant {
  DIGITS => 20,            # Number of significant digits
  ROUND => 'event'         # Round mode
};

sub pos_zero     { $_[0]->{_bigfloat}->bzero();                                                           return $_[0]; }
sub new          { return bless({_bigfloat => Math::BigFloat->new("0"), length => undef}, $_[0]);                       }
sub mul          { $_[0]->{_bigfloat}->bmul($_[1]->{_bigfloat});                                          return $_[0]; }
sub round        { $_[0]->{_bigfloat}->fround(DIGITS, ROUND);                                             return $_[0]; }
sub pos_infinity { $_[0]->{_bigfloat}->binf();                                                            return $_[0]; }
sub nan          { $_[0]->{_bigfloat}->bnan();                                                            return $_[0]; }
sub pow          { $_[0]->{_bigfloat}->bpow($_[1]->{_bigfloat});                                          return $_[0]; }
sub positive_int { $_[0]->{_bigfloat} = Math::BigFloat->new("$_[1]"); $_[0]->{_length} = length("$_[1]"); return $_[0]; }
sub positive_hex { $_[0]->{_bigfloat} = Math::BigFloat->new(hex("$_[1]"));                                return $_[0]; }
sub neg          { $_[0]->{_bigfloat}->bneg();                                                            return $_[0]; }
sub add          { $_[0]->{_bigfloat}->badd($_[1]->{_bigfloat});                                          return $_[0]; }
sub sub          { $_[0]->{_bigfloat}->bsub($_[1]->{_bigfloat});                                          return $_[0]; }
sub hostValue    { if ($#_ > 0) { $_[0]->{_bigfloat} = $_[1]->{_bigfloat}->bcopy(); }                     return $_[0]->{_bigfloat}; }
sub length       { if ($#_ > 0) { $_[0]->{_length} = $_[1]; }                                             return $_[0]->{_length}; }

