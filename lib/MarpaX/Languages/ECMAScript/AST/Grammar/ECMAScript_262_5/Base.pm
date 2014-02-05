use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base;
use parent qw/MarpaX::Languages::ECMAScript::AST::Grammar::Base/;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses qw//;
use SUPER;

# ABSTRACT: ECMAScript-262, Edition 5, grammars base package

# VERSION

=head1 DESCRIPTION

This modules subclasses MarpaX::Languages::ECMAScript::AST::Grammar::Base for the ECMAScript-262 specification.

=head1 SYNOPSIS

    use strict;
    use warnings FATAL => 'all';
    use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Base;

    my $grammar = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5->new("grammar", "My::Package");

    my $grammar_content = $grammar->content();
    my $grammar_option = $grammar->grammar_option();
    my $recce_option = $grammar->recce_option();

=head1 SUBROUTINES/METHODS

=head2 new($grammar, $package)

Instance a new object. Takes a grammar and package name as required parameters.

=cut

sub new {
  my ($class) = @_;

  return $class->SUPER('ECMAScript_262_5');

}

=head1 SEE ALSO

L<MarpaX::Languages::ECMAScript::AST::Grammar::Base>

=cut

1;
