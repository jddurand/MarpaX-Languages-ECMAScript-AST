use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST;

# ABSTRACT: Translate a ECMAScript source to an AST

use Carp qw/croak/;
use MarpaX::Languages::ECMAScript::AST::Grammar qw//;
use Digest::MD4 qw/md4_hex/;
use CHI;
use File::HomeDir;

our $distname = __PACKAGE__;
$distname =~ s/::/-/g;

our $cache = CHI->new(driver => 'File',
                      root_dir => File::HomeDir->my_dist_data($distname, { create => 1 } ),
                      label => __PACKAGE__,
                      namespace => __PACKAGE__,
		      max_key_length => 32);

# VERSION

=head1 DESCRIPTION

This module translates ECMAScript source into an AST tree. To assist further process of the AST tree, the nodes of the AST are blessed according to the ECMAScript grammar you have selected. (The default is 'ECMAScript-262-5'.) If you want to enable logging, be aware that this module is using Log::Any.

=head1 SYNOPSIS

    use strict;
    use warnings FATAL => 'all';
    use MarpaX::Languages::ECMAScript::AST;
    use Log::Log4perl qw/:easy/;
    use Log::Any::Adapter;
    use Log::Any qw/$log/;
    #
    # Init log
    #
    our $defaultLog4perlConf = '
    log4perl.rootLogger              = WARN, Screen
    log4perl.appender.Screen         = Log::Log4perl::Appender::Screen
    log4perl.appender.Screen.stderr  = 0
    log4perl.appender.Screen.layout  = PatternLayout
    log4perl.appender.Screen.layout.ConversionPattern = %d %-5p %6P %m{chomp}%n
    ';
    Log::Log4perl::init(\$defaultLog4perlConf);
    Log::Any::Adapter->set('Log4perl');
    #
    # Parse ECMAScript
    #
    my $ecmaSourceCode = 'var i = 0;';
    my $ecmaAstObject = MarpaX::Languages::ECMAScript::AST->new();
    $log->infof('%s', $ecmaAstObject->parse($ecmaSourceCode));

=head1 SUBROUTINES/METHODS

=head2 new($class, %options)

Instantiate a new object. Takes as parameter an optional hash of options that can be:

=over

=item grammarName

Name of a grammar. Default is 'ECMAScript-262-5'.

=item cache

Produced AST can be cached: very often the same ECMAScript is used again and again, so there is no need to always compute it at each call. The cache key is the buffer MD4 checksum, eventual collisions being handled. The cache location is the my_dist_data directory provided by File::HomeDir package. Default is a true value.

=back

=cut

# ----------------------------------------------------------------------------------------
sub new {
  my ($class, %opts) = @_;

  my $grammarName = $opts{grammarName} || 'ECMAScript-262-5';
  my $cache       = $opts{cache} // 1;

  my $self  = {
      _grammarName => $grammarName,
      _cache       => $cache
  };

  bless($self, $class);

  return $self;
}

# ----------------------------------------------------------------------------------------

=head2 parse($self, $source)

Get and AST from the ECMAScript source, pointed by $source. This method will call all the intermediary steps (lexical, transformation, evaluation) necessary to produce the AST.

=cut

sub parse {
  my ($self, $source) = @_;

  my $parse = sub {
      if (! defined($self->{_grammar})) {
	  $self->{_grammar} = MarpaX::Languages::ECMAScript::AST::Grammar->new($self->{_grammarName});
      }
      my $grammar     = $self->{_grammar}->program->{grammar};
      my $impl        = $self->{_grammar}->program->{impl};

      return $grammar->parse($source, $impl)->value($impl);
  };

  #
  # If cache is enabled, compute the MD4 and check availability
  #
  if ($self->{_cache}) {
      my $md4 = md4_hex($source);
      my $hashp = $cache->get($md4) || {};
      my $ast = $hashp->{$source} || undef;
      if (defined($ast)) {
	  return $ast;
      }
      $hashp->{$source} = &$parse();
      $cache->set($md4, $hashp);
      return $hashp->{$source};
  } else {
      return &$parse();
  }
}

=head1 SEE ALSO

L<Log::Any>, L<Marpa::R2>, L<Digest::MD4>, L<CHI::Driver::File>

=cut

1;
