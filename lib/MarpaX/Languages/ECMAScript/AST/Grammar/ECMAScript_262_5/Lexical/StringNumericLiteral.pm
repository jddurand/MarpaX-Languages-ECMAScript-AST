use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::StringNumericLiteral;
use parent qw/MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base/;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::StringNumericLiteral::Actions;
use Carp qw/croak/;
use Log::Any qw/$log/;
use Scalar::Util qw/blessed/;
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

=head2 new($semantics_package)

As per Marpa::R2, The semantics package is used when resolving action names to fully qualified Perl names. This package must support the following methods:

=over

=item new($string)

creates an instance of how the host represent the number quoted in $string. Instance is represented as $obj in the next sections. String is guaranteed to be one of '0'...'15', or 'Infinity'. No notion of sign here, the host can assume we always mean a positive value.

=item $obj->mul($objmul)

$obj * $objmul.

=item $obj->sign($sign)

Set the sign of host number. Sign can be '+' or '-'.

=item $obj->round()

Rounding.

=back

=cut

#
# Note that this grammar is NOT supposed to injected in Program
#
our $grammar_source = do {local $/; <DATA>};

sub new {
    my ($class, $hashp) = @_;

    if (! defined($hashp) || ref($hashp) ne 'HASH') {
      croak 'A reference to a HASH is required as first parameter';
    }
    if (! defined($hashp->{obj}) || ! blessed($hashp->{obj})) {
      croak '$hashp->{obj} must be blessed';
    }
    if (! $hashp->{obj}->can('int')) {
      croak '$hashp->{obj} must have the int method';
    }
    if (! $hashp->{obj}->can('mul')) {
      croak '$hashp->{obj} must have the mul method';
    }
    if (! $hashp->{obj}->can('sign')) {
      croak '$hashp->{obj} must have the sign method';
    }
    if (! $hashp->{obj}->can('round')) {
      croak '$hashp->{obj} must have the round method';
    }

    my $self = $class->SUPER($grammar_source, __PACKAGE__);

    $self->{_hashp} = $hashp;

    return $self;
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
