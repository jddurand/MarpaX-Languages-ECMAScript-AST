#
# This is a generated file using the command:
# /usr/bin/perl script/generateTemplateXslate.pl ECMAScript-262-5
#
use strict;
use warnings FATAL => 'all';
no warnings 'recursion';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Template;

# ABSTRACT: Template for ${grammarAlias} transpilation using an AST

# VERSION

sub new {
    my ($class, %options) = @_;

    my $self = {_nindent => 0};
    bless($self, $class);
    return $self;
}

sub lexeme {
    my ($self, $value) = @_;

    my $lexeme = $value->[2];
    if    ($lexeme eq ';') { $lexeme .= "\n" . $self->indent();  }
    elsif ($lexeme eq '{') { $lexeme .= "\n" . $self->indent(1); }
    elsif ($lexeme eq '}') { $lexeme = "\n" . $self->indent(-1) . ' ' . $lexeme;}

    return ' ' . $lexeme;
}

sub indent {
    my ($self, $inc) = @_;

    if (defined($inc)) {
	$self->{_nindent} += $inc;
    }

    return '  ' x $self->{_nindent};
}

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

#
# ---------------------------------------------------
# [:start] ::= Program
# ---------------------------------------------------
sub G1_0 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Literal ::= NullLiteral
# ---------------------------------------------------
sub G1_1 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Literal ::= BooleanLiteral
# ---------------------------------------------------
sub G1_2 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Literal ::= NumericLiteral
# ---------------------------------------------------
sub G1_3 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Literal ::= StringLiteral
# ---------------------------------------------------
sub G1_4 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Literal ::= RegularExpressionLiteral
# ---------------------------------------------------
sub G1_5 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# NumericLiteral ::= DECIMALLITERAL
# ---------------------------------------------------
sub G1_6 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# NumericLiteral ::= HEXINTEGERLITERAL
# ---------------------------------------------------
sub G1_7 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# NumericLiteral ::= OCTALINTEGERLITERAL
# ---------------------------------------------------
sub G1_8 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# PrimaryExpression ::= THIS
# ---------------------------------------------------
sub G1_9 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# PrimaryExpression ::= IDENTIFIER
# ---------------------------------------------------
sub G1_10 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# PrimaryExpression ::= Literal
# ---------------------------------------------------
sub G1_11 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# PrimaryExpression ::= ArrayLiteral
# ---------------------------------------------------
sub G1_12 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# PrimaryExpression ::= ObjectLiteral
# ---------------------------------------------------
sub G1_13 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# PrimaryExpression ::= LPAREN Expression RPAREN
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ArrayLiteral ::= LBRACKET Elisionopt RBRACKET
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ArrayLiteral ::= LBRACKET ElementList RBRACKET
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ArrayLiteral ::= LBRACKET ElementList COMMA Elisionopt RBRACKET
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ElementList ::= Elisionopt AssignmentExpression
# ---------------------------------------------------
sub G1_18 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# ElementList ::= ElementList COMMA Elisionopt AssignmentExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# Elision ::= COMMA
# ---------------------------------------------------
sub G1_20 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# Elision ::= Elision COMMA
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# Elisionopt ::= Elision
# ---------------------------------------------------
sub G1_22 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Elisionopt ::= 
# ---------------------------------------------------
sub G1_23 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}

