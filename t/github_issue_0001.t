#!perl
use strict;
use warnings FATAL => 'all';
use Test::More;
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

my $x = MarpaX::Languages::ECMAScript::AST->new->parse(<< 'EoC');
    x = 42;
    /* Allo */
    bluh = function() {
        // Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
        // sed do eiusmod tempor incididunt ut labore et dolore
        // magna aliqua. Ut enim ad minim veniam, quis nostrud
        // exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
};
EoC

ok(defined($x), 'Code that throws a "subexpression recursion limit exception". (github issue #1)');
done_testing(2);
