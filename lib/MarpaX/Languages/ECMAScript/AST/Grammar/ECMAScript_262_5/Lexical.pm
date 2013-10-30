use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical;
use parent qw/MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base/;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::Actions;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::StringLiteral;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::NumericLiteral;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::RegularExpressionLiteral;
use Carp qw/croak/;
use Log::Any qw/$log/;
use SUPER;

# ABSTRACT: ECMAScript-262, Edition 5, lexical grammar written in Marpa BNF

# VERSION

=head1 DESCRIPTION

This modules returns describes the ECMAScript 262, Edition 5 lexical grammar written in Marpa BNF, as of L<http://www.ecma-international.org/publications/standards/Ecma-262.htm>. This module inherits the methods from MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base package.

=head1 SYNOPSIS

    use strict;
    use warnings FATAL => 'all';
    use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical;

    my $grammar = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical->new();

    my $grammar_content = $grammar->content();
    my $grammar_option = $grammar->grammar_option();
    my $recce_option = $grammar->recce_option();

=cut

our @FutureReservedWordStrict = qw/
      implements
      let
      private
      public
      yield
      interface
      package
      protected
      static/;

=head1 SUBROUTINES/METHODS

=head2 new($class, $program)

Instance a new object of class $class. $program is a required parameter of type MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical. The lexical grammar will feed the $program grammar.

=cut

sub new {
    my ($class, $program) = @_;

    my $grammar_source = do {local $/; <DATA>};

    my $search = '# DO NOT REMOVE NOR MODIFY THIS LINE';
    #
    # Injection of grammars.
    #
    my $StringLiteral = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::StringLiteral->new();
    my $NumericLiteral = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::NumericLiteral->new();
    my $RegularExpressionLiteral = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::RegularExpressionLiteral->new();

    $grammar_source .= $StringLiteral->extract;
    $grammar_source .= $NumericLiteral->extract;
    $grammar_source .= $RegularExpressionLiteral->extract;

    my $self = $class->SUPER($grammar_source, __PACKAGE__);

    $self->{_program} = $program;

    return $self;
}

=head2 parse($self, $sourcep)

Parse the source given as reference to a scalar.

=cut

sub parse {
    my ($self, $sourcep, $impl) = @_;
    return $self->SUPER($sourcep, $impl,
	{
	    '_DecimalLiteral$'     => \&_DecimalLiteral,
	    '_HexIntegerLiteral$'  => \&_HexIntegerLiteral,
	    '_OctalIntegerLiteral$'=> \&_OctalIntegerLiteral,
	    '_IdentifierName$'     => \&_IdentifierName
	});
}

sub _IdentifierName {
    my ($self, $lexemeHashp, $sourcep, $impl) = @_;

    if ($self->strict) {
	if (grep {$lexemeHashp->{value} eq $_} @FutureReservedWordStrict) {
	    croak "IdentifierName $lexemeHashp->{value} is forbidden in strict mode";
	}
    }

}

sub _DecimalLiteral {
    my ($self, $lexemeHashp, $sourcep, $impl) = @_;

    $self->_NumericLiteralLookhead($lexemeHashp, $sourcep, $impl);
}

sub _OctalIntegerLiteral {
    my ($self, $lexemeHashp, $sourcep, $impl) = @_;

    if ($self->strict) {
	croak "OctalIntegerLiteral $lexemeHashp->{value} is forbidden in strict mode";
    }

}

sub _HexIntegerLiteral {
    my ($self, $lexemeHashp, $sourcep, $impl) = @_;

    $self->_NumericLiteralLookhead($lexemeHashp, $sourcep, $impl);
}

sub _NumericLiteralLookhead {
    my ($self, $lexemeHashp, $sourcep, $impl) = @_;
    #
    #
    # The source character immediately following a NumericLiteral must not be an IdentifierStart or DecimalDigit.
    #
    my $prevpos = pos(${$sourcep});
    pos(${$sourcep}) = $lexemeHashp->{start} + $lexemeHashp->{length};
    # __DecimalDigit      ~ [\p{IsDecimalDigit}]
    if (${$sourcep} =~ /\G
                        (
                         (?:                                                                                               # __IdentifierStart ~
                           [\p{MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses::IsUnicodeLetter}\$_]   #                     __UnicodeLetter
                           |                                                                                               #                   |
                           \$                                                                                              #                     '$'
                           |                                                                                               #                   |
                           _                                                                                               #                     '_'
                           |                                                                                               #                   |
                           \\u[\p{MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses::IsHexDigit}]{4}     #                     '\' __UnicodeEscapeSequence
                         )
                         |                                                                                                 # |
                         (?:                                                                                               # __DecimalDigit ~
                           [\p{MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses::IsDecimalDigit}]       #                   [\p{IsDecimalDigit}]
                         )
                        )
                       /x) {
	my $match = substr(${$sourcep}, $-[1], $+[1] - $-[1]);
	croak "NumericLiteral $lexemeHashp->{value} is followed by an IdentifierStart or a DecimalDigit '$match'";
    }
    pos(${$sourcep}) = $prevpos;
}

