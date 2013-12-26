use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral;
use parent qw/MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base/;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::Singleton;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::DefaultSemanticsPackage;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses;
use SUPER;
use Carp qw/croak/;
use Scalar::Util qw/blessed/;

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

As per Marpa::R2, The semantics package is used when resolving action names to fully qualified Perl names. This package must support and behave as documented in the DefaultSemanticsPackage (c.f. SEE ALSO).

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

L<Data::Float>

L<MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base>

L<MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::DefaultSemanticsPackage>

=cut

sub _secondArg {
    return $_[2];
}

#
# Note that HexIntegerLiteral output is a HexDigit modified
#
sub _HexIntegerLiteral_HexDigit {
    my $sixteen = blessed($_[0])->new->positive_int("16");

    return $_[1]->mul($sixteen)->add($_[2]);
}

#
# Note that DecimalDigits output is a DecimalDigit modified
#
sub _DecimalDigits_DecimalDigit {
    my $ten = blessed($_[0])->new->positive_int("10");
    $_[1]->length($_[1]->length + 1);
    return $_[1]->mul($ten)->add($_[2]);
}

sub _Dot_DecimalDigits_ExponentPart {
    my $n = blessed($_[0])->new->positive_int($_[2]->length);
    my $tenpowexponentminusn = blessed($_[0])->new->positive_int("10")->pow($_[3]->sub($n));

    return $_[2]->mul($tenpowexponentminusn);
}

sub _DecimalDigits_Dot_DecimalDigits_ExponentPart {
    #
    # Done using polish logic -;
    #
    return $_[1]->add(
	_DecimalDigits_ExponentPart(
	    $_[0],
	    _Dot_DecimalDigits($_[0], '.', $_[3]),
	    $_[4])
	);
}

sub _DecimalDigits_Dot_ExponentPart {
    my $tenpowexponent = blessed($_[0])->new->positive_int("10")->pow($_[3]);
    return $_[1]->mul($tenpowexponent);
}

sub _DecimalDigits_Dot_DecimalDigits {
    return $_[1]->add(_Dot_DecimalDigits($_[0], '.', $_[3]));
}

sub _Dot_DecimalDigits {
    my $n = blessed($_[0])->new->positive_int($_[2]->length);
    my $tenpowminusn = blessed($_[0])->new->positive_int("10")->pow($n->neg);
    return $_[2]->mul($tenpowminusn);
}

sub _DecimalDigits_ExponentPart {
    my $tenpowexponent = blessed($_[0])->new->positive_int("10")->pow($_[2]);

    return $_[1]->mul($tenpowexponent);
}

sub _HexDigit {
    return blessed($_[0])->new->positive_hex("$_[1]");
}

sub _DecimalDigit {
    return blessed($_[0])->new->positive_int("$_[1]");
}

sub _neg {
    $_[2]->neg();
}

1;
__DATA__
# ================================================
# ECMAScript Script Lexical String Numeric Grammar
# ================================================
#
:start ::= StringNumericLiteral

StrWhiteSpaceopt ::= StrWhiteSpace
StrWhiteSpaceopt ::=

StringNumericLiteral ::=                                   action => pos_zero
StringNumericLiteral ::= StrWhiteSpace                     action => pos_zero
StringNumericLiteral ::= 
    StrWhiteSpaceopt StrNumericLiteral StrWhiteSpaceopt    action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_secondArg

StrWhiteSpace ::=
  StrWhiteSpaceChar StrWhiteSpaceopt                       action => ::undef

StrWhiteSpaceChar ::=
    _WhiteSpace                                            action => ::undef
  | _LineTerminator                                        action => ::undef

StrNumericLiteral ::=
    StrDecimalLiteral                                      action => ::first
  | HexIntegerLiteral                                      action => ::first

StrDecimalLiteral ::=
    StrUnsignedDecimalLiteral                              action => ::first
  | '+' StrUnsignedDecimalLiteral                          action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_secondArg
  | '-' StrUnsignedDecimalLiteral                          action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_neg

StrUnsignedDecimalLiteral ::=
    'Infinity'                                             action => pos_infinity
  | DecimalDigits '.'                                      action => ::first
  | DecimalDigits '.' DecimalDigits                        action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_DecimalDigits_Dot_DecimalDigits
  | DecimalDigits '.' ExponentPart                         action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_DecimalDigits_Dot_ExponentPart
  | DecimalDigits '.' DecimalDigits ExponentPart           action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_DecimalDigits_Dot_DecimalDigits_ExponentPart
  | '.' DecimalDigits                                      action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_Dot_DecimalDigits
  | '.' DecimalDigits ExponentPart                         action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_Dot_DecimalDigits_ExponentPart
  | DecimalDigits                                          action => ::first
  | DecimalDigits ExponentPart                             action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_DecimalDigits_ExponentPart

DecimalDigits ::=
    DecimalDigit                                           action => ::first
  | DecimalDigits DecimalDigit                             action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_DecimalDigits_DecimalDigit

DecimalDigit ::= _DecimalDigit                             action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_DecimalDigit

ExponentPart ::=
  ExponentIndicator SignedInteger                          action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_secondArg

ExponentIndicator ::= _ExponentIndicator                   action => ::first

SignedInteger ::=
    DecimalDigits                                          action => ::first
  | '+' DecimalDigits                                      action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_secondArg
  | '-' DecimalDigits                                      action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_neg

HexIntegerLiteral ::=
    '0x' HexDigit                                          action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_secondArg
  | '0X' HexDigit                                          action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_secondArg
  | HexIntegerLiteral HexDigit                             action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_HexIntegerLiteral_HexDigit

HexDigit ::= _HexDigit                                     action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_HexDigit

_WhiteSpace        ~ [\p{IsWhiteSpace}]
_LineTerminator    ~ [\p{IsLineTerminator}]
_DecimalDigit      ~ [\p{IsDecimalDigit}]
_ExponentIndicator ~ [\p{IseOrE}]
_HexDigit          ~ [\p{IsHexDigit}]
