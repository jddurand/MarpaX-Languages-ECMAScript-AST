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
    'ff'         => sub {my $rc = shift; ok($rc->is_nan(), 'input: "ff"' . "=> $rc")},
    '09'         => sub {my $rc = shift; ok(Math::BigFloat->new("9")->bcmp($rc) == 0, 'input: "09"' . "=> $rc")},
    '+09'        => sub {my $rc = shift; ok(Math::BigFloat->new("9")->bcmp($rc) == 0, 'input: "+09"' . "=> $rc")},
    '-000000009' => sub {my $rc = shift; ok(Math::BigFloat->new("-9")->bcmp($rc) == 0, 'input: "-000000009"' . "=> $rc")},
    '          ' => sub {my $rc = shift; ok($rc->is_zero(), 'input: "          "' . "=> $rc")},
    "    \n    " => sub {my $rc = shift; ok($rc->is_zero(), 'input: "    \n    "' . "=> $rc")},
    '123.85'     => sub {my $rc = shift; ok(Math::BigFloat->new("123.85")->bcmp($rc) == 0, 'input: "123.85"' . "=> $rc")},
    '0123.85'    => sub {my $rc = shift; ok(Math::BigFloat->new("123.85")->bcmp($rc) == 0, 'input: "0123.85"' . "=> $rc")},
    '0123.085'   => sub {my $rc = shift; ok(Math::BigFloat->new("123.085")->bcmp($rc) == 0, 'input: "0123.085"' . "=> $rc")},
    '0123.0850'  => sub {my $rc = shift; ok(Math::BigFloat->new("123.085")->bcmp($rc) == 0, 'input: "0123.0850"' . "=> $rc")},
    '$123.85'    => sub {my $rc = shift; ok($rc->is_nan(), 'input: "$123.85"' . "=> $rc")},
    'three'      => sub {my $rc = shift; ok($rc->is_nan(), 'input: "three"' . "=> $rc")},
    '0xFF'       => sub {my $rc = shift; ok(Math::BigFloat->from_hex("FF")->bcmp($rc) == 0, 'input: "0xFF"' . "=> $rc")},
    '3.14'       => sub {my $rc = shift; ok(Math::BigFloat->new("3.14")->bcmp($rc) == 0, 'input: "3.14' . "=> $rc")},
    '0.0314E+02' => sub {my $rc = shift; ok(Math::BigFloat->new("3.14")->bcmp($rc) == 0, 'input: "0.0314E+02"' . "=> $rc")},
    '.0314E+02'  => sub {my $rc = shift; ok(Math::BigFloat->new("3.14")->bcmp($rc) == 0, 'input: ".0314E+02"' . "=> $rc")},
    '314.E-2'    => sub {my $rc = shift; ok(Math::BigFloat->new("3.14")->bcmp($rc) == 0, 'input: "314.E-2"' . "=> $rc")},
    '314.E-0002' => sub {my $rc = shift; ok(Math::BigFloat->new("3.14")->bcmp($rc) == 0, 'input: "314.E-0002"' . "=> $rc")},
    '00314.E-02' => sub {my $rc = shift; ok(Math::BigFloat->new("3.14")->bcmp($rc) == 0, 'input: "00314.E-02"' . "=> $rc")},
    " 1.0 "      => sub {my $rc = shift; ok(Math::BigFloat->bone->bcmp($rc) == 0, 'input: " 1.0 "' . "=> $rc")},
    ""           => sub {my $rc = shift; ok($rc->is_zero(), 'input: ""' . "=> $rc")},
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
        if ($@) {
            $value = Math::BigFloat->new()->bnan();
        }
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
use Scalar::Util qw/blessed/;

#
# Precision nor accurracy being setted, default applied, i.e. up to 40 digits.
# Fair enough.

use constant {
  ACCURACY => 20,          # Number of significant digits
  ROUND_MODE => 'even'     # Round mode
};

sub host_pos_zero        { $_[0]->{_bigfloat}->bzero();                                                           return $_[0]; }
sub new                  { return bless({_bigfloat => Math::BigFloat->new("0"), length => 0}, $_[0]);                           }
sub host_mul             { $_[0]->{_bigfloat}->bmul($_[1]->{_bigfloat});                                          return $_[0]; }
sub host_round           { $_[0]->{_bigfloat}->round(ACCURACY, undef, ROUND_MODE);                                return $_[0]; }
sub host_pos_inf         { $_[0]->{_bigfloat}->binf();                                                            return $_[0]; }
sub host_pow             { $_[0]->{_bigfloat}->bpow($_[1]->{_bigfloat});                                          return $_[0]; }
sub host_int             { $_[0]->{_bigfloat} = Math::BigFloat->new("$_[1]"); $_[0]->{_length} = length("$_[1]"); return $_[0]; }
sub host_hex             { $_[0]->{_bigfloat} = Math::BigFloat->new(hex("$_[1]"));                                return $_[0]; }
sub host_neg             { $_[0]->{_bigfloat}->bneg();                                                            return $_[0]; }
sub host_add             { $_[0]->{_bigfloat}->badd($_[1]->{_bigfloat});                                          return $_[0]; }
sub host_sub             { $_[0]->{_bigfloat}->bsub($_[1]->{_bigfloat});                                          return $_[0]; }
sub host_inc_length      { ++$_[0]->{_length};                                                                    return $_[0]; }
sub host_new_from_length { return $_[0]->host_class->new->host_int("$_[0]->{_length}");                                         }
sub host_class           { return blessed($_[0]);                                                                               }
sub host_value           { return $_[0]->{_bigfloat};                                                                           }
