use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral;
use parent qw/MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base/;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::Singleton;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::DefaultSemanticsPackage;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses;
use SUPER;
use Carp qw/croak/;

# ABSTRACT: ECMAScript-262, Edition 5, string numeric literal grammar written in Marpa BNF

# VERSION

=head1 DESCRIPTION

This modules returns describes the ECMAScript 262, Edition 5 string numeric literal grammar written in Marpa BNF, as of L<http://www.ecma-international.org/publications/standards/Ecma-262.htm>, section 9.3.1. This module inherits the methods from MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base package.

=head1 SYNOPSIS

    use strict;
    use warnings FATAL => 'all';
    use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral;

    my $grammar = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral->new();

    my $grammar_content = $grammar->content();
    my $grammar_option = $grammar->grammar_option();
    my $recce_option = $grammar->recce_option();

=cut

#
# Note that this grammar is NOT supposed to be injected in Program
#
our $grammar_source = do {local $/; <DATA>};

our $singleton = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::Singleton->instance(
    MarpaX::Languages::ECMAScript::AST::Impl->new
    (
     __PACKAGE__->make_grammar_option(__PACKAGE__, 'ECMAScript-262-5', $grammar_source),
     undef,                                   # $recceOptionsHashp
     undef,                                   # $cachedG
     1                                        # $noR
    )->grammar
    );

=head1 SUBROUTINES/METHODS

=head2 new($optionsp)

$optionsp is a reference to hash that may contain the following key/value pair:

=over

=item semantics_package

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

=item $obj->pzero()

Positive zero.

=back

=back

=cut

sub new {
    my ($class, $optionsp) = @_;

    $optionsp //= {};

    my $semantics_package = exists($optionsp->{semantics_package}) ? $optionsp->{semantics_package} : __PACKAGE__ . '::DefaultSemanticsPackage';

    my $self = $class->SUPER($grammar_source, __PACKAGE__);

    #
    # Add semantics package to self
    #
    $self->{_semantics_package} = $semantics_package;

    return $self;
}

=head2 recce_option($self, $package)

Returns recce options.

=cut

sub recce_option {
    my ($self) = @_;
    my $recce_option = super();
    
    $recce_option->{semantics_package} = $self->{_semantics_package};

    return $recce_option;
}

=head2 make_grammar_option($class, $package)

Returns default grammar options.

=cut

sub make_grammar_option {
    my ($class) = @_;
    my $grammar_option = super();
    
    delete($grammar_option->{action_object});

    return $grammar_option;
}

=head2 G()

Cached Marpa::R2::Scanless::G compiled grammar.

=cut

sub G {
    return $singleton->G;
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
:default ::= action => [values] bless => ::lhs

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

DecimalDigitsopt ::= DecimalDigits
DecimalDigitsopt ::=

DecimalDigits ::=
    DecimalDigit
  | DecimalDigits DecimalDigit

DecimalDigit ::= _DecimalDigit

ExponentPartopt ::= ExponentPart
ExponentPartopt ::=

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
