use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Program::Actions;

# ABSTRACT: ECMAScript 262, Edition 5, lexical expressions grammar actions

# VERSION

=head1 DESCRIPTION

This modules give the actions associated to ECMAScript_262_5 lexical expressions grammar.

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

=head2 concat($self)

Concatenate arguments. Use for tests.

=cut

sub concat {
    my $self = shift;

    return join ('', grep {defined($_)} @_);
}

1;
