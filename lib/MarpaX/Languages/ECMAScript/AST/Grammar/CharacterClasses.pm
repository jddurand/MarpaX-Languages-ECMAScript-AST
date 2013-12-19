use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses;
use Exporter 'import';

# ABSTRACT: ECMAScript, character classes

# VERSION

=head1 DESCRIPTION

This modules defines generic user-defined character classes for ECMAScript. There is no notion of object here, only functions that can be imported using the tag qw/:all/.

=head1 SYNOPSIS

    use strict;
    use warnings FATAL => 'all';
    use MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses;

=cut

our @EXPORT_OK = qw/
Isb
IsBackslash
IsBOM
IsCaret
IsCR
IsDecimalDigit
IsDollar
IsDot
IsDquote
Ise
IsE
IsEight
IsEscapeCharacter
IsExponentIndicator
Isf
IsFF
IsHexDigit
IsLbracket
IsLcurly
IsLF
IsLineTerminator
IsLparen
IsLS
IsMinus
Isn
IsNBSP
IsNine
IsNonZeroDigit
IsOctalDigit
IsPatternCharacter
IsPipe
IsPlus
IsPS
IsQuestion_Mark
Isr
IsRbracket
IsRcurly
IsRegularExpressionNonTerminator
IsRegularExpressionNonTerminatorButNotOneOfBackslashOrSlashOrLbracket
IsRegularExpressionNonTerminatorButNotOneOfRbracketOrBackslash
IsRegularExpressionNonTerminatorButNotOneOfStarOrBackslashOrSlashOrLbracket
IsRparen
IsSingleEscapeCharacter
IsSlash
IsSourceCharacter
IsSourceCharacterButNotLineTerminator
IsSourceCharacterButNotOneOfBackslashOrRbracketorMinus
IsSourceCharacterButNotOneOfDquoteOrBackslashOrLineTerminator
IsSourceCharacterButNotOneOfEscapeCharacterOrLineTerminator
IsSourceCharacterButNotOneOfSlashOrStar
IsSourceCharacterButNotOneOfSlashOrStarOrLineTerminator
IsSourceCharacterButNotOneOfSquoteOrBackslashOrLineTerminator
IsSourceCharacterButNotSlash
IsSourceCharacterButNotStar
IsSourceCharacterButNotStarOrLineTerminator
IsSP
IsSquote
IsStar
Ist
IsTAB
Isu
IsUnicodeCombiningMark
IsUnicodeConnectorPunctuation
IsUnicodeDigit
IsUnicodeLetter
IsUSP
Isv
IsVT
IsWhiteSpace
Isx
IsZero
IsZeroToThree
IsFourToSeven
IsZWJ
IsZWNJ
/;
our %EXPORT_TAGS = ('all' => \@EXPORT_OK);

our $STAR            = sprintf('%x', ord('*'));
our $SLASH           = sprintf('%x', ord('/'));
our $BACKSLASH       = sprintf('%x', ord('\\'));
our $DQUOTE          = sprintf('%x', ord('"'));
our $SQUOTE          = sprintf('%x', ord("'"));
our $a               = sprintf('%x', ord('a'));
our $b               = sprintf('%x', ord('b'));
our $c               = sprintf('%x', ord('c'));
our $d               = sprintf('%x', ord('d'));
our $e               = sprintf('%x', ord('e'));
our $f               = sprintf('%x', ord('f'));
our $n               = sprintf('%x', ord('n'));
our $r               = sprintf('%x', ord('r'));
our $t               = sprintf('%x', ord('t'));
our $u               = sprintf('%x', ord('u'));
our $v               = sprintf('%x', ord('v'));
our $x               = sprintf('%x', ord('x'));
our $A               = sprintf('%x', ord('A'));
our $B               = sprintf('%x', ord('B'));
our $C               = sprintf('%x', ord('C'));
our $D               = sprintf('%x', ord('D'));
our $E               = sprintf('%x', ord('E'));
our $F               = sprintf('%x', ord('F'));
our $LBRACKET        = sprintf('%x', ord('['));
our $RBRACKET        = sprintf('%x', ord(']'));
our $LPAREN          = sprintf('%x', ord('('));
our $RPAREN          = sprintf('%x', ord(')'));
our $LCURLY          = sprintf('%x', ord('{'));
our $RCURLY          = sprintf('%x', ord('}'));
our $CARET           = sprintf('%x', ord('^'));
our $DOLLAR          = sprintf('%x', ord('$'));
our $DOT             = sprintf('%x', ord('.'));
our $PLUS            = sprintf('%x', ord('+'));
our $QUESTION_MARK   = sprintf('%x', ord('?'));
our $PIPE            = sprintf('%x', ord('|'));
our $MINUS           = sprintf('%x', ord('-'));
our $ZERO            = sprintf('%x', ord('0'));
our $ONE             = sprintf('%x', ord('1'));
our $TWO             = sprintf('%x', ord('2'));
our $THREE           = sprintf('%x', ord('3'));
our $FOUR            = sprintf('%x', ord('4'));
our $FIVE            = sprintf('%x', ord('5'));
our $SIX             = sprintf('%x', ord('6'));
our $SEVEN           = sprintf('%x', ord('7'));
our $EIGHT           = sprintf('%x', ord('8'));
our $NINE            = sprintf('%x', ord('9'));