=head1 SEE ALSO

L<MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base>

=cut

1;
__DATA__
# ===========================
# ECMAScript Script Lexical Grammar
# ===========================
#
# The source text of an ECMAScript program is first converted into a sequence of input elements, which are
# tokens, line terminators, comments, or white space.
#
:start ::= InputElements
:default ::= action => [values] bless => ::lhs
lexeme default = action => [start,length,value]

# ***************************************************************
#                            G1 rules
# ***************************************************************
InputElements ::= InputElement+       action => RemoveUndefinedComment

InputElement ::=  LineTerminator
               | MultiLineComment
               | IdentifierName
               | Punctuator
               | DecimalLiteral
               | HexIntegerLiteral
               | OctalIntegerLiteral
               | StringLiteral
               | DivPunctuator
               | RegularExpressionLiteral
               | Keyword
               | FutureReservedWord
               | NullLiteral
               | BooleanLiteral

LineTerminator           ::= _LineTerminator
MultiLineComment         ::= _MultiLineComment                          action => Comment
IdentifierName           ::= _IdentifierName
Punctuator               ::= _Punctuator
DecimalLiteral           ::= _DecimalLiteral
HexIntegerLiteral        ::= _HexIntegerLiteral
OctalIntegerLiteral      ::= _OctalIntegerLiteral
StringLiteral            ::= _StringLiteral                    
DivPunctuator            ::= _DivPunctuator
RegularExpressionLiteral ::= _RegularExpressionLiteral
Keyword                  ::= _Keyword
FutureReservedWord       ::= _FutureReservedWord
NullLiteral              ::= _NullLiteral
BooleanLiteral           ::= _BooleanLiteral

#
# WhiteSpace and SingleLineComment are always discarded from the input stream.
# MultiLineComment MAY be discarded, unless it contains at least one line terminator.
# This is why it not in the :discard section. It will be discarded eventually
# after the lexeme is read
#
:discard ~ _WhiteSpace
:discard ~ _SingleLineComment

# ***************************************************************
#                            G0 Lexemes
# ***************************************************************
:lexeme ~ <_Keyword>                      priority => 1
:lexeme ~ <_FutureReservedWord>           priority => 1
:lexeme ~ <_NullLiteral>                  priority => 1
:lexeme ~ <_BooleanLiteral>               priority => 1
:lexeme ~ <_StringLiteral>                pause => after event => '_StringLiteral$'
:lexeme ~ <_DecimalLiteral>               pause => after event => '_DecimalLiteral$'
:lexeme ~ <_HexIntegerLiteral>            pause => after event => '_HexIntegerLiteral$'
:lexeme ~ <_OctalIntegerLiteral>          pause => after event => '_OctalIntegerLiteral$'
:lexeme ~ <_IdentifierName>               pause => after event => '_IdentifierName$'

_WhiteSpace               ~ __WhiteSpace
_LineTerminator           ~ __LineTerminator
_SingleLineComment        ~ __SingleLineComment
_MultiLineComment         ~ __MultiLineComment
_IdentifierName           ~ __IdentifierName
_Punctuator               ~ __Punctuator
_DecimalLiteral           ~ __DecimalLiteral
_HexIntegerLiteral        ~ __HexIntegerLiteral
_OctalIntegerLiteral      ~ __OctalIntegerLiteral
_StringLiteral            ~ __StringLiteral
_DivPunctuator            ~ __DivPunctuator
_RegularExpressionLiteral ~ __RegularExpressionLiteral
_Keyword                  ~ __Keyword
_FutureReservedWord       ~ __FutureReservedWord
_NullLiteral              ~ __NullLiteral
_BooleanLiteral           ~ __BooleanLiteral

# ***************************************************************
#                        Internal G0 Rules
# ***************************************************************

__WhiteSpace ~ [\p{IsWhiteSpace}]

# ---------------------------------------------------------------

__LineTerminator ~ [\p{IsLineTerminator}]

# ---------------------------------------------------------------

