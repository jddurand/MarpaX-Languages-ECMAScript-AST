#!perl
use strict;
use warnings FATAL => 'all';
use Test::More;
use Data::Float qw//;

BEGIN {
    use_ok( 'MarpaX::Languages::ECMAScript::AST' ) || print "Bail out!\n";
}

my $ecmaAst = MarpaX::Languages::ECMAScript::AST->new();
my $stringNumericLiteral = $ecmaAst->stringNumericLiteral;

my %DATA = (
    'ff'         => sub {ok(Data::Float::float_is_nan(shift))},
    '09'         => sub {is(shift, 9)},
    '+09'        => sub {is(shift, 9)},
    '-000000009' => sub {is(shift, -9)},
    '          ' => sub {ok(Data::Float::float_is_zero(shift))},
    "    \n    " => sub {ok(Data::Float::float_is_zero(shift))},
    '123.85'     => sub {is(shift, 123.85)},
    '0123.85'    => sub {is(shift, 123.85)},
    '0123.085'   => sub {is(shift, 123.085)},
    '0123.0850'  => sub {is(shift, 123.0850)},
    '$123.85'    => sub {ok(Data::Float::float_is_nan(shift))},
    'three'      => sub {ok(Data::Float::float_is_nan(shift))},
    '0xFF'       => sub {is(shift, 255)},
    '3.14'       => sub {is(shift, 3.14)},
    '0.0314E+02' => sub {is(shift, 3.14)},
    '.0314E+02'  => sub {is(shift, 3.14)},
    '314.E-2'    => sub {is(shift, 3.14)},
    '314.E-0002' => sub {is(shift, 3.14)},
    '00314.E-02' => sub {is(shift, 3.14)},
    " 1.0 "      => sub {is(shift, 1)},
    ""           => sub {ok(Data::Float::float_is_zero(shift))},
    );
foreach (keys %DATA) {
    my $value;
    if (length("$_") <= 0) {
	$value = Data::Float::pos_zero;
    } else {
	eval{
	    my $parse = $stringNumericLiteral->{grammar}->parse("$_",
								$stringNumericLiteral->{impl});
	    $value = $stringNumericLiteral->{grammar}->value($stringNumericLiteral->{impl});
	};
	$value = $@ ? Data::Float::nan : $value->value;
    }
    $DATA{$_}($value);
}

done_testing(1 + scalar(keys %DATA));
