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

sub _Pattern_Disjunction {
    my ($self, $disjunction) = @_;

    my $m = $self->evaluate($disjunction);

    return sub {
      my ($str, $index) = @_;

      my $input = $str;
      my $inputLength = length($str);

      my $c = sub {
        my ($state) = @_;
        return $state;
      };
      my $cap = [ ($self->undefined) x $self->nCapturingParens ];
      my $x = [$index, $cap];
      return &$m($x, $c);
    };
}

sub _Disjunction_Alternative {
    my ($self, $alternative) = @_;
    return $self->evaluate($alternative);
}

sub _Disjunction_Alternative_OR_Disjunction {
    my ($self, $alternative, $disjunction) = @_;

    my $m1 = $self->evaluate($alternative);
    my $m2 = $self->evaluate($disjunction);

    return sub {
	my ($x, $c) = @_;
	my $r = &$m1($x, $c);
        if ($self->isFailure($r) != $self->true) {
          return $r;
        }
        return &$m2($x, $c);
    };
}

sub _Alternative {
    my ($self) = @_;

    return sub {
	my ($x, $c) = @_;
	return &$c($x);
    };
}

sub _Alternative_Alternative_Term {
    my ($self, $alternative, $term) = @_;

    my $m1 = $self->evaluate($alternative);
    my $m2 = $self->evaluate($term);

  return sub {
      my ($x, $c) = @_;
      my $d = sub {
	  my ($y) = @_;
	  return &$m2($y, $c);
      };
      return &$m1($x, $d);
  };
}

sub _Term_Assertion {
    my ($self, $assertion) = @_;

    return sub {
	my ($x, $c) = @_;

	my $t = $self->evaluate($assertion);
	my $r = &$t($x);
	if ($self->isFalse($r)) {
	    return $self->failure;
	}
	return &$c($x);
    };
}

sub _Term_Atom {
    my ($self, $atom) = @_;

    return $self->evaluate($atom);
}

sub _Term_Atom_Quantifier {
    my ($self, $atom, $quantifier) = @_;

    my $m = $self->evaluate($atom);
    my ($min, $max, $greedy) = $self->evaluate($quantifier);
    if ($self->isFinite($max) && $self->isLt($max, $min)) {
      $self->syntaxError("$max < $min");
    }
}

1;
__DATA__
# =================================
# ECMAScript Script Pattern grammar
# =================================
#
:start ::= Pattern
:default ::= action => [values]
lexeme default = action => [start,length,value]

Pattern ::=
      Disjunction                       action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern::_Pattern_Disjunction

Disjunction ::=
      Alternative                       action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern::_Disjunction_Alternative
    | Alternative '|' Disjunction       action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern::_Disjunction_Alternative_OR_Disjunction

Alternative ::=                         action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern::_Alternative
Alternative ::= Alternative Term        action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern::_Alternative_Alternative_Term

Term ::=
      Assertion                         action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern::_Term_Assertion
    | Atom                              action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern::_Term_Atom
    | Atom Quantifier                   action => MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern::_Term_Atom_Quantifier

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
       [\p{IsIdentityEscape}]

DecimalEscape ::=
    DecimalIntegerLiteral # Lookahead not in decimal digit is automatic

DecimalIntegerLiteral ::=
    '0'
  | _NonZeroDigit
  | _NonZeroDigit DecimalDigits

DecimalDigits ::=
    _DecimalDigit
  | DecimalDigits _DecimalDigit

_NonZeroDigit      ~ [\p{IsNonZeroDigit}]
_DecimalDigit      ~ [\p{IsDecimalDigit}]

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
      ClassAtom
    | ClassAtomNoDash NonemptyClassRangesNoDash
    | ClassAtomNoDash '-' ClassAtom ClassRanges

ClassAtom ::=
      '-'
    | ClassAtomNoDash

ClassAtomNoDash ::=
      [\p{IsSourceCharacterButNotOneOfBackslashOrRbracketorMinus}]
    | '\' ClassEscape

ClassEscape ::=
      DecimalEscape
    | 'b'
    | CharacterEscape
    | CharacterClassEscape

HexEscapeSequence ::= 'x' _HexDigit _HexDigit

UnicodeEscapeSequence ::= 'u' _HexDigit _HexDigit _HexDigit _HexDigit

_HexDigit              ~ [\p{IsHexDigit}]

