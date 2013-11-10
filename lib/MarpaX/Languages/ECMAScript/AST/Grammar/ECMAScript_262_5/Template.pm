#
# This is a generated file using the command:
# /usr/bin/perl script/generateTemplate.pl ECMAScript-262-5
#
use strict;
use warnings FATAL => 'all';
no warnings 'recursion';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Template;

# ABSTRACT: Template for ECMAScript_262_5 transpilation using an AST


# VERSION

=head1 DESCRIPTION

Generated generic template.

=head1 SUBROUTINES/METHODS

=head2 new($class, %options)

Instantiate a new object.

=cut

sub new {
    my ($class, %options) = @_;

    my $self = {_nindent => 0};
    bless($self, $class);
    return $self;
}

=head2 lexeme($self, $value)

Returns the characters of lexeme inside $value, that is an array reference. C.f. grammar default lexeme action.

=cut

sub lexeme {
    my ($self, $value) = @_;

    my $lexeme = $value->[2];
    my $rc = '';
    if    ($lexeme eq ';') { $rc = " ;\n" . $self->indent();  }
    elsif ($lexeme eq '{') { $rc = " {\n" . $self->indent(1); }
    elsif ($lexeme eq '}') { $rc = "\n"  . $self->indent(-1) . " }\n" . $self->indent();}
    else                   { $rc = " $lexeme"; }

    return $rc;
}

=head2 indent($self, $inc)

Returns indentation, i.e. two spaces times current number of indentations. Optional $inc is used to change the number of indentations.

=cut

sub indent {
    my ($self, $inc) = @_;

    if (defined($inc)) {
	$self->{_nindent} += $inc;
    }

    return '  ' x $self->{_nindent};
}

=head2 transpile($self, $ast)

Tranpiles the $ast AST, that is the parse tree value from Marpa.

=cut

sub transpile {
    my ($self, $ast) = @_;

    my @worklist = ($ast);
    my $transpile = '';
    do {
	my $obj = shift(@worklist);
	if (ref($obj) eq 'HASH') {
	    my $g1 = 'G1_' . $obj->{ruleId};
	    # print STDERR "==> @{$obj->{values}}\n";
	    foreach (reverse 0..$#{$obj->{values}}) {
		my $value = $obj->{values}->[$_];
		if (ref($value) eq 'HASH') {
		    # print STDERR "Unshift $value\n";
		    unshift(@worklist, $value);
		} else {
		    # print STDERR "Unshift [ $g1, $value, $_ ]\n";
		    unshift(@worklist, [ $g1, $value, $_ ]);
		}
	    }
	} else {
	    my ($curMethod, $value, $index) = @{$obj};
	    # print STDERR "==> Calling $curMethod($value, $index)\n";
	    $transpile .= $self->$curMethod($value, $index);
	    # print STDERR "==> $transpile\n";
	}
    } while (@worklist);

    return $transpile;

#    my ($ruleId, $value) = ($ast->{ruleId}, $ast->{values});
#    my $method = "G1_$ruleId";
#    return $self->$method($value);
}


=head2 G1_0($self, $value, $index)

Transpilation of G1 rule No 0, i.e. [:start] ::= Program

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_0 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_1($self, $value, $index)

Transpilation of G1 rule No 1, i.e. Literal ::= NullLiteral

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_1 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_2($self, $value, $index)

Transpilation of G1 rule No 2, i.e. Literal ::= BooleanLiteral

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_2 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_3($self, $value, $index)

Transpilation of G1 rule No 3, i.e. Literal ::= NumericLiteral

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_3 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_4($self, $value, $index)

Transpilation of G1 rule No 4, i.e. Literal ::= StringLiteral

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_4 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_5($self, $value, $index)

Transpilation of G1 rule No 5, i.e. Literal ::= RegularExpressionLiteral

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_5 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_6($self, $value, $index)

Transpilation of G1 rule No 6, i.e. NumericLiteral ::= DECIMALLITERAL

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_6 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_7($self, $value, $index)

Transpilation of G1 rule No 7, i.e. NumericLiteral ::= HEXINTEGERLITERAL

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_7 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_8($self, $value, $index)

Transpilation of G1 rule No 8, i.e. NumericLiteral ::= OCTALINTEGERLITERAL

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_8 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_9($self, $value, $index)

Transpilation of G1 rule No 9, i.e. PrimaryExpression ::= THIS

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_9 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_10($self, $value, $index)

Transpilation of G1 rule No 10, i.e. PrimaryExpression ::= IDENTIFIER

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_10 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_11($self, $value, $index)

Transpilation of G1 rule No 11, i.e. PrimaryExpression ::= Literal

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_11 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_12($self, $value, $index)

Transpilation of G1 rule No 12, i.e. PrimaryExpression ::= ArrayLiteral

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_12 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_13($self, $value, $index)

Transpilation of G1 rule No 13, i.e. PrimaryExpression ::= ObjectLiteral

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_13 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_14($self, $value, $index)

Transpilation of G1 rule No 14, i.e. PrimaryExpression ::= LPAREN Expression RPAREN

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_14 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_15($self, $value, $index)

Transpilation of G1 rule No 15, i.e. ArrayLiteral ::= LBRACKET Elisionopt RBRACKET

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_15 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_16($self, $value, $index)

