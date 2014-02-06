#!perl
use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::Differences;
use Data::Float;

BEGIN {
    use_ok( 'MarpaX::Languages::ECMAScript::AST' ) || print "Bail out!\n";
}

my $ecmaAst = MarpaX::Languages::ECMAScript::AST->new();
my $URI = $ecmaAst->URI;

my $ntest = 0;
my $URIText = do {local $/; my $DATA = <DATA>; $DATA =~ s/\s*$//; $DATA};
my $parse = $URI->{grammar}->parse($URIText, $URI->{impl});
my $value = eval { $URI->{grammar}->value($URI->{impl}) };
use Data::Dumper;
print STDERR Dumper($value);
++$ntest;

done_testing(1 + $ntest);

__DATA__
https://example.com/contoso/test/default.aspx
