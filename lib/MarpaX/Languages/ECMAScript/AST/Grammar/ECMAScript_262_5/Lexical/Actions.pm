use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Lexical::Actions;
use MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses qw//;

our $LF = chr(0x000A);

# ABSTRACT: ECMAScript 262, Edition 5, lexical grammar actions

# VERSION

=head1 DESCRIPTION

This modules give the actions associated to ECMAScript_262_5 lexical grammar.

=cut

=head2 new($class)

Instantiate a new object.

=cut

sub new {
    my $class = shift;
    my $self = {};
    bless($self, $class);
    return $self;
}

# Comments behave like white space and are discarded except that, if a MultiLineComment contains a line
# terminator character, then the entire comment is considered to be a LineTerminator for purposes of parsing by
# the syntactic grammar.

=head2 Comment($self, $commentp)

Comment action.

=cut

sub Comment {
    my ($self, $Commentp) = @_;

    #
    # lexeme is [start, length, value]
    #
    if (substr($Commentp->[0]->[2], 0, 2) eq '/*') {
	if ($Commentp->[0]->[2] =~ /[\p{MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses::IsLineTerminator}]/) {
	    $Commentp->[0] = bless [
		$Commentp->[0]->[0],
		$Commentp->[0]->[1],
		$LF], 'ECMAScript_262_5::AST::LineTerminator';
	} else {
	    $Commentp->[0] = undef;
	}
    } else {
	$Commentp->[0] = undef;
    }

    return $Commentp;
}

=head2 RemoveUndefinedComment($self, $InputElementsp)

RemoveUndefinedComment action.

=cut

sub RemoveUndefinedComment {
    my ($self, $InputElementsp) = @_;

    return [ grep {defined($_->[0]->[0])} @{$InputElementsp}];
}

1;
