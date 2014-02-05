use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::RegularExpressionLiteral;
use parent qw/MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base/;

# ABSTRACT: ECMAScript-262, Edition 5, lexical string grammar written in Marpa BNF

# VERSION

=head1 DESCRIPTION

This modules describes the ECMAScript 262, Edition 5 regular expression literal grammar written in Marpa BNF, as of L<http://www.ecma-international.org/publications/standards/Ecma-262.htm>.

This module inherits the methods from MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base package.

=head1 SYNOPSIS

    use strict;
    use warnings FATAL => 'all';
    use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::RegularExpressionLiteral;

    my $grammar = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::RegularExpressionLiteral->new();

    my $grammar_content = $grammar->content();
    my $grammar_option = $grammar->grammar_option();
    my $recce_option = $grammar->recce_option();

=cut

#
# Prevent injection of this grammar to collide with others:
# ___yy is changed to ___StringLiteral___yy
#
our $grammar_content = do {local $/; <DATA>};
$grammar_content =~ s/___/___RegularExpressionLiteral___/g;

=head1 SUBROUTINES/METHODS

=head2 make_grammar_content($class)

Returns the grammar. This will be injected in the Program's grammar.

=cut

sub make_grammar_content {
    my ($class) = @_;
    return $grammar_content;
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
:start ::= __RegularExpressionLiteral
lexeme default = action => [start,length,value]

#
# DO NOT REMOVE NOR MODIFY THIS LINE
#
# This grammar is injected in Lexical grammar, with the following modifications:
# action => xxx              are removed
# __xxx\s*::=\s*               are changed to __xxx ~
#
__RegularExpressionLiteral ::= '/' __RegularExpressionBody '/' __RegularExpressionFlags

__RegularExpressionBody ::= __RegularExpressionFirstChar __RegularExpressionChars

__RegularExpressionChars ::=
__RegularExpressionChars ::= __RegularExpressionChars __RegularExpressionChar

__RegularExpressionFirstChar ::= ___RegularExpressionNonTerminatorButNotOneOfStarOrBackslashOrSlashOrLbracket
                             | __RegularExpressionBackslashSequence
                             | __RegularExpressionClass

__RegularExpressionChar ::= ___RegularExpressionNonTerminatorButNotOneOfBackslashOrSlashOrLbracket
                        | __RegularExpressionBackslashSequence
                        | __RegularExpressionClass


__RegularExpressionBackslashSequence ::= '\' __RegularExpressionNonTerminator
                                     # ' for my editor

__RegularExpressionNonTerminator ::= ___RegularExpressionSourceCharacterButNotLineTerminator

__RegularExpressionClass ::= '[' __RegularExpressionClassChars ']'

__RegularExpressionClassChars ::=
__RegularExpressionClassChars ::= __RegularExpressionClassChars __RegularExpressionClassChar

__RegularExpressionClassChar ::= ___RegularExpressionNonTerminatorButNotOneOfRbracketOrBackslash
                             | __RegularExpressionBackslashSequence

__RegularExpressionFlags ::=
__RegularExpressionFlags ::= __RegularExpressionFlags ___IdentifierPart

___IdentifierPart ~ ___IdentifierStart
                  | ___UnicodeCombiningMark
                  | ___UnicodeDigit
                  | ___UnicodeConnectorPunctuation
                  | ___ZWNJ
                  | ___ZWJ

___IdentifierStart ~ ___UnicodeLetter
                   | '$'
                   | '_'
                   | '\' ___UnicodeEscapeSequence
                   # ' for my editor

___UnicodeEscapeSequence                  ~ 'u' ___HexDigit ___HexDigit ___HexDigit ___HexDigit

___RegularExpressionNonTerminatorButNotOneOfStarOrBackslashOrSlashOrLbracket ~ [\p{IsRegularExpressionNonTerminatorButNotOneOfStarOrBackslashOrSlashOrLbracket}]
___RegularExpressionNonTerminatorButNotOneOfBackslashOrSlashOrLbracket       ~ [\p{IsRegularExpressionNonTerminatorButNotOneOfBackslashOrSlashOrLbracket}]
___RegularExpressionSourceCharacterButNotLineTerminator                      ~ [\p{IsSourceCharacterButNotLineTerminator}]
___RegularExpressionNonTerminatorButNotOneOfRbracketOrBackslash              ~ [\p{IsRegularExpressionNonTerminatorButNotOneOfRbracketOrBackslash}]
___UnicodeLetter                          ~ [\p{IsUnicodeLetter}]
___ZWNJ                        ~ [\p{IsZWJ}]
___ZWJ                         ~ [\p{IsZWJ}]
___UnicodeCombiningMark        ~ [\p{IsUnicodeCombiningMark }]
___UnicodeDigit                ~ [\p{IsUnicodeDigit}]
___UnicodeConnectorPunctuation ~ [\p{IsUnicodeConnectorPunctuation}]
___HexDigit          ~ [\p{IsHexDigit}]
