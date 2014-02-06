use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral;
use parent qw/MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base/;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::NativeNumberSemantics;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses;
use SUPER;

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
our $grammar_content = do {local $/; <DATA>};

=head1 SUBROUTINES/METHODS

=head2 new($optionsp)

$optionsp is a reference to hash that may contain the following key/value pair:

=over

=item semantics_package

As per Marpa::R2, The semantics package is used when resolving action names to fully qualified Perl names. This package must support and behave as documented in the NativeNumberSemantics (c.f. SEE ALSO).

=back

=cut

sub new {
    my ($class, $optionsp) = @_;

    $optionsp //= {};

    my $semantics_package = exists($optionsp->{semantics_package}) ? $optionsp->{semantics_package} : __PACKAGE__ . '::NativeNumberSemantics';

    my $self = $class->SUPER();

    #
    # Add semantics package to self
    #
    $self->{_semantics_package} = $semantics_package;

    return $self;
}

=head2 make_grammar_content($class)

Returns the grammar. This will be injected in the Program's grammar.

=cut

sub make_grammar_content {
    my ($class) = @_;
    return $grammar_content;
}

=head2 recce_option($self)

Returns option for Marpa::R2::Scanless::R->new(), returned as a reference to a hash.

=cut

sub recce_option {
    my ($self) = @_;
    #
    # Get default hash
    #
    my $default = $self->SUPER();
    #
    # And overwrite the semantics_package
    #
    $default->{semantics_package} = $self->{_semantics_package};

    return $default;
}

#
# INTERNAL ACTIONS
#

sub _secondArg {
    return $_[2];
}

sub _value {
    return _secondArg(@_)->host_round->host_value;
}

sub _value_zero {
    return $_[0]->host_pos_zero->host_value;
}

sub _Infinity {
    return $_[0]->host_pos_inf;
}

#
# Note that HexIntegerLiteral output is a HexDigit modified
#
sub _HexIntegerLiteral_HexDigit {
    my $sixteen = $_[0]->host_class->new->host_int("16");

    return $_[1]->host_mul($sixteen)->host_add($_[2]);
}

#
# Note that DecimalDigits output is a DecimalDigit modified
#
sub _DecimalDigits_DecimalDigit {
    my $ten = $_[0]->host_class->new->host_int("10");
    return $_[1]->host_mul($ten)->host_add($_[2])->host_inc_length;
}

sub _Dot_DecimalDigits_ExponentPart {
    my $n = $_[2]->host_new_from_length;
    my $tenpowexponentminusn = $_[0]->host_class->new->host_int("10")->host_pow($_[3]->host_sub($n));

    return $_[2]->host_mul($tenpowexponentminusn);
}

sub _DecimalDigits_Dot_DecimalDigits_ExponentPart {
    #
    # Done using polish logic -;
    #
    return $_[1]->host_add(
	_DecimalDigits_ExponentPart(
	    $_[0],
            _Dot_DecimalDigits($_[0], '.', $_[3]),
	    $_[4])
	);
}

sub _DecimalDigits_Dot_ExponentPart {
    my $tenpowexponent = $_[0]->host_class->new->host_int("10")->host_pow($_[3]);
    return $_[1]->host_mul($tenpowexponent);
}

sub _DecimalDigits_Dot_DecimalDigits {
    return $_[1]->host_add(_Dot_DecimalDigits($_[0], '.', $_[3]));
}

sub _Dot_DecimalDigits {
    my $n = $_[2]->host_new_from_length;
    my $tenpowminusn = $_[0]->host_class->new->host_int("10")->host_pow($n->host_neg);
    return $_[2]->host_mul($tenpowminusn);
}

sub _DecimalDigits_ExponentPart {
    my $tenpowexponent = $_[0]->host_class->new->host_int("10")->host_pow($_[2]);

    return $_[1]->host_mul($tenpowexponent);
}

sub _HexDigit {
    return $_[0]->host_class->new->host_hex("$_[1]");
}

sub _DecimalDigit {
    return $_[0]->host_class->new->host_int("$_[1]");
}

sub _neg {
  return $_[2]->host_neg;
}

=head1 SEE ALSO

L<Data::Float>

L<MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base>

L<MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::NativeNumberSemantics>

=cut

1;
__DATA__
# ================================================
# ECMAScript Script Lexical String Numeric Grammar
# ================================================
#
:start ::= StringNumericLiteral

StrWhiteSpaceopt ::= StrWhiteSpace
StrWhiteSpaceopt ::=

StringNumericLiteral ::=                                   action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_value_zero
StringNumericLiteral ::= StrWhiteSpace                     action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_value_zero
StringNumericLiteral ::= 
    StrWhiteSpaceopt StrNumericLiteral StrWhiteSpaceopt    action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_value

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
    'Infinity'                                             action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::_Infinity
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
