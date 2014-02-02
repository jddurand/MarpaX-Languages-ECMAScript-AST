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
print STDERR "IMPL is $pattern->{impl}\n";
print STDERR "PATTERN is $pattern\n";
print STDERR "PATTERN GRAMMAR is $pattern->{grammar}\n";

my %DATA = (
    # reg        str multiline ignoreCase  value
    '(a|ab)' => [ 'abc',       0,         0,  'a' ]
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