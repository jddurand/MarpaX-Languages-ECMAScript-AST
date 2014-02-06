use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Impl::Singleton;
use base 'Class::Singleton';
use Sereal qw/encode_sereal decode_sereal/;
use Data::Compare qw//;
use Marpa::R2 2.078000;
use Log::Any qw/$log/;

# ABSTRACT: Singleton hosting all the grammar precompiled Marpa::R2::Scanless::G objects

# VERSION

=head1 DESCRIPTION

This modules is a singleton used for caching all precompiled Marpa::R2::Scanless::G objects.

=cut

sub _new_instance {
    my ($class) = @_;
    my $self  = bless {_G => {} }, $class;
    return $self;
}

=head1 SUBROUTINES/METHODS

=head2 G($self, $grammarOptionsHashp)

Cached Marpa::R2::Scanless::G object for grammar with options $grammarOptionsHashp.

=cut

sub G {
    my ($self, $grammarOptionsHashp) = @_;

    $grammarOptionsHashp //= {};

    $log->debugf('01: %d keys', scalar(keys %{$self->{_G}}));

    #
    # Search the key
    #
    my $key = undef;
    foreach (keys %{$self->{_G}}) {
      $log->debugf('02: %d keys', scalar(keys %{$self->{_G}}));
      my $thisKey = $_;
      my $thisOptionsHashp = decode_sereal($thisKey);
      my $c = new Data::Compare($grammarOptionsHashp, $thisOptionsHashp);
      if ($c->Cmp) {
        $key = $thisKey;
        last;
      }
    }
    #
    # Create a new key if necessary
    #
    if (! defined($key)) {
      $log->debugf('03: Creating key');
      $key = encode_sereal($grammarOptionsHashp);
    }

    if (! defined($self->{_G}->{$key})) {
      #
      # Create the grammar object
      #
      $log->debugf('04: Creating grammar object');
      $self->{_G}->{$key} = Marpa::R2::Scanless::G->new($grammarOptionsHashp);
    } else {
      $log->debugf('05: Found grammar object');
    }

    $log->debugf('06: %d keys', scalar(keys %{$self->{_G}}));

    return $self->{_G}->{$key};
}

1;
