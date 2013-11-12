use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST;

# ABSTRACT: Translate a ECMAScript source to an AST

use MarpaX::Languages::ECMAScript::AST::Grammar qw//;
use Digest::MD4 qw/md4_hex/;
use CHI;
use File::HomeDir;
use version 0.77;
use Log::Any qw/$log/;
use Module::Util qw/find_installed/;
use File::Basename qw/dirname/;
use File::Spec;

our $distname = __PACKAGE__;
$distname =~ s/::/-/g;

our $CACHE = CHI->new(driver => 'File',
                      root_dir => File::HomeDir->my_dist_data($distname, { create => 1 } ),
                      label => __PACKAGE__,
                      namespace => 'cache',
		      max_key_length => 32);

# VERSION
our $CURRENTVERSION;
{
  #
  # Because $VERSION is generated by dzil, not available in dev. tree
  #
  no strict 'vars';
  $CURRENTVERSION = $VERSION;
}

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

Produced AST can be cached: very often the same ECMAScript is used again and again, so there is no need to always compute it at each call. The cache key is the buffer MD4 checksum, eventual collisions being handled. The cache location is the my_dist_data directory provided by File::HomeDir package. Default is a false value.

=back

=cut

# ----------------------------------------------------------------------------------------
sub new {
  my ($class, %opts) = @_;

  my $grammarName = $opts{grammarName} || 'ECMAScript-262-5';
  my $cache       = $opts{cache} // 0;

  my $self  = {
      _grammarName => $grammarName,
      _cache       => $cache
  };

  bless($self, $class);

  $self->_init();

  return $self;
}

sub _init {
    my ($self) = @_;

    $self->{_grammar} = MarpaX::Languages::ECMAScript::AST::Grammar->new($self->{_grammarName});
}

# ----------------------------------------------------------------------------------------

=head2 describe($self)

Get a description of the G1 grammar. Returns a reference to hash, that has this structure: key => value, where

=over

=item key

'G1' or 'G0', with value being a reference to all rules, LHS being the first.

=back

=cut

sub describe {
    my ($self) = @_;

    my $impl = $self->{_grammar}->program->{impl};
    my %g0 = ();
    foreach ($impl->rule_ids('G0')) {
      $g0{$_} = [ map {$impl->symbol_name($_, 'G0')} $impl->rule_expand($_, 'G0') ];
    }
    my %g1 = ();
    foreach ($impl->rule_ids('G1')) {
      $g1{$_} = [ map {$impl->symbol_name($_, 'G1')} $impl->rule_expand($_, 'G1') ];
    }

    return { G0 => \%g0, G1 => \%g1 };
}

# ----------------------------------------------------------------------------------------

=head2 grammarAlias($self)

Returns the grammar alias, i.e. the one that is used within this distribution, corresponding to a true directory on the filesystem.

=cut

sub grammarAlias {
  my ($self) = @_;

  return $self->{_grammar}->grammarAlias;

}

# ----------------------------------------------------------------------------------------

=head2 templatePath($self)

Returns the templates absolute path.

=cut

sub templatePath {
  my ($self) = @_;

  return File::Spec->catdir(dirname(find_installed(__PACKAGE__)), 'AST', 'Grammar',  $self->{_grammar}->grammarAlias, 'Template');
}

# ----------------------------------------------------------------------------------------

=head2 parse($self, $source)

Get and AST from the ECMAScript source, pointed by $source. This method will call all the intermediary steps (lexical, transformation, evaluation) necessary to produce the AST.

=cut

sub _getAndCheckHashFromCache {
  my ($self, $md4, $source, $astp, $fromCachep) = @_;

  my $rc = 0;

  my $fromCache = $CACHE->get($md4);
  if (defined($fromCache)) {
    my $clearCache = 1;
    my $store;
    if (ref($fromCache) eq 'HASH') {
      $store = $fromCache->{$source};
      if (defined($store)) {
        if (ref($store) eq 'HASH') {
          my $storeVersion = $store->{version};
          #
          # Trying to get from cache using the dev files will always clear the cache -;
          #
          if (defined($storeVersion) && defined($CURRENTVERSION)) {
            if (version::is_lax($storeVersion) && version::is_lax($CURRENTVERSION)) {
              if (version->parse($storeVersion) == version->parse($CURRENTVERSION)) {
                my $ast = $store->{ast};
                if (defined($ast)) {
                  $log->tracef('cache ok, storeVersion=%s', $storeVersion);
                  $rc = 1;
                  ${$astp} = $ast;
                  ${$fromCachep} = $fromCache;
                  $clearCache = 0;
                } else {
                  $log->tracef('cache ko, ast undefined');
                }
              } else {
                $log->tracef('cache ko, storeVersion %s != %s (current version)', $storeVersion, $CURRENTVERSION);
              }
            } else {
              #
              # In case versions are really garbled, use %s instead of %d
              #
              $log->tracef('cache ko, storeVersion %s (is_lax=%s), current version %s (is_lax=%s)', $storeVersion, version::is_lax($storeVersion) || '', $CURRENTVERSION, version::is_lax($CURRENTVERSION) || '');
            }
          } else {
            $log->tracef('cache ko, storeVersion %s, current version %s', $storeVersion || 'undefined', $CURRENTVERSION || 'undefined');
          }
        } else {
          $log->tracef('cache ko, store is a %s', ref($store));
        }
      } else {
        $log->tracef('cache ko, no entry for given source code');
      }
    } else {
      $log->tracef('cache ko, $fromCache is a %s', ref($fromCache));
    }
    if ($clearCache) {
      if (ref($fromCache) eq 'HASH') {
        #
        # Invalid data
        #
        if (defined($store)) {
          delete($fromCache->{$source});
          $CACHE->set($md4, $fromCache);
          $log->tracef('cache cleaned');
        }
      } else {
        #
        # Invalid cache
        #
        $CACHE->remove($md4);
        $log->tracef('cache removed');
      }
    }
  } else {
    $log->tracef('cache ko, no cache for md4 %s', $md4);
  }

  return $rc;
}

sub parse {
  my ($self, $source) = @_;

  my $parse = sub {
      my $grammar     = $self->{_grammar}->program->{grammar};
      my $impl        = $self->{_grammar}->program->{impl};

      return $grammar->parse($source, $impl)->value($impl);
  };

  #
  # If cache is enabled, compute the MD4 and check availability
  #
  my $ast;
  if ($self->{_cache}) {
    my $md4 = md4_hex($source);
    my $fromCache = {};
    if (! $self->_getAndCheckHashFromCache($md4, $source, \$ast, \$fromCache)) {
      $ast = &$parse();
      if (defined($CURRENTVERSION)) {
        $fromCache->{$source} = {ast => $ast, version => $CURRENTVERSION};
        $CACHE->set($md4, $fromCache);
      }
    }
  } else {
    $ast = &$parse();
  }

  return $ast;
}

# ----------------------------------------------------------------------------------------

=head2 template($self)

Return the generic template for this grammar. This template is doing nothing else but reproduce an ECMAScript source that, if parsed, would have an AST similar to the original source.

=cut

sub template {
  my ($self) = @_;

  return $self->{_grammar}->template;
}

=head1 SEE ALSO

L<Log::Any>, L<Marpa::R2>, L<Digest::MD4>, L<CHI::Driver::File>

=cut

1;
