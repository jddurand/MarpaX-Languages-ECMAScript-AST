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

sub MV_NumericLiteral_DecimalLiteral {
}

sub MV_NumericLiteral_HexIntegerLiteral {
}

sub MV_DecimalLiteral_OctalIntegerLiteral {
}

sub MV_DecimalLiteral_DecimalIntegerLiteral_DOT_DecimalDigits {
}

sub MV_DecimalIntegerLiteral_DOT_DecimalDigits_ExponentPart {
}

sub MV_DecimalIntegerLiteral_DOT_ExponentPart {
}

sub MV_DecimalLiteral_DOT_DecimalDigits {
}

sub MV_DecimalLiteral_DOT_DecimalDigits_ExponentPart {
}

sub MV_DecimalLiteral_DecimalIntegerLiteral {
}

sub MV_DecimalIntegerLiteral_ExponentPart {
}

sub MV_DecimalIntegerLiteral_ZERO {
}

sub MV_DecimalIntegerLiteral_NonZeroDigit {
}

sub MV_DecimalIntegerLiteral_NonZeroDigit_DecimalDigits {
}

sub MV_DecimalDigits_DecimalDigit {
}

sub MV_DecimalDigits_DecimalDigits_DecimalDigit {
}

sub MV_ExponentPart_ExponentIndicator_SignedInteger {
}

sub MV_SignedInteger_DecimalDigits {
}

sub MV_SignedInteger_PLUS_DecimalDigits {
}

sub MV_SignedInteger_MINUS_DecimalDigits {
}

sub MV_HexIntegerLiteral_HexIntegerLiteralInternal {
}

sub MV_HexIntegerLiteralInternal_ZEROx_HexDigit {
}

sub MV_HexIntegerLiteralInternal_ZEROX_HexDigit {
}

sub MV_HexIntegerLiteralInternal_HexIntegerLiteralInternal_HexDigit {
}

sub MV_OctalIntegerLiteral_OctalIntegerLiteralInternal {
}

sub MV_OctalIntegerLiteralInternal_ZERO_OctalDigit {
}

sub MV_OctalIntegerLiteralInternal_OctalIntegerLiteralInternal_OctalDigit {
}

1;
