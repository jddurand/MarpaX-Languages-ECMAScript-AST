use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::StringLiteral;
use parent qw/MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base/;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::StringLiteral::Actions;
use Carp qw/croak/;
use Log::Any qw/$log/;
use SUPER;

# ABSTRACT: ECMAScript-262, Edition 5, lexical string grammar written in Marpa BNF

# VERSION

=head1 DESCRIPTION

This modules returns describes the ECMAScript 262, Edition 5 lexical string grammar written in Marpa BNF, as of L<http://www.ecma-international.org/publications/standards/Ecma-262.htm>. This module inherits the methods from MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base package.

=head1 SYNOPSIS

    use strict;
    use warnings FATAL => 'all';
    use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::StringLiteral;

    my $grammar = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::StringLiteral->new();

    my $grammar_content = $grammar->content();
    my $grammar_option = $grammar->grammar_option();
    my $recce_option = $grammar->recce_option();

=cut

=head1 SUBROUTINES/METHODS

=head2 new()

Instance a new object.

=cut

#
# Prevent injection of this grammar to collide with others:
# ___yy is changed to ___StringLiteral___yy
#
our $grammar_source = do {local $/; <DATA>};
$grammar_source =~ s/___/___StringLiteral___/g;

sub new {
    my ($class) = @_;

    return $class->SUPER($grammar_source, __PACKAGE__);
}

=head2 parse($self, $sourcep)

Parse the source given as reference to a scalar.

=cut

sub parse {
    my ($self, $sourcep, $impl) = @_;
    return $self->SUPER($sourcep, $impl,
	{
	 #   '_DecimalLiteral$'     => \&_DecimalLiteral,
	 #   '_HexIntegerLiteral$'  => \&_HexIntegerLiteral,
	 #   '_OctalIntegerLiteral$'=> \&_OctalIntegerLiteral,
	 #   '_IdentifierName$'     => \&_IdentifierName
	});
}

sub _DecimalLiteral {
    my ($self, $lexemeHashp, $sourcep, $impl) = @_;

    $self->_NumericLiteralLookhead($lexemeHashp, $sourcep, $impl);
}

=head1 SEE ALSO

L<MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base>

=cut

1;
__DATA__
# ==================================
# ECMAScript Script Lexical String Grammar
# ==================================
#
# The source text of an ECMAScript program is first converted into a sequence of input elements, which are
# tokens, line terminators, comments, or white space.
#
:start ::= __StringLiteral
:default ::= action => [values] bless => ::lhs
lexeme default = action => [start,length,value]

#
# DO NOT REMOVE NOR MODIFY THIS LINE
#
# This grammar is injected in Lexical grammar, with the following modifications:
# action => xxx              are removed
# __xxx\s*::=\s*               are changed to __xxx ~
# ___yy are left as is
#

__StringLiteral ::=
    ___DoubleStringLiteral
  | ___SingleStringLiteral

___DoubleStringLiteral ::= '"' ___DoubleStringCharactersopt '"'
___SingleStringLiteral ::= ___Quote ___SingleStringCharactersopt ___Quote

___DoubleStringCharacters ::=  ___DoubleStringCharacter ___DoubleStringCharactersopt
___SingleStringCharacters ::=  ___SingleStringCharacter ___SingleStringCharactersopt

___DoubleStringCharactersopt ::= ___DoubleStringCharacters
___DoubleStringCharactersopt ::=

___SingleStringCharactersopt ::= ___SingleStringCharacters
___SingleStringCharactersopt ::=

___DoubleStringCharacter ::=
    ___SourceCharacterButNotOneOfDquoteOrBackslashOrLineTerminator
  | '\' ___EscapeSequence
  # ' for my editor
  | ___LineContinuation

___SingleStringCharacter ::=
    ___SourceCharacterButNotOneOfSquoteOrBackslashOrLineTerminator
  | '\' ___EscapeSequence
  # ' for my editor
  | ___LineContinuation

___LineContinuation ::=
  '\' ___LineTerminatorSequence
  # ' for my editor

___EscapeSequence ::=
    ___CharacterEscapeSequence
  | ___OctalEscapeSequence
  | ___HexEscapeSequence
  | ___UnicodeEscapeSequence

___OctalEscapeSequence ::=
    ___StringLiteral__OctalDigit
  | ___ZeroToThree ___StringLiteral__OctalDigit
  | ___FourToSeven ___StringLiteral__OctalDigit
  | ___ZeroToThree ___StringLiteral__OctalDigit ___StringLiteral__OctalDigit

___CharacterEscapeSequence ::=
    ___SingleEscapeCharacter
  | ___NonEscapeCharacter

___HexEscapeSequence ::= 'x' ___HexDigit ___HexDigit

#
# The ___ are to prevent errors with eventual duplicate rules when injecting
# this grammar in main lexical grammar
#
___UnicodeEscapeSequence ~ 'u' ___HexDigit ___HexDigit ___HexDigit ___HexDigit
___Quote ~ [\p{IsSquote}]
___SourceCharacterButNotOneOfDquoteOrBackslashOrLineTerminator ~ [\p{IsSourceCharacterButNotOneOfDquoteOrBackslashOrLineTerminator}]
___SourceCharacterButNotOneOfSquoteOrBackslashOrLineTerminator ~ [\p{IsSourceCharacterButNotOneOfSquoteOrBackslashOrLineTerminator}]
___LineTerminatorSequence ~
      [\p{IsLF}]
    | [\p{IsCR}] # Note: [lookahead not in [\p{IsLF}] ] is ok because of longest-token implementation
    | [\p{IsLS}]
    | [\p{IsPS}]
    | [\p{IsCR}] [\p{IsLF}]
___ZeroToThree           ~ [\p{IsZeroToThree}]
___FourToSeven           ~ [\p{IsFourToSeven}]
___NonEscapeCharacter    ~ [\p{IsSourceCharacterButNotOneOfEscapeCharacterOrLineTerminator}]
___SingleEscapeCharacter ~ [\p{IsSingleEscapeCharacter}]
___StringLiteral__OctalDigit             ~ [\p{IsOctalDigit}]
___HexDigit              ~ [\p{IsHexDigit}]