Transpilation of G1 rule No 16, i.e. ArrayLiteral ::= LBRACKET ElementList RBRACKET

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_16 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_17($self, $value, $index)

Transpilation of G1 rule No 17, i.e. ArrayLiteral ::= LBRACKET ElementList COMMA Elisionopt RBRACKET

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_17 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 3) {
    }
    elsif ($index == 4) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_18($self, $value, $index)

Transpilation of G1 rule No 18, i.e. ElementList ::= Elisionopt AssignmentExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_18 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_19($self, $value, $index)

Transpilation of G1 rule No 19, i.e. ElementList ::= ElementList COMMA Elisionopt AssignmentExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_19 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }
    elsif ($index == 3) {
    }

    return $rc;
}


=head2 G1_20($self, $value, $index)

Transpilation of G1 rule No 20, i.e. Elision ::= COMMA

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_20 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_21($self, $value, $index)

Transpilation of G1 rule No 21, i.e. Elision ::= Elision COMMA

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_21 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_22($self, $value, $index)

Transpilation of G1 rule No 22, i.e. Elisionopt ::= Elision

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_22 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_23($self, $value, $index)

Transpilation of G1 rule No 23, i.e. Elisionopt ::= 

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_23 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}


=head2 G1_24($self, $value, $index)

Transpilation of G1 rule No 24, i.e. ObjectLiteral ::= LCURLY RCURLY

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_24 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_25($self, $value, $index)

Transpilation of G1 rule No 25, i.e. ObjectLiteral ::= LCURLY PropertyNameAndValueList RCURLY

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_25 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_26($self, $value, $index)

Transpilation of G1 rule No 26, i.e. ObjectLiteral ::= LCURLY PropertyNameAndValueList COMMA RCURLY

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_26 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 3) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_27($self, $value, $index)

Transpilation of G1 rule No 27, i.e. PropertyNameAndValueList ::= PropertyAssignment

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_27 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_28($self, $value, $index)

Transpilation of G1 rule No 28, i.e. PropertyNameAndValueList ::= PropertyNameAndValueList COMMA PropertyAssignment

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_28 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_29($self, $value, $index)

Transpilation of G1 rule No 29, i.e. PropertyAssignment ::= PropertyName COLON AssignmentExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_29 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_30($self, $value, $index)

Transpilation of G1 rule No 30, i.e. PropertyAssignment ::= GET PropertyName LPAREN RPAREN LCURLY FunctionBody RCURLY

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_30 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 3) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 4) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 5) {
    }
    elsif ($index == 6) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_31($self, $value, $index)

Transpilation of G1 rule No 31, i.e. PropertyAssignment ::= SET PropertyName LPAREN PropertySetParameterList RPAREN LCURLY FunctionBody RCURLY

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_31 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 3) {
    }
    elsif ($index == 4) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 5) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 6) {
    }
    elsif ($index == 7) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_32($self, $value, $index)

Transpilation of G1 rule No 32, i.e. PropertyName ::= IDENTIFIERNAME

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_32 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_33($self, $value, $index)

Transpilation of G1 rule No 33, i.e. PropertyName ::= StringLiteral

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_33 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_34($self, $value, $index)

Transpilation of G1 rule No 34, i.e. PropertyName ::= NumericLiteral

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_34 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_35($self, $value, $index)

Transpilation of G1 rule No 35, i.e. PropertySetParameterList ::= IDENTIFIER

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_35 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_36($self, $value, $index)

Transpilation of G1 rule No 36, i.e. MemberExpression ::= PrimaryExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_36 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_37($self, $value, $index)

Transpilation of G1 rule No 37, i.e. MemberExpression ::= FunctionExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_37 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_38($self, $value, $index)

Transpilation of G1 rule No 38, i.e. MemberExpression ::= MemberExpression LBRACKET Expression RBRACKET

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_38 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }
    elsif ($index == 3) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_39($self, $value, $index)

Transpilation of G1 rule No 39, i.e. MemberExpression ::= MemberExpression DOT IDENTIFIERNAME

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_39 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_40($self, $value, $index)

Transpilation of G1 rule No 40, i.e. MemberExpression ::= NEW MemberExpression Arguments

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_40 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_41($self, $value, $index)

Transpilation of G1 rule No 41, i.e. NewExpression ::= MemberExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_41 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_42($self, $value, $index)

Transpilation of G1 rule No 42, i.e. NewExpression ::= NEW NewExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_42 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_43($self, $value, $index)

Transpilation of G1 rule No 43, i.e. CallExpression ::= MemberExpression Arguments

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_43 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_44($self, $value, $index)

Transpilation of G1 rule No 44, i.e. CallExpression ::= CallExpression Arguments

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_44 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_45($self, $value, $index)

Transpilation of G1 rule No 45, i.e. CallExpression ::= CallExpression LBRACKET Expression RBRACKET

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_45 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }
    elsif ($index == 3) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_46($self, $value, $index)

Transpilation of G1 rule No 46, i.e. CallExpression ::= CallExpression DOT IDENTIFIERNAME

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_46 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_47($self, $value, $index)

Transpilation of G1 rule No 47, i.e. Arguments ::= LPAREN RPAREN

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_47 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_48($self, $value, $index)

Transpilation of G1 rule No 48, i.e. Arguments ::= LPAREN ArgumentList RPAREN

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_48 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_49($self, $value, $index)

