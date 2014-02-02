use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Uri;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern::Actions;
use Carp qw/croak/;

our $grammar_content = do {local $/; <DATA>};

# ABSTRACT: ECMAScript-262, Edition 5, grammar written in Marpa BNF

# VERSION

=head1 DESCRIPTION

This modules returns describes the ECMAScript 262, Edition 5, pattern grammar written in Marpa BNF, as of L<http://www.ecma-international.org/publications/standards/Ecma-262.htm>.

=head1 SYNOPSIS

    use strict;
    use warnings FATAL => 'all';
    use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern;

    my $grammar = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern->new();

    my $grammar_content = $grammar->content();
    my $grammar_option = $grammar->grammar_option();
    my $recce_option = $grammar->recce_option();

=head1 SUBROUTINES/METHODS

=head2 new()

Instance a new object. Takes no parameter.

=cut

sub new {
  my ($class) = @_;

  my $self  = {
    _grammar_option => {action_object  => sprintf('%s::%s', __PACKAGE__, 'Actions')},
    _recce_option => {ranking_method => 'high_rule_only'},
    _content => $grammar_content
  };
  #
  # Too painful to write MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses::IsSomething
  # so I change it on-the-fly here
  #
  $self->{_content} =~ s/\\p\{Is/\\p{MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses::Is/g;

  bless($self, $class);

  return $self;
}

=head2 content()

Returns the content of the grammar. Takes no argument.

=cut

sub content {
    my ($self) = @_;
    return $self->{_content};
}

=head2 grammar_option()

Returns recommended option for Marpa::R2::Scanless::G->new(), returned as a reference to a hash.

=cut

sub grammar_option {
    my ($self) = @_;
    return $self->{_grammar_option};
}

=head2 recce_option()

Returns recommended option for Marpa::R2::Scanless::R->new(), returned as a reference to a hash.

=cut

sub recce_option {
    my ($self) = @_;
    return $self->{_recce_option};
}

1;
__DATA__
#
# Defaults
#
:default ::= action => [values] bless => ::lhs
lexeme default = action => [start,length,value]

:start ::= Pattern

Pattern ::=
      Disjunction

Disjunction ::=
      Alternative
    | Alternative '|' Disjunction

Alternative ::=
Alternative ::=
      Alternative Term

Term ::=
      Assertion
    | Atom
    | Atom Quantifier

Assertion ::=
      '^'
    | '$'
    | '\' 'b'
    | '\' 'B'
    | '(' '?' '=' Disjunction ')'
    | '(' '?' '!' Disjunction ')'


Quantifier ::=
      QuantifierPrefix
    | QuantifierPrefix '?'

QuantifierPrefix ::=
      '*'
    | '+'
    | '?'
    | '{' DecimalDigits '}'
    | '{' DecimalDigits ',' '}'
    | '{' DecimalDigits ',' DecimalDigits '}'

Atom ::=
      PatternCharacter
    | '.'
    | '\' AtomEscape
# '
    | CharacterClass
    | '(' Disjunction ')'
    | '(' '?' ':' Disjunction ')'

PatternCharacter ~
    [\p{IsPatternCharacter}]

AtomEscape ::=
      DecimalEscape
    | CharacterEscape
    | CharacterClassEscape

CharacterEscape ::
      ControlEscape
    | 'c' ControlLetter
    | HexEscapeSequence
    | UnicodeEscapeSequence
    | IdentityEscape

ControlEscape ~
      [fnrtv]

ControlLetter ~
      [a-zA-Z]

IdentityEscape ~
      [\p{SourceCharacterbut not IdentifierPart}]
    | [\p{IsZWJ}]
    | [\p{ZWNJ}]

#
# Note: [lookahead not in DecimalDigit]
DecimalEscape ::=
      DecimalIntegerLiteral

CharacterClassEscape ~
      [dDsSwW]

CharacterClass ~
      '[' ClassRanges ']'
    | '[' '^' ClassRanges ']'

ClassRanges ~
ClassRanges ~
      NonemptyClassRanges

NonemptyClassRanges ~
      ClassAtom
    | ClassAtom NonemptyClassRangesNoDash
    | ClassAtom '-' ClassAtom ClassRanges

NonemptyClassRangesNoDash ~
      ClassAtom
    | ClassAtomNoDash NonemptyClassRangesNoDash
    | ClassAtomNoDash '-' ClassAtom ClassRanges

ClassAtom ~
      '-'
    | ClassAtomNoDash

ClassAtomNoDash ~
      [\p{IsSourceCharacterButNotOneOfBackslashOrRbracketOrMinus}]
    | '\' ClassEscape
# '
ClassEscape ~
      DecimalEscape
    | 'b'
    | CharacterEscape
    | CharacterClassEscape

