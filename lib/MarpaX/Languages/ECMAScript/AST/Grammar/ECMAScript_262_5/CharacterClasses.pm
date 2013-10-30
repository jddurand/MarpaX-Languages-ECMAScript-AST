use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses;
use MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses qw/:all/;

# ABSTRACT: ECMAScript-262, Edition 5, character classes

# VERSION

=head1 DESCRIPTION

This modules subclasses if needed MarpaX::Languages::ECMAScript::AST::Grammar::CharacterClasses. This is not really subclassing, because class methods cannot be overwrite using SUPER - and the parse is not Moose/Mouse/Moo whatever based.

=head1 SYNOPSIS

    use strict;
    use warnings FATAL => 'all';
    use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses;

=cut

1;
