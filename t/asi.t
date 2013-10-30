#!perl
use strict;
use warnings FATAL => 'all';
use Test::More;

BEGIN {
    use_ok( 'MarpaX::Languages::ECMAScript::AST' ) || print "Bail out!\n";
}

my %asi = (
    "{ 1 2 } 3" => undef,
    "{ 1
2 } 3" => "{ 1
;2 ;} 3;",
    "for (a; b
)" => undef,
    "return
a + b" => "return;
a + b;",
    "a = b
++c" => "a = b;
++c;",
    "if (a > b)
else c = d" => undef,
    "a = b + c
(d + e).print()" => "a = b + c
(d + e).print()"
);

foreach (keys %asi) {
    my $ecmaSourceCode = $_;
    my $ecmaAst = MarpaX::Languages::ECMAScript::AST->new();
    my $valuep;
    eval {$valuep = $ecmaAst->parse(\$ecmaSourceCode)};
    ok(defined($asi{$_}) ? defined($valuep) : ! defined($valuep), (defined($valuep) ? 'defined' : "<undef>"));
}

done_testing(1 + scalar(keys %asi));