#
# ---------------------------------------------------
# ObjectLiteral ::= LCURLY RCURLY
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ObjectLiteral ::= LCURLY PropertyNameAndValueList RCURLY
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ObjectLiteral ::= LCURLY PropertyNameAndValueList COMMA RCURLY
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# PropertyNameAndValueList ::= PropertyAssignment
# ---------------------------------------------------
sub G1_27 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# PropertyNameAndValueList ::= PropertyNameAndValueList COMMA PropertyAssignment
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# PropertyAssignment ::= PropertyName COLON AssignmentExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# PropertyAssignment ::= GET PropertyName LPAREN RPAREN LCURLY FunctionBody RCURLY
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# PropertyAssignment ::= SET PropertyName LPAREN PropertySetParameterList RPAREN LCURLY FunctionBody RCURLY
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# PropertyName ::= IDENTIFIERNAME
# ---------------------------------------------------
sub G1_32 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# PropertyName ::= StringLiteral
# ---------------------------------------------------
sub G1_33 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# PropertyName ::= NumericLiteral
# ---------------------------------------------------
sub G1_34 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# PropertySetParameterList ::= IDENTIFIER
# ---------------------------------------------------
sub G1_35 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# MemberExpression ::= PrimaryExpression
# ---------------------------------------------------
sub G1_36 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# MemberExpression ::= FunctionExpression
# ---------------------------------------------------
sub G1_37 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# MemberExpression ::= MemberExpression LBRACKET Expression RBRACKET
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# MemberExpression ::= MemberExpression DOT IDENTIFIERNAME
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# MemberExpression ::= NEW MemberExpression Arguments
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# NewExpression ::= MemberExpression
# ---------------------------------------------------
sub G1_41 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# NewExpression ::= NEW NewExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# CallExpression ::= MemberExpression Arguments
# ---------------------------------------------------
sub G1_43 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# CallExpression ::= CallExpression Arguments
# ---------------------------------------------------
sub G1_44 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# CallExpression ::= CallExpression LBRACKET Expression RBRACKET
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# CallExpression ::= CallExpression DOT IDENTIFIERNAME
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# Arguments ::= LPAREN RPAREN
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# Arguments ::= LPAREN ArgumentList RPAREN
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ArgumentList ::= AssignmentExpression
# ---------------------------------------------------
sub G1_49 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# ArgumentList ::= ArgumentList COMMA AssignmentExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# LeftHandSideExpression ::= NewExpression
# ---------------------------------------------------
sub G1_51 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# LeftHandSideExpression ::= CallExpression
# ---------------------------------------------------
sub G1_52 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# PostfixExpression ::= LeftHandSideExpression
# ---------------------------------------------------
sub G1_53 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# PostfixExpression ::= LeftHandSideExpression PLUSPLUS_POSTFIX
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# PostfixExpression ::= LeftHandSideExpression MINUSMINUS_POSTFIX
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# UnaryExpression ::= PostfixExpression
# ---------------------------------------------------
sub G1_56 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# UnaryExpression ::= DELETE UnaryExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# UnaryExpression ::= VOID UnaryExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# UnaryExpression ::= TYPEOF UnaryExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# UnaryExpression ::= PLUSPLUS UnaryExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# UnaryExpression ::= MINUSMINUS UnaryExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# UnaryExpression ::= PLUS UnaryExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# UnaryExpression ::= MINUS UnaryExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# UnaryExpression ::= INVERT UnaryExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# UnaryExpression ::= NOT UnaryExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# MultiplicativeExpression ::= UnaryExpression
# ---------------------------------------------------
sub G1_66 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# MultiplicativeExpression ::= MultiplicativeExpression MUL UnaryExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# MultiplicativeExpression ::= MultiplicativeExpression DIV UnaryExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# MultiplicativeExpression ::= MultiplicativeExpression MODULUS UnaryExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# AdditiveExpression ::= MultiplicativeExpression
# ---------------------------------------------------
sub G1_70 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# AdditiveExpression ::= AdditiveExpression PLUS MultiplicativeExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# AdditiveExpression ::= AdditiveExpression MINUS MultiplicativeExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ShiftExpression ::= AdditiveExpression
# ---------------------------------------------------
sub G1_73 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# ShiftExpression ::= ShiftExpression LEFTMOVE AdditiveExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ShiftExpression ::= ShiftExpression RIGHTMOVE AdditiveExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ShiftExpression ::= ShiftExpression RIGHTMOVEFILL AdditiveExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# RelationalExpression ::= ShiftExpression
# ---------------------------------------------------
sub G1_77 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# RelationalExpression ::= RelationalExpression LT ShiftExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# RelationalExpression ::= RelationalExpression GT ShiftExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# RelationalExpression ::= RelationalExpression LE ShiftExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# RelationalExpression ::= RelationalExpression GE ShiftExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# RelationalExpression ::= RelationalExpression INSTANCEOF ShiftExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# RelationalExpression ::= RelationalExpression IN ShiftExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# RelationalExpressionNoIn ::= ShiftExpression
# ---------------------------------------------------
sub G1_84 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# RelationalExpressionNoIn ::= RelationalExpressionNoIn LT ShiftExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# RelationalExpressionNoIn ::= RelationalExpressionNoIn GT ShiftExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# RelationalExpressionNoIn ::= RelationalExpressionNoIn LE ShiftExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# RelationalExpressionNoIn ::= RelationalExpressionNoIn GE ShiftExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# RelationalExpressionNoIn ::= RelationalExpressionNoIn INSTANCEOF ShiftExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# EqualityExpression ::= RelationalExpression
# ---------------------------------------------------
sub G1_90 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# EqualityExpression ::= EqualityExpression EQ RelationalExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# EqualityExpression ::= EqualityExpression NE RelationalExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# EqualityExpression ::= EqualityExpression STRICTEQ RelationalExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# EqualityExpression ::= EqualityExpression STRICTNE RelationalExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# EqualityExpressionNoIn ::= RelationalExpressionNoIn
# ---------------------------------------------------
sub G1_95 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# EqualityExpressionNoIn ::= EqualityExpressionNoIn EQ RelationalExpressionNoIn
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# EqualityExpressionNoIn ::= EqualityExpressionNoIn NE RelationalExpressionNoIn
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# EqualityExpressionNoIn ::= EqualityExpressionNoIn STRICTEQ RelationalExpressionNoIn
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# EqualityExpressionNoIn ::= EqualityExpressionNoIn STRICTNE RelationalExpressionNoIn
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# BitwiseANDExpression ::= EqualityExpression
# ---------------------------------------------------
sub G1_100 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# BitwiseANDExpression ::= BitwiseANDExpression BITAND EqualityExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# BitwiseANDExpressionNoIn ::= EqualityExpressionNoIn
# ---------------------------------------------------
sub G1_102 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# BitwiseANDExpressionNoIn ::= BitwiseANDExpressionNoIn BITAND EqualityExpressionNoIn
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# BitwiseXORExpression ::= BitwiseANDExpression
# ---------------------------------------------------
sub G1_104 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# BitwiseXORExpression ::= BitwiseXORExpression BITXOR BitwiseANDExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# BitwiseXORExpressionNoIn ::= BitwiseANDExpressionNoIn
# ---------------------------------------------------
sub G1_106 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# BitwiseXORExpressionNoIn ::= BitwiseXORExpressionNoIn BITXOR BitwiseANDExpressionNoIn
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# BitwiseORExpression ::= BitwiseXORExpression
# ---------------------------------------------------
sub G1_108 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# BitwiseORExpression ::= BitwiseORExpression BITOR BitwiseXORExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# BitwiseORExpressionNoIn ::= BitwiseXORExpressionNoIn
# ---------------------------------------------------
sub G1_110 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# BitwiseORExpressionNoIn ::= BitwiseORExpressionNoIn BITOR BitwiseXORExpressionNoIn
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# LogicalANDExpression ::= BitwiseORExpression
# ---------------------------------------------------
sub G1_112 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# LogicalANDExpression ::= LogicalANDExpression AND BitwiseORExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# LogicalANDExpressionNoIn ::= BitwiseORExpressionNoIn
# ---------------------------------------------------
sub G1_114 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# LogicalANDExpressionNoIn ::= LogicalANDExpressionNoIn AND BitwiseORExpressionNoIn
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# LogicalORExpression ::= LogicalANDExpression
# ---------------------------------------------------
sub G1_116 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# LogicalORExpression ::= LogicalORExpression OR LogicalANDExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# LogicalORExpressionNoIn ::= LogicalANDExpressionNoIn
# ---------------------------------------------------
sub G1_118 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# LogicalORExpressionNoIn ::= LogicalORExpressionNoIn OR LogicalANDExpressionNoIn
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ConditionalExpression ::= LogicalORExpression
# ---------------------------------------------------
sub G1_120 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# ConditionalExpression ::= LogicalORExpression QUESTION_MARK AssignmentExpression COLON AssignmentExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ConditionalExpressionNoIn ::= LogicalORExpressionNoIn
# ---------------------------------------------------
sub G1_122 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# ConditionalExpressionNoIn ::= LogicalORExpressionNoIn QUESTION_MARK AssignmentExpression COLON AssignmentExpressionNoIn
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# AssignmentExpression ::= ConditionalExpression
# ---------------------------------------------------
sub G1_124 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# AssignmentExpression ::= LeftHandSideExpression ASSIGN AssignmentExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# AssignmentExpression ::= LeftHandSideExpression AssignmentOperator AssignmentExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# AssignmentExpressionNoIn ::= ConditionalExpressionNoIn
# ---------------------------------------------------
sub G1_127 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# AssignmentExpressionNoIn ::= LeftHandSideExpression ASSIGN AssignmentExpressionNoIn
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# AssignmentExpressionNoIn ::= LeftHandSideExpression AssignmentOperator AssignmentExpressionNoIn
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# AssignmentOperator ::= MULASSIGN
# ---------------------------------------------------
sub G1_130 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# AssignmentOperator ::= DIVASSIGN
# ---------------------------------------------------
sub G1_131 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# AssignmentOperator ::= MODULUSASSIGN
# ---------------------------------------------------
sub G1_132 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# AssignmentOperator ::= PLUSASSIGN
# ---------------------------------------------------
sub G1_133 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# AssignmentOperator ::= MINUSASSIGN
# ---------------------------------------------------
sub G1_134 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# AssignmentOperator ::= LEFTMOVEASSIGN
# ---------------------------------------------------
sub G1_135 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# AssignmentOperator ::= RIGHTMOVEASSIGN
# ---------------------------------------------------
sub G1_136 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# AssignmentOperator ::= RIGHTMOVEFILLASSIGN
# ---------------------------------------------------
sub G1_137 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# AssignmentOperator ::= BITANDASSIGN
# ---------------------------------------------------
sub G1_138 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# AssignmentOperator ::= BITXORASSIGN
# ---------------------------------------------------
sub G1_139 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# AssignmentOperator ::= BITORASSIGN
# ---------------------------------------------------
sub G1_140 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# Expression ::= AssignmentExpression
# ---------------------------------------------------
sub G1_141 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Expression ::= Expression COMMA AssignmentExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ExpressionNoIn ::= AssignmentExpressionNoIn
# ---------------------------------------------------
sub G1_143 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# ExpressionNoIn ::= ExpressionNoIn COMMA AssignmentExpressionNoIn
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# Statement ::= Block
# ---------------------------------------------------
sub G1_145 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Statement ::= VariableStatement
# ---------------------------------------------------
sub G1_146 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Statement ::= EmptyStatement
# ---------------------------------------------------
sub G1_147 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Statement ::= ExpressionStatement
# ---------------------------------------------------
sub G1_148 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Statement ::= IfStatement
# ---------------------------------------------------
sub G1_149 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Statement ::= IterationStatement
# ---------------------------------------------------
sub G1_150 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Statement ::= ContinueStatement
# ---------------------------------------------------
sub G1_151 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Statement ::= BreakStatement
# ---------------------------------------------------
sub G1_152 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Statement ::= ReturnStatement
# ---------------------------------------------------
sub G1_153 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Statement ::= WithStatement
# ---------------------------------------------------
sub G1_154 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Statement ::= LabelledStatement
# ---------------------------------------------------
sub G1_155 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Statement ::= SwitchStatement
# ---------------------------------------------------
sub G1_156 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Statement ::= ThrowStatement
# ---------------------------------------------------
sub G1_157 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Statement ::= TryStatement
# ---------------------------------------------------
sub G1_158 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Statement ::= DebuggerStatement
# ---------------------------------------------------
sub G1_159 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Block ::= LCURLY StatementListopt RCURLY
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# StatementList ::= Statement
# ---------------------------------------------------
sub G1_161 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# StatementList ::= StatementList Statement
# ---------------------------------------------------
sub G1_162 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# VariableStatement ::= VAR VariableDeclarationList SEMICOLON
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# VariableDeclarationList ::= VariableDeclaration
# ---------------------------------------------------
sub G1_164 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# VariableDeclarationList ::= VariableDeclarationList COMMA VariableDeclaration
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# VariableDeclarationListNoIn ::= VariableDeclarationNoIn
# ---------------------------------------------------
sub G1_166 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# VariableDeclarationListNoIn ::= VariableDeclarationListNoIn COMMA VariableDeclarationNoIn
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# VariableDeclaration ::= IDENTIFIER Initialiseropt
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# VariableDeclarationNoIn ::= IDENTIFIER InitialiserNoInopt
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# Initialiseropt ::= Initialiser
# ---------------------------------------------------
sub G1_170 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Initialiseropt ::= 
# ---------------------------------------------------
sub G1_171 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}