=head2 IsWhiteSpace()

=cut

sub IsWhiteSpace { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsTAB
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsVT
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsFF
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSP
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsNBSP
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsBOM
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsUSP
END
}

=head2 IsSourceCharacter()

=cut

sub IsSourceCharacter { return <<END;
+utf8::Any
END
}

=head2 IsZWNJ()

=cut

sub IsZWNJ { return <<END;
200C
END
}

=head2 sub IsZWJ()

=cut

sub IsZWJ { return <<END;
200D
END
}

=head2 IsBOM()

=cut

sub IsBOM { return <<END;
FEFF
END
}

=head2 IsTAB()

=cut

sub IsTAB { return <<END;
0009
END
}

=head2 IsVT()

=cut

sub IsVT { return <<END;
000B
END
}

=head2 IsFF()

=cut

sub IsFF { return <<END;
000C
END
}

=head2 IsSP()

=cut

sub IsSP { return <<END;
0020
END
}

=head2 IsNBSP()

=cut

sub IsNBSP { return <<END;
00A0
END
}

=head2 IsUSP()

=cut

sub IsUSP { return <<END;
+utf8::Zs
END
}

=head2 IsLF()

=cut

sub IsLF { return <<END;
000A
END
}

=head2 IsCR()

=cut

sub IsCR { return <<END;
000D
END
}

=head2 IsLS()

=cut

sub IsLS { return <<END;
2028
END
}

=head2 IsPS()

=cut

sub IsPS { return <<END;
2029
END
}

=head2 IsSourceCharacterButNotStar()

=cut

sub IsSourceCharacterButNotStar { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSourceCharacter
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsStar
END
}

=head2 IsSourceCharacterButNotStarOrLineTerminator()

=cut

sub IsSourceCharacterButNotStarOrLineTerminator { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSourceCharacter
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsStar
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsLineTerminator
END
}

=head2 IsSourceCharacterButNotOneOfSlashOrStar()

=cut

sub IsSourceCharacterButNotOneOfSlashOrStar { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSourceCharacter
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSlash
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsStar
END
}

=head2 IsSourceCharacterButNotSlash()

=cut

sub IsSourceCharacterButNotSlash { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSourceCharacter
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSlash
END
}

=head2 IsSourceCharacterButNotOneOfSlashOrStarOrLineTerminator()

=cut

sub IsSourceCharacterButNotOneOfSlashOrStarOrLineTerminator { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSourceCharacter
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSlash
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsStar
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsLineTerminator
END
}

=head2 IsLineTerminator()

=cut

sub IsLineTerminator { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsLF
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsCR
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsLS
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsPS
END
}

=head2 IsSourceCharacterButNotLineTerminator()

=cut

sub IsSourceCharacterButNotLineTerminator { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSourceCharacter
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsLineTerminator
END
}

=head2 IsUnicodeLetter()

=cut

