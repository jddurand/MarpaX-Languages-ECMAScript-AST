use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Program::Actions;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::StringLiteral;
our $StringLiteral = MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::StringLiteral->new();

# ABSTRACT: ECMAScript 262, Edition 5, lexical expressions grammar actions

# VERSION

use constant AST => 'MarpaX::Languages::ECMAScript::AST';

=head1 DESCRIPTION

This modules give the actions associated to ECMAScript_262_5 lexical expressions grammar.

=head1 SUBROUTINES/METHODS

=head2 new($class)

Instantiate a new object.

=cut

sub new {
    my $class = shift;
    my $self = {cachedStringLiteralG => undef};
    bless($self, $class);
    return $self;
}

=head2 valuesAndRuleId($self, @values)

Default G1 action: a hash with the following keys:

=over

=item ruleId

G1 rule Id

=item values

Reference to an array containing the values

=back

=cut

sub valuesAndRuleId {
  my $self = shift;

  #
  # Note: we do not include Marpa explicitely: this is done in one unique
  # place, i.e. Impl.pm.
  #
  return {values => [ @_ ], ruleId => $Marpa::R2::Context::rule};
}

=head2 StringLiteral($self, $lexemeActionValuep)

StringLiteral action.

=cut

sub StringLiteral {
    my ($self, $lexemeActionValuep) = @_;

    #
    # StringLiteral is already in the good lexeme value format: [start,length,value]
    #
    # We just re-evaluate the value. Per def there is no need to eval, the lexeme
    # got matched.
    #
    # It is quite consuming to redo a full grammar stuff. So instead let's look at
    # the differences between a true perl string and a JavaScript string.
    # The difference is always related with escape sequence thingies, c.f.
    # StringTerminal/Actions.pm
    #

    my $impl = MarpaX::Languages::ECMAScript::AST::Impl->new($StringLiteral->grammar_option(), $StringLiteral->recce_option(), $self->{cachedStringLiteralG});
    $self->{cachedStringLiteralG} = $impl->grammar;
    $lexemeActionValuep->[2] = $StringLiteral->parse($lexemeActionValuep->[2], $impl)->value($impl);

    return $lexemeActionValuep;
}

1;
