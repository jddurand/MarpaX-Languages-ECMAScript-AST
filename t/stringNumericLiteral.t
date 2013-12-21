#!perl
use strict;
use warnings FATAL => 'all';
use Test::More;

BEGIN {
    use_ok( 'MarpaX::Languages::ECMAScript::AST' ) || print "Bail out!\n";
}

my $ecmaAst = MarpaX::Languages::ECMAScript::AST->new();
my $stringNumericLiteral = $ecmaAst->stringNumericLiteral;
my $parse = $stringNumericLiteral->{grammar}->parse(" 1.0 ",
						  $stringNumericLiteral->{impl});
my $value = $stringNumericLiteral->{grammar}->value($stringNumericLiteral->{impl});
use Data::Dumper;
print STDERR Dumper($value);

done_testing(1);