Transpilation of G1 rule No 49, i.e. ArgumentList ::= AssignmentExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_49 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_50($self, $value, $index)

Transpilation of G1 rule No 50, i.e. ArgumentList ::= ArgumentList COMMA AssignmentExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_50 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_51($self, $value, $index)

Transpilation of G1 rule No 51, i.e. LeftHandSideExpression ::= NewExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_51 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_52($self, $value, $index)

Transpilation of G1 rule No 52, i.e. LeftHandSideExpression ::= CallExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_52 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_53($self, $value, $index)

Transpilation of G1 rule No 53, i.e. PostfixExpression ::= LeftHandSideExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_53 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_54($self, $value, $index)

Transpilation of G1 rule No 54, i.e. PostfixExpression ::= LeftHandSideExpression PLUSPLUS_POSTFIX

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_54 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_55($self, $value, $index)

Transpilation of G1 rule No 55, i.e. PostfixExpression ::= LeftHandSideExpression MINUSMINUS_POSTFIX

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_55 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_56($self, $value, $index)

Transpilation of G1 rule No 56, i.e. UnaryExpression ::= PostfixExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_56 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_57($self, $value, $index)

Transpilation of G1 rule No 57, i.e. UnaryExpression ::= DELETE UnaryExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_57 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_58($self, $value, $index)

Transpilation of G1 rule No 58, i.e. UnaryExpression ::= VOID UnaryExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_58 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_59($self, $value, $index)

Transpilation of G1 rule No 59, i.e. UnaryExpression ::= TYPEOF UnaryExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_59 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_60($self, $value, $index)

Transpilation of G1 rule No 60, i.e. UnaryExpression ::= PLUSPLUS UnaryExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_60 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_61($self, $value, $index)

Transpilation of G1 rule No 61, i.e. UnaryExpression ::= MINUSMINUS UnaryExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_61 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_62($self, $value, $index)

Transpilation of G1 rule No 62, i.e. UnaryExpression ::= PLUS UnaryExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_62 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_63($self, $value, $index)

Transpilation of G1 rule No 63, i.e. UnaryExpression ::= MINUS UnaryExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_63 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_64($self, $value, $index)

Transpilation of G1 rule No 64, i.e. UnaryExpression ::= INVERT UnaryExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_64 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_65($self, $value, $index)

Transpilation of G1 rule No 65, i.e. UnaryExpression ::= NOT UnaryExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_65 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_66($self, $value, $index)

Transpilation of G1 rule No 66, i.e. MultiplicativeExpression ::= UnaryExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_66 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_67($self, $value, $index)

Transpilation of G1 rule No 67, i.e. MultiplicativeExpression ::= MultiplicativeExpression MUL UnaryExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_67 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_68($self, $value, $index)

Transpilation of G1 rule No 68, i.e. MultiplicativeExpression ::= MultiplicativeExpression DIV UnaryExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_68 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_69($self, $value, $index)

Transpilation of G1 rule No 69, i.e. MultiplicativeExpression ::= MultiplicativeExpression MODULUS UnaryExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_69 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_70($self, $value, $index)

Transpilation of G1 rule No 70, i.e. AdditiveExpression ::= MultiplicativeExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_70 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_71($self, $value, $index)

Transpilation of G1 rule No 71, i.e. AdditiveExpression ::= AdditiveExpression PLUS MultiplicativeExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_71 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_72($self, $value, $index)

Transpilation of G1 rule No 72, i.e. AdditiveExpression ::= AdditiveExpression MINUS MultiplicativeExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_72 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_73($self, $value, $index)

Transpilation of G1 rule No 73, i.e. ShiftExpression ::= AdditiveExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_73 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_74($self, $value, $index)

Transpilation of G1 rule No 74, i.e. ShiftExpression ::= ShiftExpression LEFTMOVE AdditiveExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_74 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_75($self, $value, $index)

Transpilation of G1 rule No 75, i.e. ShiftExpression ::= ShiftExpression RIGHTMOVE AdditiveExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_75 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_76($self, $value, $index)

Transpilation of G1 rule No 76, i.e. ShiftExpression ::= ShiftExpression RIGHTMOVEFILL AdditiveExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_76 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_77($self, $value, $index)

Transpilation of G1 rule No 77, i.e. RelationalExpression ::= ShiftExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_77 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_78($self, $value, $index)

Transpilation of G1 rule No 78, i.e. RelationalExpression ::= RelationalExpression LT ShiftExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_78 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_79($self, $value, $index)

Transpilation of G1 rule No 79, i.e. RelationalExpression ::= RelationalExpression GT ShiftExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_79 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_80($self, $value, $index)

Transpilation of G1 rule No 80, i.e. RelationalExpression ::= RelationalExpression LE ShiftExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_80 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_81($self, $value, $index)

Transpilation of G1 rule No 81, i.e. RelationalExpression ::= RelationalExpression GE ShiftExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_81 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_82($self, $value, $index)

Transpilation of G1 rule No 82, i.e. RelationalExpression ::= RelationalExpression INSTANCEOF ShiftExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_82 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_83($self, $value, $index)

