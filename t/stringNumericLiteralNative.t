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
    'ff'         => sub {my $rc = shift; ok(Data::Float::float_is_nan($rc), 'input: "ff"' . "=> $rc")},
    '09'         => sub {my $rc = shift; ok("$rc" == 9, 'input: "09"' . "=> $rc")},
    '+09'        => sub {my $rc = shift; ok("$rc" == 9, 'input: "+09"' . "=> $rc")},
    '-000000009' => sub {my $rc = shift; ok("$rc" == -9, 'input: "-000000009"' . "=> $rc")},
    '          ' => sub {my $rc = shift; ok(Data::Float::float_is_zero($rc), 'input: "          "' . "=> $rc")},
    "    \n    " => sub {my $rc = shift; ok(Data::Float::float_is_zero($rc), 'input: "    \n    "' . "=> $rc")},
    '123.85'     => sub {my $rc = shift; ok("$rc" == 123.85, 'input: "123.85"' . "=> $rc")},
    '0123.85'    => sub {my $rc = shift; ok("$rc" == 123.85, 'input: "0123.85"' . "=> $rc")},
    '0123.085'   => sub {my $rc = shift; ok("$rc" == 123.085, 'input: "0123.085"' . "=> $rc")},
    '0123.0850'  => sub {my $rc = shift; ok("$rc" == 123.0850, 'input: "0123.0850"' . "=> $rc")},
    '$123.85'    => sub {my $rc = shift; ok(Data::Float::float_is_nan($rc), 'input: "$123.85"' . "=> $rc")},
    'three'      => sub {my $rc = shift; ok(Data::Float::float_is_nan($rc), 'input: "three"' . "=> $rc")},
    '0xFF'       => sub {my $rc = shift; ok("$rc" == 0xFF, 'input: "0xFF"' . "=> $rc")},
    '3.14'       => sub {my $rc = shift; ok("$rc" == 3.14, 'input: "3.14' . "=> $rc")},
    '0.0314E+02' => sub {my $rc = shift; ok("$rc" == 3.14, 'input: "0.0314E+02"' . "=> $rc")},
    '.0314E+02'  => sub {my $rc = shift; ok("$rc" == 3.14, 'input: ".0314E+02"' . "=> $rc")},
    '314.E-2'    => sub {my $rc = shift; ok("$rc" == 3.14, 'input: "314.E-2"' . "=> $rc")},
    '314.E-0002' => sub {my $rc = shift; ok("$rc" == 3.14, 'input: "314.E-0002"' . "=> $rc")},
    '00314.E-02' => sub {my $rc = shift; ok("$rc" == 3.14, 'input: "00314.E-02"' . "=> $rc")},
    " 1.0 "      => sub {my $rc = shift; ok("$rc" == 1, 'input: " 1.0 "' . "=> $rc")},
    ""           => sub {my $rc = shift; ok(Data::Float::float_is_zero($rc), 'input: ""' . "=> $rc")},
    );
foreach (keys %DATA) {
    my $value;
    if (length("$_") <= 0) {
	$value = Data::Float::pos_zero();
    } else {
	eval{
	    my $parse = $stringNumericLiteral->{grammar}->parse("$_",
								$stringNumericLiteral->{impl});
	    $value = $stringNumericLiteral->{grammar}->value($stringNumericLiteral->{impl});
	};
        if ($@) {
            $value = Data::Float::nan();
        }
    }
    $DATA{$_}($value);
}

done_testing(1 + scalar(keys %DATA));
