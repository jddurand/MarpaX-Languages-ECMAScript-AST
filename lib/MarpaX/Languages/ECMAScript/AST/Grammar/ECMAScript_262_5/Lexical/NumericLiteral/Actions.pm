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

Action for rule NumericLiteral ::= DecimalLiteral

The MV of NumericLiteral :: DecimalLiteral is the MV of DecimalLiteral.

=cut

sub MV_NumericLiteral_DecimalLiteral {
    my ($self, $DecimalLiteral) = @_;

    return $DecimalLiteral;
}

=head2 MV_NumericLiteral_HexIntegerLiteral($self, $HexIntegerLiteral)

Action for rule NumericLiteral ::= HexIntegerLiteral

=cut

sub MV_NumericLiteral_HexIntegerLiteral {
    my ($self, $HexIntegerLiteral) = @_;
}

=head2 MV_DecimalLiteral_OctalIntegerLiteral($self, $OctalIntegerLiteral)

Action for rule DecimalLiteral ::= OctalIntegerLiteral

=cut

sub MV_DecimalLiteral_OctalIntegerLiteral {
    my ($self, $OctalIntegerLiteral) = @_;
}

=head2 MV_DecimalLiteral_DecimalIntegerLiteral_DOT($self, $DecimalIntegerLiteral, $DOT)

Action for rule DecimalLiteral ::= DecimalIntegerLiteral '.'

=cut

sub MV_DecimalLiteral_DecimalIntegerLiteral_DOT {
    my ($self, $DecimalIntegerLiteral, $DOT) = @_;
}

=head2 MV_DecimalLiteral_DecimalIntegerLiteral_DOT_DecimalDigits($self, $DecimalIntegerLiteral, $DOT, $DecimalDigits)

Action for rule DecimalLiteral ::= DecimalIntegerLiteral '.' DecimalDigits

=cut

sub MV_DecimalLiteral_DecimalIntegerLiteral_DOT_DecimalDigits {
    my ($self, $DecimalIntegerLiteral, $DOT, $DecimalDigits) = @_;
}

=head2 MV_DecimalIntegerLiteral_DOT_DecimalDigits_ExponentPart ($self, $DOT, $DecimalDigits, $ExponentPart )

Action for rule DecimalIntegerLiteral ::= '.' DecimalDigits ExponentPart 

=cut

sub MV_DecimalIntegerLiteral_DOT_DecimalDigits_ExponentPart  {
    my ($self, $DOT, $DecimalDigits, $ExponentPart ) = @_;
}

=head2 MV_DecimalIntegerLiteral_DOT_ExponentPart($self, $DOT, $ExponentPart)

Action for rule DecimalIntegerLiteral ::= '.' ExponentPart

=cut

sub MV_DecimalIntegerLiteral_DOT_ExponentPart {
    my ($self, $DOT, $ExponentPart) = @_;
}

=head2 MV_DecimalLiteral_DOT_DecimalDigits($self, $DOT, $DecimalDigits)

Action for rule DecimalLiteral ::= '.' DecimalDigits

=cut

sub MV_DecimalLiteral_DOT_DecimalDigits {
    my ($self, $DOT, $DecimalDigits) = @_;
}

=head2 MV_DecimalLiteral_DOT_DecimalDigits_ExponentPart($self, $DOT, $DecimalDigits, $ExponentPart)

Action for rule DecimalLiteral ::= '.' DecimalDigits ExponentPart

=cut

sub MV_DecimalLiteral_DOT_DecimalDigits_ExponentPart {
    my ($self, $DOT, $DecimalDigits, $ExponentPart) = @_;
}

=head2 MV_DecimalLiteral_DecimalIntegerLiteral($self, $DecimalIntegerLiteral)

Action for rule DecimalLiteral ::= DecimalIntegerLiteral

=cut

sub MV_DecimalLiteral_DecimalIntegerLiteral {
    my ($self, $DecimalIntegerLiteral) = @_;
}

=head2 MV_DecimalIntegerLiteral_ExponentPart($self, $ExponentPart)

Action for rule DecimalIntegerLiteral ::= ExponentPart

=cut

sub MV_DecimalIntegerLiteral_ExponentPart {
    my ($self, $ExponentPart) = @_;
}

=head2 MV_DecimalIntegerLiteral_ZERO($self, $ZERO)

Action for rule DecimalIntegerLiteral ::= '0'

=cut

sub MV_DecimalIntegerLiteral_ZERO {
    my ($self, $ZERO) = @_;
}

=head2 MV_DecimalIntegerLiteral_NonZeroDigit($self, $NonZeroDigit)

Action for rule DecimalIntegerLiteral ::= NonZeroDigit

=cut

sub MV_DecimalIntegerLiteral_NonZeroDigit {
    my ($self, $NonZeroDigit) = @_;
}

=head2 MV_DecimalIntegerLiteral_NonZeroDigit_DecimalDigits($self, $NonZeroDigit, $DecimalDigits)

