use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5;
use MarpaX::Languages::ECMAScript::AST::Impl;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Program;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Template;

# ABSTRACT: ECMAScript-262, Edition 5, grammar

# VERSION

=head1 DESCRIPTION

This modules returns all grammars needed for the ECMAScript 262, Edition 5 grammars written in Marpa BNF, as of L<http://www.ecma-international.org/publications/standards/Ecma-262.htm>.

=head1 SYNOPSIS

    use strict;
    use warnings FATAL => 'all';
    use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5;

    my $ecma = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5->new();

    my $program = $ecma->program();

=head1 SUBROUTINES/METHODS

=head2 new($class, $optionsp)

Instance a new object.Takes as optional argument a reference to a hash that may contain the following key/values:

=over

=item Template

Reference to hash containing options for MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Template. These options can be:

=over

=item g1Callback

G1 callback (CODE ref)

=item g1CallbackArgs

G1 callback arguments (ARRAY ref). The g1 callback is called like: &$g1Callback(@{$g1CallbackArgs}, \$rc, $ruleId, $value, $index, $lhs, @rhs), where $value is the AST parse tree value of RHS No $index of this G1 rule number $ruleId, whose full definition is $lhs ::= @rhs. If the callback is defined, this will always be executed first, and it must return a true value putting its eventual result in $rc. Only when it returns true, lexemes are processed.

=item lexemeCallback

lexeme callback (CODE ref).

=item lexemeCallbackArgs

Lexeme callback arguments (ARRAY ref). The lexeme callback is called like: &$lexemeCallback(@{$lexemeCallbackArgs}, \$rc, $name, $ruleId, $value, $index, $lhs, @rhs), where $value is the AST parse tree value of RHS No $index of this G1 rule number $ruleId, whose full definition is $lhs ::= @rhs. The RHS being a lexeme, $name contains the lexeme's name. If the callback is defined, this will always be executed first, and it must return a true value putting its result in $rc, otherwise default behaviour applies: return the lexeme value as-is.

=back

=over StringNumericLiteral

Reference to hash containing options for MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral. These options can be:

=over

=item semantics_package

Semantic package providing host implementation of a Number.

=back

=back

=cut

sub new {
  my ($class, $optionsp) = @_;

  my $self  = {};

  bless($self, $class);

  $self->_init($optionsp);

  return $self;
}

sub _init {
    my ($self, $optionsp) = @_;

    $optionsp //= {};

    my $program = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Program->new();
    $self->{_program} = {
	grammar => $program,
	impl => MarpaX::Languages::ECMAScript::AST::Impl->new($program->grammar_option(), $program->recce_option(), $program->G, 1)
    };

    my $stringNumericLiteralOptionsp = exists($optionsp->{StringNumericLiteral}) ? $optionsp->{StringNumericLiteral} : undef;
    my $stringNumericLiteral = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral->new($stringNumericLiteralOptionsp);
    $self->{_stringNumericLiteral} = {
	grammar => $stringNumericLiteral,
	impl => MarpaX::Languages::ECMAScript::AST::Impl->new($stringNumericLiteral->grammar_option(), $stringNumericLiteral->recce_option(), $stringNumericLiteral->G, 1)
    };

    my $templateOptionsp = exists($optionsp->{Template}) ? $optionsp->{Template} : undef;
    $self->{_template} = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Template->new($templateOptionsp);

}

=head2 program()

Returns the program grammar as a hash reference that is

=over

=item grammar

A MarpaX::Languages::ECMAScript::AST::Grammar::Base object

=item impl

A MarpaX::Languages::ECMAScript::AST::Impl object

=back

=cut

sub program {
    my ($self) = @_;

    return $self->{_program};
}

=head2 template()

Returns the template associated to this grammar. This is a MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Template object.

=cut

sub template {
    my ($self) = @_;

    return $self->{_template};
}

=head2 stringNumericLiteral()

Returns the StringNumericLiteral grammar as a hash reference that is

=over

=item grammar

A MarpaX::Languages::ECMAScript::AST::Grammar::Base object

=item impl

A MarpaX::Languages::ECMAScript::AST::Impl object

=back

=cut

sub stringNumericLiteral {
    my ($self) = @_;

    return $self->{_stringNumericLiteral};
}

=head 1 SEE ALSO

L<MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral>

L<MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Template>

=cut

1;
