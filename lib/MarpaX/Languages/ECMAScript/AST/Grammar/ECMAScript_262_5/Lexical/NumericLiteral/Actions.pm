use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::NumericLiteral::Actions;

# ABSTRACT: ECMAScript 262, Edition 5, lexical decimal grammar actions

# VERSION

=head1 DESCRIPTION

This modules give the actions associated to ECMAScript_262_5 lexical numeric grammar.

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

=head2 MV_NumericLiteral_DecimalLiteral($self, $DecimalLiteral)

MV of NumericLiteral ::= DecimalLiteral

=cut

sub MV_NumericLiteral_DecimalLiteral {
    return $_[1];
}

=head2 MV_NumericLiteral_HexIntegerLiteral($self, $HexIntegerLiteral)

MV of NumericLiteral ::= HexIntegerLiteral

=cut

sub MV_NumericLiteral_HexIntegerLiteral {
    return $_[1];
}

=head2 MV_NumericLiteral_OctalIntegerLiteral($self, $OctalIntegerLiteral)

MV of NumericLiteral ::= OctalIntegerLiteral

=cut

sub MV_NumericLiteral_OctalIntegerLiteral {
    return $_[1];
}

1;