Transpilation of G1 rule No 83, i.e. RelationalExpression ::= RelationalExpression IN ShiftExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_83 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_84($self, $value, $index)

Transpilation of G1 rule No 84, i.e. RelationalExpressionNoIn ::= ShiftExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_84 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_85($self, $value, $index)

Transpilation of G1 rule No 85, i.e. RelationalExpressionNoIn ::= RelationalExpressionNoIn LT ShiftExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_85 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_86($self, $value, $index)

Transpilation of G1 rule No 86, i.e. RelationalExpressionNoIn ::= RelationalExpressionNoIn GT ShiftExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_86 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_87($self, $value, $index)

Transpilation of G1 rule No 87, i.e. RelationalExpressionNoIn ::= RelationalExpressionNoIn LE ShiftExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_87 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_88($self, $value, $index)

Transpilation of G1 rule No 88, i.e. RelationalExpressionNoIn ::= RelationalExpressionNoIn GE ShiftExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_88 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_89($self, $value, $index)

Transpilation of G1 rule No 89, i.e. RelationalExpressionNoIn ::= RelationalExpressionNoIn INSTANCEOF ShiftExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_89 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_90($self, $value, $index)

Transpilation of G1 rule No 90, i.e. EqualityExpression ::= RelationalExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_90 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_91($self, $value, $index)

Transpilation of G1 rule No 91, i.e. EqualityExpression ::= EqualityExpression EQ RelationalExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_91 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_92($self, $value, $index)

Transpilation of G1 rule No 92, i.e. EqualityExpression ::= EqualityExpression NE RelationalExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_92 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_93($self, $value, $index)

Transpilation of G1 rule No 93, i.e. EqualityExpression ::= EqualityExpression STRICTEQ RelationalExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_93 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_94($self, $value, $index)

Transpilation of G1 rule No 94, i.e. EqualityExpression ::= EqualityExpression STRICTNE RelationalExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_94 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_95($self, $value, $index)

Transpilation of G1 rule No 95, i.e. EqualityExpressionNoIn ::= RelationalExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_95 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_96($self, $value, $index)

Transpilation of G1 rule No 96, i.e. EqualityExpressionNoIn ::= EqualityExpressionNoIn EQ RelationalExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_96 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_97($self, $value, $index)

Transpilation of G1 rule No 97, i.e. EqualityExpressionNoIn ::= EqualityExpressionNoIn NE RelationalExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_97 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_98($self, $value, $index)

Transpilation of G1 rule No 98, i.e. EqualityExpressionNoIn ::= EqualityExpressionNoIn STRICTEQ RelationalExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_98 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_99($self, $value, $index)

Transpilation of G1 rule No 99, i.e. EqualityExpressionNoIn ::= EqualityExpressionNoIn STRICTNE RelationalExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_99 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_100($self, $value, $index)

Transpilation of G1 rule No 100, i.e. BitwiseANDExpression ::= EqualityExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_100 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_101($self, $value, $index)

Transpilation of G1 rule No 101, i.e. BitwiseANDExpression ::= BitwiseANDExpression BITAND EqualityExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_101 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_102($self, $value, $index)

Transpilation of G1 rule No 102, i.e. BitwiseANDExpressionNoIn ::= EqualityExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_102 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_103($self, $value, $index)

Transpilation of G1 rule No 103, i.e. BitwiseANDExpressionNoIn ::= BitwiseANDExpressionNoIn BITAND EqualityExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_103 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_104($self, $value, $index)

Transpilation of G1 rule No 104, i.e. BitwiseXORExpression ::= BitwiseANDExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_104 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_105($self, $value, $index)

Transpilation of G1 rule No 105, i.e. BitwiseXORExpression ::= BitwiseXORExpression BITXOR BitwiseANDExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_105 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_106($self, $value, $index)

Transpilation of G1 rule No 106, i.e. BitwiseXORExpressionNoIn ::= BitwiseANDExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_106 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_107($self, $value, $index)

Transpilation of G1 rule No 107, i.e. BitwiseXORExpressionNoIn ::= BitwiseXORExpressionNoIn BITXOR BitwiseANDExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_107 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_108($self, $value, $index)

Transpilation of G1 rule No 108, i.e. BitwiseORExpression ::= BitwiseXORExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_108 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_109($self, $value, $index)

Transpilation of G1 rule No 109, i.e. BitwiseORExpression ::= BitwiseORExpression BITOR BitwiseXORExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_109 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_110($self, $value, $index)

Transpilation of G1 rule No 110, i.e. BitwiseORExpressionNoIn ::= BitwiseXORExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_110 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_111($self, $value, $index)

Transpilation of G1 rule No 111, i.e. BitwiseORExpressionNoIn ::= BitwiseORExpressionNoIn BITOR BitwiseXORExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_111 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_112($self, $value, $index)

Transpilation of G1 rule No 112, i.e. LogicalANDExpression ::= BitwiseORExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_112 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_113($self, $value, $index)

Transpilation of G1 rule No 113, i.e. LogicalANDExpression ::= LogicalANDExpression AND BitwiseORExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_113 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_114($self, $value, $index)

Transpilation of G1 rule No 114, i.e. LogicalANDExpressionNoIn ::= BitwiseORExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_114 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_115($self, $value, $index)

