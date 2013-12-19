use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::StringNumericLiteral;
use parent qw/MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base/;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::StringNumericLiteral::Actions;
use Carp qw/croak/;
use Log::Any qw/$log/;
use SUPER;

# ABSTRACT: ECMAScript-262, Edition 5, lexical string numeric grammar written in Marpa BNF

# VERSION

=head1 DESCRIPTION

This modules returns describes the ECMAScript 262, Edition 5 lexical string numeric grammar written in Marpa BNF, as of L<http://www.ecma-international.org/publications/standards/Ecma-262.htm>, section 9.3.1. This module inherits the methods from MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base package.

=head1 SYNOPSIS

    use strict;
    use warnings FATAL => 'all';
    use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::StringNumericLiteral;

    my $grammar = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::StringNumericLiteral->new();

    my $grammar_content = $grammar->content();
    my $grammar_option = $grammar->grammar_option();
    my $recce_option = $grammar->recce_option();

=cut

=head1 SUBROUTINES/METHODS

=head2 new()

Instance a new object.

=cut

#
# Note that this grammar is NOT supposed to injected in Program
#
our $grammar_source = do {local $/; <DATA>};

sub new {
    my ($class) = @_;

    return $class->SUPER($grammar_source, __PACKAGE__);
}

=head1 SEE ALSO

L<MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base>

=cut

1;
__DATA__
# ================================================
# ECMAScript Script Lexical String Numeric Grammar
# ================================================
#
:start ::= StringNumericLiteral
:default ::= action => ::first

StrWhiteSpaceopt ::= StrWhiteSpace
StrWhiteSpaceopt ::=

StringNumericLiteral ::=
    StrWhiteSpaceopt
  | StrWhiteSpaceopt StrNumericLiteral StrWhiteSpaceopt

StrWhiteSpace ::=
  StrWhiteSpaceChar StrWhiteSpaceopt

StrWhiteSpaceChar ::=
    _WhiteSpace
  | _LineTerminator

StrNumericLiteral ::=
    StrDecimalLiteral
  | HexIntegerLiteral

StrDecimalLiteral ::=
    StrUnsignedDecimalLiteral
  | '+' StrUnsignedDecimalLiteral
  | '-' StrUnsignedDecimalLiteral

StrUnsignedDecimalLiteral ::=
    'Infinity'
  | DecimalDigits '.' DecimalDigitsopt ExponentPartopt
  | '.' DecimalDigits ExponentPartopt
  | DecimalDigits ExponentPartopt

DecimalDigits ::=
    DecimalDigit
  | DecimalDigits DecimalDigit

DecimalDigit ::= _DecimalDigit

ExponentPart ::=
  ExponentIndicator SignedInteger

ExponentIndicator ::= _ExponentIndicator

SignedInteger ::=
    DecimalDigits
  | '+' DecimalDigits
  | '-' DecimalDigits

HexIntegerLiteral ::=
    '0x' HexDigit
  | '0X' HexDigit
  | HexIntegerLiteral HexDigit

HexDigit ::= _HexDigit

_WhiteSpace        ~ [\p{IsWhiteSpace}]
_LineTerminator    ~ [\p{IsLineTerminator}]
_DecimalDigit      ~ [\p{IsDecimalDigit}]
_ExponentIndicator ~ [\p{IseOrE}]
_HexDigit          ~ [\p{IsHexDigit}]