Action for rule DecimalIntegerLiteral ::= NonZeroDigit DecimalDigits

=cut

sub MV_DecimalIntegerLiteral_NonZeroDigit_DecimalDigits {
    my ($self, $NonZeroDigit, $DecimalDigits) = @_;
}

=head2 MV_DecimalDigits_DecimalDigit($self, $DecimalDigit)

Action for rule DecimalDigits ::= DecimalDigit

=cut

sub MV_DecimalDigits_DecimalDigit {
    my ($self, $DecimalDigit) = @_;
}

=head2 MV_DecimalDigits_DecimalDigits_DecimalDigit($self, $DecimalDigits, $DecimalDigit)

Action for rule DecimalDigits ::= DecimalDigits DecimalDigit

=cut

sub MV_DecimalDigits_DecimalDigits_DecimalDigit {
    my ($self, $DecimalDigits, $DecimalDigit) = @_;
}

=head2 MV_ExponentPart_ExponentIndicator_SignedInteger($self, $ExponentIndicator, $SignedInteger)

Action for rule ExponentPart ::= ExponentIndicator SignedInteger

=cut

sub MV_ExponentPart_ExponentIndicator_SignedInteger {
    my ($self, $ExponentIndicator, $SignedInteger) = @_;
}

=head2 MV_SignedInteger_DecimalDigits($self, $DecimalDigits)

Action for rule SignedInteger ::= DecimalDigits

=cut

sub MV_SignedInteger_DecimalDigits {
    my ($self, $DecimalDigits) = @_;
}

=head2 MV_SignedInteger_PLUS_DecimalDigits($self, $PLUS, $DecimalDigits)

Action for rule SignedInteger ::= '+' DecimalDigits

=cut

sub MV_SignedInteger_PLUS_DecimalDigits {
    my ($self, $PLUS, $DecimalDigits) = @_;
}

=head2 MV_SignedInteger_MINUS_DecimalDigits($self, $MINUS, $DecimalDigits)

Action for rule SignedInteger ::= '-' DecimalDigits

=cut

sub MV_SignedInteger_MINUS_DecimalDigits {
    my ($self, $MINUS, $DecimalDigits) = @_;
}

=head2 MV_HexIntegerLiteral_HexIntegerLiteralInternal($self, $HexIntegerLiteralInternal)

Action for rule HexIntegerLiteral ::= HexIntegerLiteralInternal

=cut

sub MV_HexIntegerLiteral_HexIntegerLiteralInternal {
    my ($self, $HexIntegerLiteralInternal) = @_;
}

=head2 MV_HexIntegerLiteralInternal_ZEROx_HexDigit($self, $ZEROx, $HexDigit)

Action for rule HexIntegerLiteralInternal ::= '0x' HexDigit

=cut

sub MV_HexIntegerLiteralInternal_ZEROx_HexDigit {
    my ($self, $ZEROx, $HexDigit) = @_;
}

=head2 MV_HexIntegerLiteralInternal_ZEROX_HexDigit($self, $ZEROX, $HexDigit)

Action for rule HexIntegerLiteralInternal ::= '0X' HexDigit

=cut

sub MV_HexIntegerLiteralInternal_ZEROX_HexDigit {
    my ($self, $ZEROX, $HexDigit) = @_;
}

=head2 MV_HexIntegerLiteralInternal_HexIntegerLiteralInternal_HexDigit($self, $HexIntegerLiteralInternal, $HexDigit)

Action for rule HexIntegerLiteralInternal ::= HexIntegerLiteralInternal HexDigit

=cut

sub MV_HexIntegerLiteralInternal_HexIntegerLiteralInternal_HexDigit {
    my ($self, $HexIntegerLiteralInternal, $HexDigit) = @_;
}

=head2 MV_OctalIntegerLiteral_OctalIntegerLiteralInternal($self, $OctalIntegerLiteralInternal)

Action for rule OctalIntegerLiteral ::= OctalIntegerLiteralInternal

=cut

sub MV_OctalIntegerLiteral_OctalIntegerLiteralInternal {
    my ($self, $OctalIntegerLiteralInternal) = @_;
}

=head2 MV_OctalIntegerLiteralInternal_ZERO_OctalDigit($self, $ZERO, $OctalDigit)

Action for rule OctalIntegerLiteralInternal ::= '0' OctalDigit

=cut

sub MV_OctalIntegerLiteralInternal_ZERO_OctalDigit {
    my ($self, $ZERO, $OctalDigit) = @_;
}

=head2 MV_OctalIntegerLiteralInternal_OctalIntegerLiteralInternal_OctalDigit($self, $OctalIntegerLiteralInternal, $OctalDigit)

Action for rule OctalIntegerLiteralInternal ::= OctalIntegerLiteralInternal OctalDigit

=cut

sub MV_OctalIntegerLiteralInternal_OctalIntegerLiteralInternal_OctalDigit {
    my ($self, $OctalIntegerLiteralInternal, $OctalDigit) = @_;
}

1;
