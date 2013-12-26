#!perl
use strict;
use warnings FATAL => 'all';
use Test::More;
use Data::Float qw//;

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
    '          ' => sub {ok(Data::Float::float_is_nan(shift))},   # NOT ZERO!
    "    \n    " => sub {ok(Data::Float::float_is_nan(shift))},   # NOT ZERO!
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
	$value = $@ ? Data::Float::nan : $value->hostValue;
    }
    $DATA{$_}($value);
}

done_testing(1 + scalar(keys %DATA));

#
# Example of externalized package where I force pos_zero to return nan
#
package MyActions;
use parent 'MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::DefaultSemanticsPackage';
use SUPER;
use Data::Float qw//;

sub pos_zero {
     $_[0]->{_number} = Data::Float::nan;
     return $_[0];
}

sub new          { super }
sub mul          { super }
sub round        { super }
sub pos_infinity { super }
sub nan          { super }
sub pow          { super }
sub positive_int { super }
sub positive_hex { super }
sub neg          { super }
sub add          { super }
sub sub          { super }
sub value        { super }
sub length       { super }

1;
