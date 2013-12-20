use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Program::Singleton;
use base 'Class::Singleton';

# ABSTRACT: ECMAScript-262, Edition 5, singleton for lexical program grammar

# VERSION

=head1 DESCRIPTION

This modules is a singleton used for caching the compiled Marpa grammar of a Program LHS, as per ECMAScript 262, Edition 5.

=cut

sub _new_instance {
    my ($class, $G) = @_;
    my $self  = bless {_G => $G }, $class;
    return $self;
}

sub G {
    my ($self) = @_;
    return $self->{_G};
}

1;
