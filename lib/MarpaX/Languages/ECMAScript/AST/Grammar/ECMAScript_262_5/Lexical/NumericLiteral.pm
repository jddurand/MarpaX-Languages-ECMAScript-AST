use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::NumericLiteral;
use parent qw/MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base/;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::NumericLiteral::Actions;
use Carp qw/croak/;
use Log::Any qw/$log/;
use SUPER;

# ABSTRACT: ECMAScript-262, Edition 5, lexical numeric grammar written in Marpa BNF

# VERSION

=head1 DESCRIPTION

This modules returns describes the ECMAScript 262, Edition 5 lexical decimal grammar written in Marpa BNF, as of L<http://www.ecma-international.org/publications/standards/Ecma-262.htm>. This module inherits the methods from MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base package.

=head1 SYNOPSIS

    use strict;
    use warnings FATAL => 'all';
    use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::NumericLiteral;

    my $grammar = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::NumericLiteral->new();

    my $grammar_content = $grammar->content();
    my $grammar_option = $grammar->grammar_option();
    my $recce_option = $grammar->recce_option();

=cut

=head1 SUBROUTINES/METHODS

=head2 new()

Instance a new object.

=cut

sub new {
    my ($class) = @_;

    #
    # Prevent injection of this grammar to collide with others:
    # ___yy is changed to ___StringLiteral___yy
    #
    my $grammar_source = do {local $/; <DATA>};
    $grammar_source =~ s/___/___NumericLiteral___/g;

    return $class->SUPER($grammar_source, __PACKAGE__);
}

=head2 parse($self, $source)

Parse the source given as $source.

=cut

sub parse {
    my ($self, $source, $impl) = @_;
    return $self->SUPER($source, $impl,
	{
	 #   '_DecimalLiteral$'     => \&_DecimalLiteral,
	 #   '_HexIntegerLiteral$'  => \&_HexIntegerLiteral,
	 #   '_OctalIntegerLiteral$'=> \&_OctalIntegerLiteral,
	 #   '_IdentifierName$'     => \&_IdentifierName
	});
}

sub _DecimalLiteral {
    my ($self, $lexemeHashp, $source, $impl) = @_;

    $self->_NumericLiteralLookhead($lexemeHashp, $source, $impl);
}

=head1 SEE ALSO

L<MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base>

=cut

1;
__DATA__
# ==================================
# ECMAScript Script Lexical Decimal Grammar
# ==================================
#
# The source text of an ECMAScript program is first converted into a sequence of input elements, which are
# tokens, line terminators, comments, or white space.
#
:start ::= __NumericLiteral
:default ::= action => [values] bless => ::lhs
lexeme default = action => [start,length,value]

#
# DO NOT REMOVE NOR MODIFY THIS LINE
#
# This grammar is injected in Lexical grammar, with the following modifications:
# action => xxx              are removed
# __xxx\s*::=\s*               are changed to __xxx ~
#

__NumericLiteral ::=
    __DecimalLiteral                action => MV_NumericLiteral_DecimalLiteral
  | __HexIntegerLiteral             action => MV_NumericLiteral_HexIntegerLiteral
  | __OctalIntegerLiteral           action => MV_DecimalLiteral_DecimalIntegerLiteral

__DecimalLiteral ::= __DecimalIntegerLiteral '.' __DecimalDigits              action => DecimalLiteral_DecimalIntegerLiteral_DOT_DecimalDigits
                 | __DecimalIntegerLiteral '.' __DecimalDigits __ExponentPart
                 | __DecimalIntegerLiteral '.' __ExponentPart
                 | '.' __DecimalDigits
                 | '.' __DecimalDigits __ExponentPart
                 | __DecimalIntegerLiteral
                 | __DecimalIntegerLiteral __ExponentPart

__DecimalIntegerLiteral ::= '0'
                        | ___NonZeroDigit
                        | ___NonZeroDigit __DecimalDigits

__DecimalDigits ::= ___DecimalDigit
                | __DecimalDigits ___DecimalDigit

__ExponentPart ::= ___ExponentIndicator __SignedInteger

__SignedInteger ::= __DecimalDigits
                | '+' __DecimalDigits
                | '-' __DecimalDigits

__HexIntegerLiteral ::= __HexIntegerLiteralInternal

__HexIntegerLiteralInternal ::= '0x' ___HexDigit
                    | '0X' ___HexDigit
                    | __HexIntegerLiteralInternal ___HexDigit

__OctalIntegerLiteral ::= __OctalIntegerLiteralInternal

__OctalIntegerLiteralInternal ::= '0' ___OctalDigit
                                | __OctalIntegerLiteralInternal ___OctalDigit

#
# The ___ are to prevent errors with eventual duplicate rules when injecting
# this grammar in Lexical's grammar
#
___OctalDigit ~ [\p{IsOctalDigit}]
___HexDigit  ~ [\p{IsHexDigit}]
___ExponentIndicator ~ [\p{IsExponentIndicator}]
___NonZeroDigit      ~ [\p{IsNonZeroDigit}]
___DecimalDigit      ~ [\p{IsDecimalDigit}]