Transpilation of G1 rule No 115, i.e. LogicalANDExpressionNoIn ::= LogicalANDExpressionNoIn AND BitwiseORExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_115 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_116($self, $value, $index)

Transpilation of G1 rule No 116, i.e. LogicalORExpression ::= LogicalANDExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_116 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_117($self, $value, $index)

Transpilation of G1 rule No 117, i.e. LogicalORExpression ::= LogicalORExpression OR LogicalANDExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_117 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_118($self, $value, $index)

Transpilation of G1 rule No 118, i.e. LogicalORExpressionNoIn ::= LogicalANDExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_118 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_119($self, $value, $index)

Transpilation of G1 rule No 119, i.e. LogicalORExpressionNoIn ::= LogicalORExpressionNoIn OR LogicalANDExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_119 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_120($self, $value, $index)

Transpilation of G1 rule No 120, i.e. ConditionalExpression ::= LogicalORExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_120 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_121($self, $value, $index)

Transpilation of G1 rule No 121, i.e. ConditionalExpression ::= LogicalORExpression QUESTION_MARK AssignmentExpression COLON AssignmentExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_121 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }
    elsif ($index == 3) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 4) {
    }

    return $rc;
}


=head2 G1_122($self, $value, $index)

Transpilation of G1 rule No 122, i.e. ConditionalExpressionNoIn ::= LogicalORExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_122 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_123($self, $value, $index)

Transpilation of G1 rule No 123, i.e. ConditionalExpressionNoIn ::= LogicalORExpressionNoIn QUESTION_MARK AssignmentExpression COLON AssignmentExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_123 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }
    elsif ($index == 3) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 4) {
    }

    return $rc;
}


=head2 G1_124($self, $value, $index)

Transpilation of G1 rule No 124, i.e. AssignmentExpression ::= ConditionalExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_124 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_125($self, $value, $index)

Transpilation of G1 rule No 125, i.e. AssignmentExpression ::= LeftHandSideExpression ASSIGN AssignmentExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_125 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_126($self, $value, $index)

Transpilation of G1 rule No 126, i.e. AssignmentExpression ::= LeftHandSideExpression AssignmentOperator AssignmentExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_126 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_127($self, $value, $index)

Transpilation of G1 rule No 127, i.e. AssignmentExpressionNoIn ::= ConditionalExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_127 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_128($self, $value, $index)

Transpilation of G1 rule No 128, i.e. AssignmentExpressionNoIn ::= LeftHandSideExpression ASSIGN AssignmentExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_128 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_129($self, $value, $index)

Transpilation of G1 rule No 129, i.e. AssignmentExpressionNoIn ::= LeftHandSideExpression AssignmentOperator AssignmentExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_129 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_130($self, $value, $index)

Transpilation of G1 rule No 130, i.e. AssignmentOperator ::= MULASSIGN

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_130 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_131($self, $value, $index)

Transpilation of G1 rule No 131, i.e. AssignmentOperator ::= DIVASSIGN

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_131 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_132($self, $value, $index)

Transpilation of G1 rule No 132, i.e. AssignmentOperator ::= MODULUSASSIGN

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_132 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_133($self, $value, $index)

Transpilation of G1 rule No 133, i.e. AssignmentOperator ::= PLUSASSIGN

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_133 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_134($self, $value, $index)

Transpilation of G1 rule No 134, i.e. AssignmentOperator ::= MINUSASSIGN

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_134 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_135($self, $value, $index)

Transpilation of G1 rule No 135, i.e. AssignmentOperator ::= LEFTMOVEASSIGN

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_135 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_136($self, $value, $index)

Transpilation of G1 rule No 136, i.e. AssignmentOperator ::= RIGHTMOVEASSIGN

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_136 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_137($self, $value, $index)

Transpilation of G1 rule No 137, i.e. AssignmentOperator ::= RIGHTMOVEFILLASSIGN

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_137 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_138($self, $value, $index)

Transpilation of G1 rule No 138, i.e. AssignmentOperator ::= BITANDASSIGN

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_138 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_139($self, $value, $index)

Transpilation of G1 rule No 139, i.e. AssignmentOperator ::= BITXORASSIGN

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_139 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_140($self, $value, $index)

Transpilation of G1 rule No 140, i.e. AssignmentOperator ::= BITORASSIGN

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_140 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_141($self, $value, $index)

Transpilation of G1 rule No 141, i.e. Expression ::= AssignmentExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_141 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_142($self, $value, $index)

Transpilation of G1 rule No 142, i.e. Expression ::= Expression COMMA AssignmentExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_142 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_143($self, $value, $index)

Transpilation of G1 rule No 143, i.e. ExpressionNoIn ::= AssignmentExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_143 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_144($self, $value, $index)

Transpilation of G1 rule No 144, i.e. ExpressionNoIn ::= ExpressionNoIn COMMA AssignmentExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_144 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_145($self, $value, $index)

Transpilation of G1 rule No 145, i.e. Statement ::= Block

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_145 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_146($self, $value, $index)

Transpilation of G1 rule No 146, i.e. Statement ::= VariableStatement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_146 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_147($self, $value, $index)

Transpilation of G1 rule No 147, i.e. Statement ::= EmptyStatement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_147 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_148($self, $value, $index)

