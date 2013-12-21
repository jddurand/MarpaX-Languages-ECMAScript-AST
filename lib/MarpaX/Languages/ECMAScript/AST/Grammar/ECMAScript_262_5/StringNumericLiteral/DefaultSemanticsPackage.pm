use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::StringNumericLiteral::DefaultSemanticsPackage;

# ABSTRACT: ECMAScript 262, Edition 5, lexical string numeric grammar default semantics package

# VERSION

=head1 DESCRIPTION

This modules provide a default semantics package for the actions associated to ECMAScript_262_5 lexical string numeric grammar.

=cut

=head2 new($class, $string)

Instantiate a new object.

=cut

sub new {
    my ($class, $string) = @_;
    my $self = {_number => $string};
    bless($self, $class);
    return $self;
}

=cut

=head2 mul($self, $objmul)

Multiply $self by $objmul.

=cut

sub mul {
    my ($self, $objmul) = @_;
    $self->{_number} *= $objmul->{_number};
}

=cut

=head2 sign($self, $sign)

Apply sign to $self.

=cut

sub sign {
    my ($self, $sign) = @_;
    if ($sign eq '-') {
	$self->{_number} *= -1;
    }
    $self->{_number};
}

=cut

=head2 round($self)

Round $self.

=cut

sub round {
    my ($self) = @_;
    $self->{_number};
}

=cut

=head2 pzero($self)

Positive zero.

=cut

sub pzero {
    my ($self) = @_;
    $self->{_number} = 0;
}

1;
