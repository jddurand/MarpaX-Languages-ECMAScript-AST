#!perl
use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::Differences;

BEGIN {
    use_ok( 'MarpaX::Languages::ECMAScript::AST' ) || print "Bail out!\n";
}

my $ecmaAst = MarpaX::Languages::ECMAScript::AST->new();
my $pattern = $ecmaAst->pattern;

my %DATA = (
    # reg                            input multiline ignoreCase   Value
    #                                                             [lastPos, [ @matches ] ]
    'a|ab'                     => [[ 'abc',        0,         0,  [ 1, [] ] ],
                                  ],
    '((a)|(ab))((c)|(bc))'     => [[ 'abc',        0,         0,  [ 3, ['a','a',undef,'bc',undef,'bc'] ] ],
                                  ],
    'a[a-z]{2,4}'              => [[ 'abcdefghi',  0,         0,  [ 5, [] ] ],
                                  ],
    '(a[a-z]{2,4})'            => [[ 'abcdefghi',  0,         0,  [ 5, ['abcde'] ] ],
                                  ],
    'a[a-z]{2,4}?'             => [[ 'abcdefghi',  0,         0,  [ 3, [] ] ],
                                  ],
    '(a[a-z]{2,4}?)'           => [[ 'abcdefghi',  0,         0,  [ 3, ['abc'] ] ],
                                  ],
    '(aa|aabaac|ba|b|c)*'      => [[ 'aabaac',     0,         0,  [ 4, ['ba'] ] ],
                                  ],
    '(z)((a+)?(b+)?(c))*'      => [[ 'zaacbbbcac', 0,         0,  [10, ['z', 'ac', 'a', undef, 'c'] ] ],
                                  ],
    '(a*)*'                    => [[ 'b',          0,         0,  [ 0, [undef] ] ],
                                  ],
    '(a*)b\1+'                 => [[ 'baaaac',     0,         0,  [ 1, [''] ] ],
                                  ],
    '(?=(a+))'                 => [[ 'baaabac',    0,         0,    0 ],
                                  ],
    '(?=(a+))'                 => [[ 'aaabac',     0,         0,  [ 0, ['aaa'] ] ],
                                  ],
    '(?=(a+))a*b\1'            => [[ 'abac',       0,         0,  [ 3, ['a'] ] ],
                                  ],
    '(.*?)a(?!(a+)b\2c)\2(.*)' => [[ 'baaabaac',   0,         0,  [ 8, ['ba', undef, 'abaac'] ] ],
                                  ],
    '(?:(ABC)|(123)){2}'       => [[ 'ABC123',     0,         0,  [ 6, [undef, '123'] ] ],
                                  [  '123ABC',     0,         0,  [ 6, ['ABC', undef] ] ],
                                  ],
    '\\d{3}\\-?\\d{2}\\-?\\d{4}' => [[ '123-45-6789', 0,      0,  [11, [] ] ],
                                  ],
    );
my $ntest = 0;
foreach (keys %DATA) {
    my $regexp = $_;
    my $parse = $pattern->{grammar}->parse($regexp, $pattern->{impl});
    my $code = eval { $pattern->{grammar}->value($pattern->{impl}) };
    if ($@) {
        print STDERR $@;
        $code = sub {undef};
    }
    foreach (@{$DATA{$_}}) {
	my ($input, $multiline, $ignoreCase, $result) = @{$_};
	++$ntest;
	my $value = &$code($input, 0);
	eq_or_diff($value, $result, "/$regexp/.exec(\"$input\")");
    }
}

done_testing(1 + $ntest);
