use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5;
use MarpaX::Languages::ECMAScript::AST::Impl;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Program;
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

=head2 new($class, %transpileOptions)

Instance a new object.

=cut

sub new {
  my ($class, %transpileOptions) = @_;

  my $self  = {};

  bless($self, $class);

  $self->_init(%transpileOptions);

  return $self;
}

sub _init {
    my ($self, %transpileOptions) = @_;

    my $program = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Program->new();
    $self->{_program} = {
	grammar => $program,
	impl => MarpaX::Languages::ECMAScript::AST::Impl->new($program->grammar_option(), $program->recce_option(), $program->G, 1)
    };
    $self->{_template} = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Template->new(%transpileOptions);

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

1;