#
# ---------------------------------------------------
# Initialiser ::= ASSIGN AssignmentExpression
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# InitialiserNoInopt ::= InitialiserNoIn
# ---------------------------------------------------
sub G1_173 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# InitialiserNoInopt ::= 
# ---------------------------------------------------
sub G1_174 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}

#
# ---------------------------------------------------
# InitialiserNoIn ::= ASSIGN AssignmentExpressionNoIn
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# EmptyStatement ::= VISIBLE_SEMICOLON
# ---------------------------------------------------
sub G1_176 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# ExpressionStatement ::= Expression SEMICOLON
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# IfStatement ::= IF LPAREN Expression RPAREN Statement ELSE Statement
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# IfStatement ::= IF LPAREN Expression RPAREN Statement
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ExpressionNoInopt ::= ExpressionNoIn
# ---------------------------------------------------
sub G1_180 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# ExpressionNoInopt ::= 
# ---------------------------------------------------
sub G1_181 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}

#
# ---------------------------------------------------
# Expressionopt ::= Expression
# ---------------------------------------------------
sub G1_182 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Expressionopt ::= 
# ---------------------------------------------------
sub G1_183 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}

#
# ---------------------------------------------------
# IterationStatement ::= DO Statement WHILE LPAREN Expression RPAREN SEMICOLON
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# IterationStatement ::= WHILE LPAREN Expression RPAREN Statement
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# IterationStatement ::= FOR LPAREN ExpressionNoInopt VISIBLE_SEMICOLON Expressionopt VISIBLE_SEMICOLON Expressionopt RPAREN Statement
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# IterationStatement ::= FOR LPAREN VAR VariableDeclarationListNoIn VISIBLE_SEMICOLON Expressionopt VISIBLE_SEMICOLON Expressionopt RPAREN Statement
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# IterationStatement ::= FOR LPAREN LeftHandSideExpression IN Expression RPAREN Statement
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# IterationStatement ::= FOR LPAREN VAR VariableDeclarationNoIn IN Expression RPAREN Statement
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ContinueStatement ::= CONTINUE SEMICOLON
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ContinueStatement ::= CONTINUE INVISIBLE_SEMICOLON
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ContinueStatement ::= CONTINUE IDENTIFIER SEMICOLON
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# BreakStatement ::= BREAK SEMICOLON
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# BreakStatement ::= BREAK INVISIBLE_SEMICOLON
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# BreakStatement ::= BREAK IDENTIFIER SEMICOLON
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ReturnStatement ::= RETURN SEMICOLON
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ReturnStatement ::= RETURN INVISIBLE_SEMICOLON
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ReturnStatement ::= RETURN Expression SEMICOLON
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# WithStatement ::= WITH LPAREN Expression RPAREN Statement
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# SwitchStatement ::= SWITCH LPAREN Expression RPAREN CaseBlock
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# CaseBlock ::= LCURLY CaseClausesopt RCURLY
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# CaseBlock ::= LCURLY CaseClausesopt DefaultClause CaseClausesopt RCURLY
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# CaseClausesopt ::= CaseClauses
# ---------------------------------------------------
sub G1_203 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# CaseClausesopt ::= 
# ---------------------------------------------------
sub G1_204 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}

