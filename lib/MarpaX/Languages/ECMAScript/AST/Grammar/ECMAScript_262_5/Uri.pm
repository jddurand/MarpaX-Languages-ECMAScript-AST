use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::URI;
use parent qw/MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base/;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses;

our $grammar_content = do {local $/; <DATA>};

=head1 DESCRIPTION

This modules returns describes the ECMAScript 262, Edition 5 URI grammar written in Marpa BNF, as of L<http://www.ecma-international.org/publications/standards/Ecma-262.htm>. This module inherits the methods from MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base package.

=head1 SYNOPSIS

    use strict;
    use warnings FATAL => 'all';
    use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::URI;

    my $grammar = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::URI->new();

    my $grammar_content = $grammar->content();
    my $grammar_option = $grammar->grammar_option();
    my $recce_option = $grammar->recce_option();

=cut

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
:start ::= uri
:default ::= action => [values]
lexeme default = action => [start,length,value]

uri           ::= uriCharactersopt

uriCharactersopt ::= uriCharacters
uriCharactersopt ::=

uriCharacters    ::= uriCharacter+

uriCharacter  ::= uriReserved | uriUnescaped | uriEscaped

uriReserved   ~ [;/?:@&=+$,]

uriUnescaped  ::= uriAlpha | DecimalDigit | uriMark

uriEscaped    ~ '%' HexDigit HexDigit

uriAlpha      ~ [a-zA-Z]

uriMark       ~ [\-_\.!~\*'\(\)]

#
# Copy/pasted from Program grammar
#
DecimalDigit  ~ [\p{IsDecimalDigit}]

HexDigit      ~ [\p{IsHexDigit}]
