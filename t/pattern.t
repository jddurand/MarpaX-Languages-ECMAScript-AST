#!perl
use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::Differences;
use Data::Float;
    use Log::Log4perl qw/:easy/;
    use Log::Any::Adapter;
    use Log::Any qw/$log/;
    #
    # Init log
    #
    our $defaultLog4perlConf = '
    log4perl.rootLogger              = TRACE, Screen
    log4perl.appender.Screen         = Log::Log4perl::Appender::Screen
    log4perl.appender.Screen.stderr  = 0
    log4perl.appender.Screen.layout  = PatternLayout
    log4perl.appender.Screen.layout.ConversionPattern = %d %-5p %6P %m{chomp}%n
    ';
    Log::Log4perl::init(\$defaultLog4perlConf);
    Log::Any::Adapter->set('Log4perl');

BEGIN {
    use_ok( 'MarpaX::Languages::ECMAScript::AST' ) || print "Bail out!\n";
}

my $ecmaAst = MarpaX::Languages::ECMAScript::AST->new();
my $pattern = $ecmaAst->pattern;

my %DATA = (
    # reg                         str multiline ignoreCase   value
    #                                                        [lastPos, [ @matches ] ]
    'a|ab'                 => [ 'abc',        0,         0,  [ 1, [] ] ],
    '((a)|(ab))((c)|(bc))' => [ 'abc',        0,         0,  [ 3, ['a','a',undef,'bc',undef,'bc'] ] ],
    'a[a-z]{2,4}'          => [ 'abcdefghi',  0,         0,  [ 5, [] ] ],
    '(a[a-z]{2,4})'        => [ 'abcdefghi',  0,         0,  [ 5, ['abcde'] ] ],
    'a[a-z]{2,4}?'         => [ 'abcdefghi',  0,         0,  [ 3, [] ] ],
    '(a[a-z]{2,4}?)'       => [ 'abcdefghi',  0,         0,  [ 3, ['abc'] ] ],
    '(aa|aabaac|ba|b|c)*'  => [ 'aabaac',     0,         0,  [ 4, ['ba'] ] ],
    '(z)((a+)?(b+)?(c))*'  => [ 'zaacbbbcac', 0,         0,  [10, ['z', 'ac', 'a', undef, 'c'] ] ],
    '(a*)*'                => [ 'b',          0,         0,  [0, [undef] ] ],
    '(a*)b\1+'             => [ 'baaaac',     0,         0,  [1, [''] ] ],
    '(?=(a+))'             => [ 'baaabac',    0,         0,  0 ],
    '(?=(a+))'             => [ 'aaabac',     0,         0,   [3, ['aaa'] ] ],
    );
my $ntest = 0;
foreach (keys %DATA) {
    my $regexp = $_;
    my $parse = $pattern->{grammar}->parse($regexp, $pattern->{impl});
    my ($input, $multiline, $ignoreCase, $result) = @{$DATA{$_}};
    my $code = eval { $pattern->{grammar}->value($pattern->{impl}) };
    if ($@) {
	print STDERR $@;
	$code = sub {undef};
    }
    my $value = &$code($input, 0);
    eq_or_diff($value, $result, "/$regexp/.exec(\"$input\")");
}

done_testing(1 + scalar(keys %DATA));
