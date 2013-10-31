use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Program::Actions;

# ABSTRACT: ECMAScript 262, Edition 5, lexical expressions grammar actions

# VERSION

use constant AST => 'MarpaX::Languages::ECMAScript::AST';

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

=head2 DecimalLiteral($self, $lexeme)

Bless lexeme to a DecimalLiteral.

=cut

sub DecimalLiteral {
    my $self = shift;
    return bless(shift, AST . '::DecimalLiteral');
}

=head2 HexIntegerLiteral($self, $lexeme)

Bless lexeme to a HexIntegerLiteral.

=cut

sub HexIntegerLiteral {
    my $self = shift;
    return bless(shift, AST . '::HexIntegerLiteral');
}

=head2 OctalIntegerLiteral($self, $lexeme)

Bless lexeme to a OctalIntegerLiteral.

=cut

sub OctalIntegerLiteral {
    my $self = shift;
    return bless(shift, AST . '::OctalIntegerLiteral');
}

=head2 concat($self)

Concatenate arguments. Use for tests.

=cut

sub concat {
    my $self = shift;

    return join ('', grep {defined($_)} @_);
}

1;