#
# ---------------------------------------------------
# CaseClauses ::= CaseClause
# ---------------------------------------------------
sub G1_205 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# CaseClauses ::= CaseClauses CaseClause
# ---------------------------------------------------
sub G1_206 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# CaseClause ::= CASE Expression COLON StatementListopt
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# StatementListopt ::= StatementList
# ---------------------------------------------------
sub G1_208 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# StatementListopt ::= 
# ---------------------------------------------------
sub G1_209 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}

#
# ---------------------------------------------------
# DefaultClause ::= DEFAULT COLON StatementListopt
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# LabelledStatement ::= IDENTIFIER COLON Statement
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# ThrowStatement ::= THROW Expression SEMICOLON
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# TryStatement ::= TRY Block Catch
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# TryStatement ::= TRY Block Finally
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# TryStatement ::= TRY Block Catch Finally
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# Catch ::= CATCH LPAREN IDENTIFIER RPAREN Block
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# Finally ::= FINALLY Block
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# DebuggerStatement ::= DEBUGGER SEMICOLON
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# FunctionDeclaration ::= FUNCTION IDENTIFIER LPAREN FormalParameterListopt RPAREN LCURLY FunctionBody RCURLY
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# Identifieropt ::= IDENTIFIER
# ---------------------------------------------------
sub G1_220 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# Identifieropt ::= 
# ---------------------------------------------------
sub G1_221 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}