sub IsUnicodeLetter { return <<END;
+utf8::Lu
+utf8::Ll
+utf8::Lt
+utf8::Lm
+utf8::Lo
+utf8::Nl
END
}

=head2 IsUnicodeCombiningMark()

=cut

sub IsUnicodeCombiningMark { return <<END;
+utf8::Mn
+utf8::Mc
END
}

=head2 IsUnicodeDigit()

=cut

sub IsUnicodeDigit { return <<END;
+utf8::Nd
END
}

=head2 IsUnicodeConnectorPunctuation()

=cut

sub IsUnicodeConnectorPunctuation { return <<END;
+utf8::Pc
END
}

=head2 IsSourceCharacterButNotOneOfDquoteOrBackslashOrLineTerminator()

=cut

sub IsSourceCharacterButNotOneOfDquoteOrBackslashOrLineTerminator { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSourceCharacter
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsDquote
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsBackslash
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsLineTerminator
END
}

=head2 IsSourceCharacterButNotOneOfSquoteOrBackslashOrLineTerminator()

=cut

sub IsSourceCharacterButNotOneOfSquoteOrBackslashOrLineTerminator { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSourceCharacter
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSquote
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsBackslash
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsLineTerminator
END
}

=head2 IsSingleEscapeCharacter()

=cut

sub IsSingleEscapeCharacter { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSquote
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsDquote
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsBackslash
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::Isb
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::Isf
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::Isn
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::Isr
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::Ist
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::Isv
END
}

#
# Note: PosixDigit is a perl extension, changed to be coherent with RT #91120
#
=head2 IsDecimalDigit()

=cut

sub IsDecimalDigit { return <<END;
$ZERO
$ONE
$TWO
$THREE
$FOUR
$FIVE
$SIX
$SEVEN
$EIGHT
$NINE
END
}

=head2 IsOctalDigit()

=cut

sub IsOctalDigit { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsDecimalDigit
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsEight
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsNine
END
}

=head2 IsNonZeroDigit()

=cut

sub IsNonZeroDigit { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsDecimalDigit
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsZero
END
}

=head2 IsEscapeCharacter()

=cut

sub IsEscapeCharacter { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSingleEscapeCharacter
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsDecimalDigit
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::Isx
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::Isu
END
}

=head2 IsSourceCharacterButNotOneOfEscapeCharacterOrLineTerminator()

=cut

sub IsSourceCharacterButNotOneOfEscapeCharacterOrLineTerminator { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSourceCharacter
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsEscapeCharacter
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsLineTerminator
END
}

=head2 IsRegularExpressionNonTerminator()

=cut

sub IsRegularExpressionNonTerminator { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSourceCharacter
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsLineTerminator
END
}

=head2 IsRegularExpressionNonTerminatorButNotOneOfStarOrBackslashOrSlashOrLbracket()

=cut

sub IsRegularExpressionNonTerminatorButNotOneOfStarOrBackslashOrSlashOrLbracket { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsRegularExpressionNonTerminator
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsStar
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsBackslash
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSlash
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsLbracket
END
}

=head2 IsRegularExpressionNonTerminatorButNotOneOfBackslashOrSlashOrLbracket()

=cut

sub IsRegularExpressionNonTerminatorButNotOneOfBackslashOrSlashOrLbracket { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsRegularExpressionNonTerminator
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsBackslash
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSlash
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsLbracket
END
}

=head2 IsRegularExpressionNonTerminatorButNotOneOfRbracketOrBackslash()

=cut

sub IsRegularExpressionNonTerminatorButNotOneOfRbracketOrBackslash { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsRegularExpressionNonTerminator
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsRbracket
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsBackslash
END
}

#
# Note: PosixXDigit is a perl extension, not available before perl-5.12.5 RT #91120
#
=head2 IsHexDigit()

=cut

sub IsHexDigit { return <<END;
$ZERO
$ONE
$TWO
$THREE
$FOUR
$FIVE
$SIX
$SEVEN
$EIGHT
$NINE
$A
$B
$C
$D
$E
$F
$a
$b
$c
$d
$e
$f
END
}

=head2 IsExponentIndicator()

=cut

