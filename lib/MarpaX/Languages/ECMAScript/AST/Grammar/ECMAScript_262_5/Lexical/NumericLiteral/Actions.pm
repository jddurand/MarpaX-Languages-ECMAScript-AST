use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::NumericLiteral::Actions;
use Math::BigInt;

# ABSTRACT: ECMAScript 262, Edition 5, lexical decimal grammar actions

# VERSION

=head1 DESCRIPTION

This modules give the actions associated to ECMAScript_262_5 lexical numeric grammar.

=cut

=head2 new($class)

Instantiate a new object.

=cut

sub new {
    my ($class) = @_;
    my $self = {};
    bless($self, $class);
    return $self;
}

1;
