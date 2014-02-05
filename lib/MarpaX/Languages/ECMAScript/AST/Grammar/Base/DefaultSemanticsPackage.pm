use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::Base::DefaultSemanticsPackage;

# ABSTRACT: ECMAScript 262, Edition 5, default semantics package

# VERSION

=head1 DESCRIPTION

This modules give the default semantics package associated to any ECMAScript_262_5 lexical grammar.

=cut

=head2 new($class)

Instantiate a new object.

=cut

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    return $self;
}

1;