Transpilation of G1 rule No 148, i.e. Statement ::= ExpressionStatement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_148 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_149($self, $value, $index)

Transpilation of G1 rule No 149, i.e. Statement ::= IfStatement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_149 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_150($self, $value, $index)

Transpilation of G1 rule No 150, i.e. Statement ::= IterationStatement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_150 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_151($self, $value, $index)

Transpilation of G1 rule No 151, i.e. Statement ::= ContinueStatement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_151 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_152($self, $value, $index)

Transpilation of G1 rule No 152, i.e. Statement ::= BreakStatement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_152 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_153($self, $value, $index)

Transpilation of G1 rule No 153, i.e. Statement ::= ReturnStatement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_153 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_154($self, $value, $index)

Transpilation of G1 rule No 154, i.e. Statement ::= WithStatement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_154 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_155($self, $value, $index)

Transpilation of G1 rule No 155, i.e. Statement ::= LabelledStatement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_155 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_156($self, $value, $index)

Transpilation of G1 rule No 156, i.e. Statement ::= SwitchStatement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_156 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_157($self, $value, $index)

Transpilation of G1 rule No 157, i.e. Statement ::= ThrowStatement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_157 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_158($self, $value, $index)

Transpilation of G1 rule No 158, i.e. Statement ::= TryStatement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_158 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_159($self, $value, $index)

Transpilation of G1 rule No 159, i.e. Statement ::= DebuggerStatement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_159 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_160($self, $value, $index)

Transpilation of G1 rule No 160, i.e. Block ::= LCURLY StatementListopt RCURLY

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_160 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_161($self, $value, $index)

Transpilation of G1 rule No 161, i.e. StatementList ::= Statement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_161 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_162($self, $value, $index)

Transpilation of G1 rule No 162, i.e. StatementList ::= StatementList Statement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_162 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_163($self, $value, $index)

Transpilation of G1 rule No 163, i.e. VariableStatement ::= VAR VariableDeclarationList SEMICOLON

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_163 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_164($self, $value, $index)

Transpilation of G1 rule No 164, i.e. VariableDeclarationList ::= VariableDeclaration

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_164 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_165($self, $value, $index)

Transpilation of G1 rule No 165, i.e. VariableDeclarationList ::= VariableDeclarationList COMMA VariableDeclaration

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_165 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_166($self, $value, $index)

Transpilation of G1 rule No 166, i.e. VariableDeclarationListNoIn ::= VariableDeclarationNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_166 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_167($self, $value, $index)

Transpilation of G1 rule No 167, i.e. VariableDeclarationListNoIn ::= VariableDeclarationListNoIn COMMA VariableDeclarationNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_167 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_168($self, $value, $index)

Transpilation of G1 rule No 168, i.e. VariableDeclaration ::= IDENTIFIER Initialiseropt

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_168 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_169($self, $value, $index)

Transpilation of G1 rule No 169, i.e. VariableDeclarationNoIn ::= IDENTIFIER InitialiserNoInopt

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_169 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_170($self, $value, $index)

Transpilation of G1 rule No 170, i.e. Initialiseropt ::= Initialiser

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_170 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_171($self, $value, $index)

Transpilation of G1 rule No 171, i.e. Initialiseropt ::= 

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_171 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}


=head2 G1_172($self, $value, $index)

Transpilation of G1 rule No 172, i.e. Initialiser ::= ASSIGN AssignmentExpression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_172 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_173($self, $value, $index)

Transpilation of G1 rule No 173, i.e. InitialiserNoInopt ::= InitialiserNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_173 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_174($self, $value, $index)

Transpilation of G1 rule No 174, i.e. InitialiserNoInopt ::= 

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_174 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}


=head2 G1_175($self, $value, $index)

Transpilation of G1 rule No 175, i.e. InitialiserNoIn ::= ASSIGN AssignmentExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_175 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_176($self, $value, $index)

Transpilation of G1 rule No 176, i.e. EmptyStatement ::= VISIBLE_SEMICOLON

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_176 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_177($self, $value, $index)

Transpilation of G1 rule No 177, i.e. ExpressionStatement ::= Expression SEMICOLON

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_177 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_178($self, $value, $index)

Transpilation of G1 rule No 178, i.e. IfStatement ::= IF LPAREN Expression RPAREN Statement ELSE Statement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_178 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }
    elsif ($index == 3) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 4) {
    }
    elsif ($index == 5) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 6) {
    }

    return $rc;
}


=head2 G1_179($self, $value, $index)

Transpilation of G1 rule No 179, i.e. IfStatement ::= IF LPAREN Expression RPAREN Statement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_179 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }
    elsif ($index == 3) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 4) {
    }

    return $rc;
}


=head2 G1_180($self, $value, $index)

Transpilation of G1 rule No 180, i.e. ExpressionNoInopt ::= ExpressionNoIn

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_180 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_181($self, $value, $index)

Transpilation of G1 rule No 181, i.e. ExpressionNoInopt ::= 

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_181 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}


=head2 G1_182($self, $value, $index)

Transpilation of G1 rule No 182, i.e. Expressionopt ::= Expression

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_182 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_183($self, $value, $index)

Transpilation of G1 rule No 183, i.e. Expressionopt ::= 

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_183 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}


=head2 G1_184($self, $value, $index)