#
# ---------------------------------------------------
# FunctionExpression ::= FUNCTION Identifieropt LPAREN FormalParameterListopt RPAREN LCURLY FunctionBody RCURLY
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# FormalParameterListopt ::= FormalParameterList
# ---------------------------------------------------
sub G1_223 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# FormalParameterListopt ::= 
# ---------------------------------------------------
sub G1_224 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}

#
# ---------------------------------------------------
# FormalParameterList ::= IDENTIFIER
# ---------------------------------------------------
sub G1_225 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# FormalParameterList ::= FormalParameterList COMMA IDENTIFIER
# ---------------------------------------------------
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

#
# ---------------------------------------------------
# SourceElementsopt ::= SourceElements
# ---------------------------------------------------
sub G1_227 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# SourceElementsopt ::= 
# ---------------------------------------------------
sub G1_228 {
    my ($self, $value, $index) = @_;

    my $rc = '';


    return $rc;
}

#
# ---------------------------------------------------
# FunctionBody ::= SourceElementsopt
# ---------------------------------------------------
sub G1_229 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# Program ::= SourceElementsopt
# ---------------------------------------------------
sub G1_230 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# SourceElements ::= SourceElement
# ---------------------------------------------------
sub G1_231 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# SourceElements ::= SourceElements SourceElement
# ---------------------------------------------------
sub G1_232 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }
    elsif ($index == 1) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# SourceElement ::= Statement
# ---------------------------------------------------
sub G1_233 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# SourceElement ::= FunctionDeclaration
# ---------------------------------------------------
sub G1_234 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
    }

    return $rc;
}

#
# ---------------------------------------------------
# NullLiteral ::= NULL
# ---------------------------------------------------
sub G1_235 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# BooleanLiteral ::= TRUE
# ---------------------------------------------------
sub G1_236 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# BooleanLiteral ::= FALSE
# ---------------------------------------------------
sub G1_237 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# StringLiteral ::= STRINGLITERAL
# ---------------------------------------------------
sub G1_238 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

#
# ---------------------------------------------------
# RegularExpressionLiteral ::= REGULAREXPRESSIONLITERAL
# ---------------------------------------------------
sub G1_239 {
    my ($self, $value, $index) = @_;

    my $rc = '';

    if ($index == 0) {
        $rc = $self->lexeme($value);
    }

    return $rc;
}

1;
