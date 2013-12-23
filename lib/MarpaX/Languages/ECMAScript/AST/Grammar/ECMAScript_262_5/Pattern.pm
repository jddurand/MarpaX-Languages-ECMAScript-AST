use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern;
use parent qw/MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base/;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern::Singleton;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern::DefaultSemanticsPackage;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses;
use SUPER;
use Carp qw/croak/;
use Scalar::Util qw/blessed/;

# ABSTRACT: ECMAScript-262, Edition 5, pattern grammar written in Marpa BNF

# VERSION

=head1 DESCRIPTION

This modules returns describes the ECMAScript 262, Edition 5 pattern grammar written in Marpa BNF, as of L<http://www.ecma-international.org/publications/standards/Ecma-262.htm>, section 15.10.1. This module inherits the methods from MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base package.

=head1 SYNOPSIS

    use strict;
    use warnings FATAL => 'all';
    use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern;

    my $grammar = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern->new();

    my $grammar_content = $grammar->content();
    my $grammar_option = $grammar->grammar_option();
    my $recce_option = $grammar->recce_option();

=cut

#
# Note that this grammar is NOT supposed to be injected in Program
#
our $grammar_source = do {local $/; <DATA>};

our $singleton = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern::Singleton->instance(
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

L<MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base>

L<MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern::DefaultSemanticsPackage>

=cut

sub _secondArg {
    return $_[2];
}

1;
__DATA__
# =================================
# ECMAScript Script Pattern grammar
# =================================
#
:start ::= Pattern

Pattern ::=
      Disjunction

Disjunction ::=
      Alternative
    | Alternative '|' Disjunction

Alternative ::=
Alternative ::= Alternative Term

Term ::=
      Assertion
    | Atom
    | Atom Quantifier

Assertion ::=
      '^'
    | '$'
    | '\b'
    | '\B'
    | '(?=' Disjunction ')'
    | '(?!' Disjunction ')'

Quantifier ::=
      QuantifierPrefix
    | QuantifierPrefix '?'

QuantifierPrefix ::=
      '*'
    | '+'
    | '?'
    | '{' DecimalDigits '}'
    | '{' DecimalDigits ',}'
    | '{' DecimalDigits ',' DecimalDigits '}'

Atom ::=
      PatternCharacter
    | '.'
    | '\' AtomEscape
    | CharacterClass
    | '(' Disjunction ')'
    | '(?:' Disjunction ')'

PatternCharacter ::=
      [\p{IsPatternCharacter}]

AtomEscape ::=
      DecimalEscape
    | CharacterEscape
    | CharacterClassEscape

CharacterEscape ::=
      ControlEscape
    | 'c' ControlLetter
    | HexEscapeSequence
    | UnicodeEscapeSequence
    | IdentityEscape

ControlEscape ::=
      [fnrtv]

ControlLetter ::=
      [a-zA-Z]

#
# What means "SourceCharacterbut not IdentifierPart":
# - first this is a SourceCharacter, i.e. one single (utf8) character
# - IdentifierPart is
#    [\p{IsUnicodeLetter}]
#  | '$'
#  | '_'
#  | '\' _UnicodeEscapeSequence       ELIMINATED: more than one character
#  | [\p{IsUnicodeCombiningMark }]
#  | [\p{IsUnicodeDigit}]
#  | [\p{IsUnicodeConnectorPunctuation}]
#  | _ZWNJ
#  | _ZWJ
#
# So this mean:
#  +IsSourceCharacter
#  -IsUnicodeLetter
#  -'$'
#  -'_'
#  -IsUnicodeCombiningMark
#  -IsUnicodeDigit
#  -IsUnicodeConnectorPunctuation

#IdentityEscape ::=
#      SourceCharacterbut not IdentifierPart
#    | <ZWJ>
#    | <ZWNJ>

IdentityEscape ::=
       [\p[IsIdentityEscape}]

DecimalEscape ::=
    _DecimalIntegerLiteral # Lookahead not in decimal digit is automatic

_DecimalIntegerLiteral ~
    '0'
  | __NonZeroDigit
  | __NonZeroDigit _DecimalDigits

_DecimalDigits ~
    __DecimalDigit
  | _DecimalDigits __DecimalDigit

__NonZeroDigit      ~ [\p{IsNonZeroDigit}]
__DecimalDigit      ~ [\p{IsDecimalDigit}]

CharacterClassEscape ::=
      [dDsSwW]

CharacterClass ::=
      '[' ClassRanges ']'
    | '[^' ClassRanges ']'

ClassRanges ::=
ClassRanges ::=
  NonemptyClassRanges

NonemptyClassRanges ::=
      ClassAtom
    | ClassAtom NonemptyClassRangesNoDash
    | ClassAtom '-' ClassAtom ClassRanges

NonemptyClassRangesNoDash ::=
    |  ClassAtom
    | ClassAtomNoDash NonemptyClassRangesNoDash
    | ClassAtomNoDash '-' ClassAtom ClassRanges

ClassAtom ::=
    | '-'
    | ClassAtomNoDash

ClassAtomNoDash ::=
      [\p{IsSourceCharacterButNotOneOfBackslashOrRbracketorMinus}]
    | '\' ClassEscape

ClassEscape ::=
      DecimalEscape
    | b
    | CharacterEscape
    | CharacterClassEscape