Transpilation of G1 rule No 184, i.e. IterationStatement ::= DO Statement WHILE LPAREN Expression RPAREN SEMICOLON

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_184 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 3) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 4) {
    }
    elsif ($index == 5) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 6) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_185($self, $value, $index)

Transpilation of G1 rule No 185, i.e. IterationStatement ::= WHILE LPAREN Expression RPAREN Statement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_185 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }
    elsif ($index == 3) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 4) {
    }

    return $rc;
}


=head2 G1_186($self, $value, $index)

Transpilation of G1 rule No 186, i.e. IterationStatement ::= FOR LPAREN ExpressionNoInopt VISIBLE_SEMICOLON Expressionopt VISIBLE_SEMICOLON Expressionopt RPAREN Statement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_186 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }
    elsif ($index == 3) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 4) {
    }
    elsif ($index == 5) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 6) {
    }
    elsif ($index == 7) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 8) {
    }

    return $rc;
}


=head2 G1_187($self, $value, $index)

Transpilation of G1 rule No 187, i.e. IterationStatement ::= FOR LPAREN VAR VariableDeclarationListNoIn VISIBLE_SEMICOLON Expressionopt VISIBLE_SEMICOLON Expressionopt RPAREN Statement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_187 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 3) {
    }
    elsif ($index == 4) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 5) {
    }
    elsif ($index == 6) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 7) {
    }
    elsif ($index == 8) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 9) {
    }

    return $rc;
}


=head2 G1_188($self, $value, $index)

Transpilation of G1 rule No 188, i.e. IterationStatement ::= FOR LPAREN LeftHandSideExpression IN Expression RPAREN Statement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_188 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }
    elsif ($index == 3) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 4) {
    }
    elsif ($index == 5) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 6) {
    }

    return $rc;
}


=head2 G1_189($self, $value, $index)

Transpilation of G1 rule No 189, i.e. IterationStatement ::= FOR LPAREN VAR VariableDeclarationNoIn IN Expression RPAREN Statement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_189 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 3) {
    }
    elsif ($index == 4) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 5) {
    }
    elsif ($index == 6) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 7) {
    }

    return $rc;
}


=head2 G1_190($self, $value, $index)

Transpilation of G1 rule No 190, i.e. ContinueStatement ::= CONTINUE SEMICOLON

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_190 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_191($self, $value, $index)

Transpilation of G1 rule No 191, i.e. ContinueStatement ::= CONTINUE INVISIBLE_SEMICOLON

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_191 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_192($self, $value, $index)

Transpilation of G1 rule No 192, i.e. ContinueStatement ::= CONTINUE IDENTIFIER SEMICOLON

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_192 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_193($self, $value, $index)

Transpilation of G1 rule No 193, i.e. BreakStatement ::= BREAK SEMICOLON

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_193 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_194($self, $value, $index)

Transpilation of G1 rule No 194, i.e. BreakStatement ::= BREAK INVISIBLE_SEMICOLON

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_194 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_195($self, $value, $index)

Transpilation of G1 rule No 195, i.e. BreakStatement ::= BREAK IDENTIFIER SEMICOLON

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_195 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_196($self, $value, $index)

Transpilation of G1 rule No 196, i.e. ReturnStatement ::= RETURN SEMICOLON

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_196 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_197($self, $value, $index)

Transpilation of G1 rule No 197, i.e. ReturnStatement ::= RETURN INVISIBLE_SEMICOLON

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_197 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_198($self, $value, $index)

Transpilation of G1 rule No 198, i.e. ReturnStatement ::= RETURN Expression SEMICOLON

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_198 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_199($self, $value, $index)

Transpilation of G1 rule No 199, i.e. WithStatement ::= WITH LPAREN Expression RPAREN Statement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_199 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }
    elsif ($index == 3) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 4) {
    }

    return $rc;
}


=head2 G1_200($self, $value, $index)

Transpilation of G1 rule No 200, i.e. SwitchStatement ::= SWITCH LPAREN Expression RPAREN CaseBlock

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_200 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }
    elsif ($index == 3) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 4) {
    }

    return $rc;
}


=head2 G1_201($self, $value, $index)

Transpilation of G1 rule No 201, i.e. CaseBlock ::= LCURLY CaseClausesopt RCURLY

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_201 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_202($self, $value, $index)

Transpilation of G1 rule No 202, i.e. CaseBlock ::= LCURLY CaseClausesopt DefaultClause CaseClausesopt RCURLY

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_202 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
    }
    elsif ($index == 3) {
    }
    elsif ($index == 4) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_203($self, $value, $index)

Transpilation of G1 rule No 203, i.e. CaseClausesopt ::= CaseClauses

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_203 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_204($self, $value, $index)

Transpilation of G1 rule No 204, i.e. CaseClausesopt ::= 

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_204 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}


=head2 G1_205($self, $value, $index)

Transpilation of G1 rule No 205, i.e. CaseClauses ::= CaseClause

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_205 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_206($self, $value, $index)

Transpilation of G1 rule No 206, i.e. CaseClauses ::= CaseClauses CaseClause

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_206 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_207($self, $value, $index)

Transpilation of G1 rule No 207, i.e. CaseClause ::= CASE Expression COLON StatementListopt

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_207 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 3) {
    }

    return $rc;
}


=head2 G1_208($self, $value, $index)