sub IsExponentIndicator { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::Ise
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsE
END
}

=head2 IsPatternCharacter()

=cut

sub IsPatternCharacter { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsRegularExpressionNonTerminator
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsCaret
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsDollar
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsBackslash
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsDot
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsStar
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsPlus
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsQuestion_Mark
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsLparen
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsRparen
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsLbracket
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsRbracket
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsLcurly
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsRcurly
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsPipe
END
}

=head2 IsSourceCharacterButNotOneOfBackslashOrRbracketorMinus()

=cut

sub IsSourceCharacterButNotOneOfBackslashOrRbracketorMinus { return <<END;
+MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsSourceCharacter
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsBackslash
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsRbracket
-MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses::IsMinus
END
}

# -------------------------------------------------------------------

=head2 Isx()

=cut

sub Isx { return <<END;
$x
END
}

=head2 Isu()

=cut

sub Isu { return <<END;
$u
END
}

=head2 Isv()

=cut

sub Isv { return <<END;
$v
END
}

=head2 IsStar()

=cut

sub IsStar { return <<END;
$STAR
END
}

=head2 IsBackslash()

=cut

sub IsBackslash { return <<END;
$BACKSLASH
END
}

=head2 IsCaret()

=cut

sub IsCaret { return <<END;
$CARET
END
}

=head2 IsDollar()

=cut

sub IsDollar { return <<END;
$DOLLAR
END
}

=head2 IsDot()

=cut

sub IsDot { return <<END;
$DOT
END
}

=head2 IsLparen()

=cut

sub IsLparen { return <<END;
$LPAREN
END
}

=head2 IsRparen()

=cut

sub IsRparen { return <<END;
$RPAREN
END
}

=head2 IsLcurly()

=cut

sub IsLcurly { return <<END;
$LCURLY
END
}

=head2 IsRcurly()

=cut

sub IsRcurly { return <<END;
$RCURLY
END
}

=head2 IsQuestion_Mark()

=cut

sub IsQuestion_Mark { return <<END;
$QUESTION_MARK
END
}

=head2 IsPlus()

=cut

sub IsPlus { return <<END;
$PLUS
END
}

=head2 IsMinus()

=cut

sub IsMinus { return <<END;
$MINUS
END
}

=head2 IsSquote()

=cut

sub IsSquote { return <<END;
$SQUOTE
END
}

=head2 IsDquote()

=cut

sub IsDquote { return <<END;
$DQUOTE
END
}

=head2 IsPipe()

=cut

sub IsPipe { return <<END;
$PIPE
END
}

=head2 IsSlash()

=cut

sub IsSlash { return <<END;
$SLASH
END
}

=head2 IsLbracket()

=cut

sub IsLbracket { return <<END;
$LBRACKET
END
}

=head2 IsRbracket()

=cut

sub IsRbracket { return <<END;
$RBRACKET
END
}


=head2 Isb()

=cut

sub Isb { return <<END;
$b
END
}

=head2 Isf()

=cut

sub Isf { return <<END;
$f
END
}

=head2 Ise()

=cut

sub Ise { return <<END;
$e
END
}

=head2 IsE()

=cut

sub IsE { return <<END;
$E
END
}

=head2 Isn()

=cut

sub Isn { return <<END;
$n
END
}

=head2 Isr()

=cut

sub Isr { return <<END;
$r
END
}

=head2 Ist()

=cut

sub Ist { return <<END;
$t
END
}

=head2 IsZero()

=cut

sub IsZero { return <<END;
$ZERO
END
}

=head2 IsEight()

=cut

sub IsEight { return <<END;
$EIGHT
END
}

=head2 IsNine()

=cut

sub IsNine { return <<END;
$NINE
END
}

=head2 IsZeroToThree()

=cut

sub IsZeroToThree { return <<END;
$ZERO
$ONE
$TWO
$THREE
END
}

=head2 IsFourToSeven()

=cut

sub IsFourToSeven { return <<END;
$FOUR
$FIVE
$SIX
$SEVEN
END
}

=head1 EXPORTS

This module is exporting on demand the following tags:

=over

=item all

All functions.

=back

1;