__Keyword ~
      'break'
    | 'do'
    | 'instanceof'
    | 'typeof'
    | 'case'
    | 'else'
    | 'new'
    | 'var'
    | 'catch'
    | 'finally'
    | 'return'
    | 'void'
    | 'continue'
    | 'for'
    | 'switch'
    | 'while'
    | 'debugger'
    | 'function'
    | 'this'
    | 'with'
    | 'default'
    | 'if'
    | 'throw'
    | 'delete'
    | 'in'
    | 'try'

# ---------------------------------------------------------------

__FutureReservedWord ~
      'class'
    | 'enum'
    | 'extends'
    | 'super'
    | 'const'
    | 'export'
    | 'import'

# ---------------------------------------------------------------

__NullLiteral ~
      'null'

# ---------------------------------------------------------------

__BooleanLiteral ~
      'true'
    | 'false'

# ---------------------------------------------------------------

__Punctuator ~
      '{'
    | '}'
    | '('
    | ')'
    | '['
    | ']'
    | '.'
    | ';'
    | ','
    | '<'
    | '>'
    | '<='
    | '>='
    | '=='
    | '!='
    | '==='
    | '!=='
    | '+'
    | '-'
    | '*'
    | '%'
    | '++'
    | '--'
    | '<<'
    | '>>'
    | '>>>'
    | '&'
    | '|'
    | '^'
    | '!'
    | '~'
    | '&&'
    | '||'
    | '?'
    | ':'
    | '='
    | '+='
    | '-='
    | '*='
    | '%='
    | '<<='
    | '>>='
    | '>>>='
    | '&='
    | '|='
    | '^='

# ---------------------------------------------------------------

__DivPunctuator ~
      '/'
    | '/='

# ---------------------------------------------------------------
# __StringLiteral grammar will be injected
# ---------------------------------------------------------------

__SingleLineComment        ~ '//' __SingleLineCommentCharsopt

__SingleLineCommentChars   ~ __SingleLineCommentChar __SingleLineCommentCharsopt

__SingleLineCommentCharsopt ~ __SingleLineCommentChars
__SingleLineCommentCharsopt ~

__SingleLineCommentChar                  ~ [\p{IsSourceCharacterButNotLineTerminator}]

# ---------------------------------------------------------------

__MultiLineComment         ~ '/*' __MultiLineCommentCharsopt '*/'

__MultiLineCommentChars    ~  __MultiLineNotAsteriskChar __MultiLineCommentCharsopt
                             | '*' __PostAsteriskCommentCharsopt

__PostAsteriskCommentChars ~ __MultiLineNotForwardSlashOrAsteriskChar __MultiLineCommentCharsopt
                             | '*' __PostAsteriskCommentCharsopt

__MultiLineCommentCharsopt ~ __MultiLineCommentChars
__MultiLineCommentCharsopt ~

__PostAsteriskCommentCharsopt ~ __PostAsteriskCommentChars
__PostAsteriskCommentCharsopt ~

__MultiLineNotAsteriskChar               ~ [\p{IsSourceCharacterButNotStar}]
__MultiLineNotForwardSlashOrAsteriskChar ~ [\p{IsSourceCharacterButNotOneOfSlashOrStar}]

__UnicodeEscapeSequence                  ~ 'u' __HexDigit __HexDigit __HexDigit __HexDigit

# ---------------------------------------------------------------

__IdentifierName ~ __IdentifierStart
                 | __IdentifierName __IdentifierPart


__UnicodeLetter                          ~ [\p{IsUnicodeLetter}]

__IdentifierStart ~ __UnicodeLetter
                  | '$'
                  | '_'
                  | '\' __UnicodeEscapeSequence
                  # ' for my editor

__ZWNJ                        ~ [\p{IsZWJ}]
__ZWJ                         ~ [\p{IsZWJ}]
__UnicodeCombiningMark        ~ [\p{IsUnicodeCombiningMark }]
__UnicodeDigit                ~ [\p{IsUnicodeDigit}]
__UnicodeConnectorPunctuation ~ [\p{IsUnicodeConnectorPunctuation}]

__IdentifierPart ~ __IdentifierStart
                 | __UnicodeCombiningMark
                 | __UnicodeDigit
                 | __UnicodeConnectorPunctuation
                 | __ZWNJ
                 | __ZWJ

__ExponentIndicator ~ [\p{IsExponentIndicator}]
__DecimalDigit      ~ [\p{IsDecimalDigit}]
__NonZeroDigit      ~ [\p{IsNonZeroDigit}]
__HexDigit          ~ [\p{IsHexDigit}]

# ---------------------------------------------------------------
# __DecimalLiteral grammar will be injected
# ---------------------------------------------------------------

# ---------------------------------------------------------------
# __RegularExpressionLiteral grammar will be injected
# ---------------------------------------------------------------