Transpilation of G1 rule No 208, i.e. StatementListopt ::= StatementList

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_208 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_209($self, $value, $index)

Transpilation of G1 rule No 209, i.e. StatementListopt ::= 

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_209 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}


=head2 G1_210($self, $value, $index)

Transpilation of G1 rule No 210, i.e. DefaultClause ::= DEFAULT COLON StatementListopt

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_210 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_211($self, $value, $index)

Transpilation of G1 rule No 211, i.e. LabelledStatement ::= IDENTIFIER COLON Statement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_211 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_212($self, $value, $index)

Transpilation of G1 rule No 212, i.e. ThrowStatement ::= THROW Expression SEMICOLON

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_212 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_213($self, $value, $index)

Transpilation of G1 rule No 213, i.e. TryStatement ::= TRY Block Catch

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_213 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_214($self, $value, $index)

Transpilation of G1 rule No 214, i.e. TryStatement ::= TRY Block Finally

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_214 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
    }

    return $rc;
}


=head2 G1_215($self, $value, $index)

Transpilation of G1 rule No 215, i.e. TryStatement ::= TRY Block Catch Finally

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_215 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
    }
    elsif ($index == 3) {
    }

    return $rc;
}


=head2 G1_216($self, $value, $index)

Transpilation of G1 rule No 216, i.e. Catch ::= CATCH LPAREN IDENTIFIER RPAREN Block

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_216 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 3) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 4) {
    }

    return $rc;
}


=head2 G1_217($self, $value, $index)

Transpilation of G1 rule No 217, i.e. Finally ::= FINALLY Block

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_217 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_218($self, $value, $index)

Transpilation of G1 rule No 218, i.e. DebuggerStatement ::= DEBUGGER SEMICOLON

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_218 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_219($self, $value, $index)

Transpilation of G1 rule No 219, i.e. FunctionDeclaration ::= FUNCTION IDENTIFIER LPAREN FormalParameterListopt RPAREN LCURLY FunctionBody RCURLY

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_219 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 3) {
    }
    elsif ($index == 4) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 5) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 6) {
    }
    elsif ($index == 7) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_220($self, $value, $index)

Transpilation of G1 rule No 220, i.e. Identifieropt ::= IDENTIFIER

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_220 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_221($self, $value, $index)

Transpilation of G1 rule No 221, i.e. Identifieropt ::= 

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_221 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}


=head2 G1_222($self, $value, $index)

Transpilation of G1 rule No 222, i.e. FunctionExpression ::= FUNCTION Identifieropt LPAREN FormalParameterListopt RPAREN LCURLY FunctionBody RCURLY

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_222 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 1) {
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 3) {
    }
    elsif ($index == 4) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 5) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 6) {
    }
    elsif ($index == 7) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_223($self, $value, $index)

Transpilation of G1 rule No 223, i.e. FormalParameterListopt ::= FormalParameterList

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_223 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_224($self, $value, $index)

Transpilation of G1 rule No 224, i.e. FormalParameterListopt ::= 

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_224 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}


=head2 G1_225($self, $value, $index)

Transpilation of G1 rule No 225, i.e. FormalParameterList ::= IDENTIFIER

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_225 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_226($self, $value, $index)

Transpilation of G1 rule No 226, i.e. FormalParameterList ::= FormalParameterList COMMA IDENTIFIER

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_226 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
        $rc = $self->lexeme($value);
    }
    elsif ($index == 2) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_227($self, $value, $index)

Transpilation of G1 rule No 227, i.e. SourceElementsopt ::= SourceElements

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_227 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_228($self, $value, $index)

Transpilation of G1 rule No 228, i.e. SourceElementsopt ::= 

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_228 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}


=head2 G1_229($self, $value, $index)

Transpilation of G1 rule No 229, i.e. FunctionBody ::= SourceElementsopt

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_229 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_230($self, $value, $index)

Transpilation of G1 rule No 230, i.e. Program ::= SourceElementsopt

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_230 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_231($self, $value, $index)

Transpilation of G1 rule No 231, i.e. SourceElements ::= SourceElement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_231 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_232($self, $value, $index)

Transpilation of G1 rule No 232, i.e. SourceElements ::= SourceElements SourceElement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_232 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
    }

    return $rc;
}


=head2 G1_233($self, $value, $index)

Transpilation of G1 rule No 233, i.e. SourceElement ::= Statement

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_233 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_234($self, $value, $index)

Transpilation of G1 rule No 234, i.e. SourceElement ::= FunctionDeclaration

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_234 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}


=head2 G1_235($self, $value, $index)

Transpilation of G1 rule No 235, i.e. NullLiteral ::= NULL

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_235 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_236($self, $value, $index)

Transpilation of G1 rule No 236, i.e. BooleanLiteral ::= TRUE

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_236 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_237($self, $value, $index)

Transpilation of G1 rule No 237, i.e. BooleanLiteral ::= FALSE

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_237 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_238($self, $value, $index)

Transpilation of G1 rule No 238, i.e. StringLiteral ::= STRINGLITERAL

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_238 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}


=head2 G1_239($self, $value, $index)

Transpilation of G1 rule No 239, i.e. RegularExpressionLiteral ::= REGULAREXPRESSIONLITERAL

$value is the value of RHS No $index (starting at 0).

=cut

sub G1_239 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

1;
