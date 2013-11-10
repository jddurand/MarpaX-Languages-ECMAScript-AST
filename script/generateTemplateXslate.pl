#!env perl
use strict;
use warnings FATAL => 'all';
use MarpaX::Languages::ECMAScript::AST;
use File::Spec;
use File::Basename qw/dirname/;
use Cwd qw/abs_path cwd/;
use Carp qw/croak/;
use POSIX qw/EXIT_SUCCESS/;

# -------------------------------
# Generation of grammar templates
# -------------------------------
my @COPYARGV = @ARGV;
my $grammarName = shift || '';
if (! $grammarName) {
  die "Usage: $^X $0 grammarName";
}

#
# We generate templates as a perl class based on the G1 grammar. Note that we MUST be
# in the directory just upper than script/ . We use Cwd and $0 and verify that
# Cwd is the dirname of the dirname of $0.
#
my $cwd = File::Spec->canonpath(abs_path(cwd()));
my $parentDir = File::Spec->canonpath(abs_path(File::Spec->catdir(dirname($0), File::Spec->updir)));
#
# Note: we assume filenames are not bizarre, i.e. no need of Unicode::CaseFold
#
my $isSameDir = File::Spec->case_tolerant() ? (lc($cwd) eq lc($parentDir)) : ($cwd eq $parentDir);
if (! $isSameDir) {
    die "Please execute this script in directory $parentDir";
}

my $ecmaAst = MarpaX::Languages::ECMAScript::AST->new(grammarName => $grammarName);
my $descHashp = $ecmaAst->describe();
my $g1p = $ecmaAst->describe->{G1};
#
# Get all LHS
#
my %lhs = ();
map {$lhs{$g1p->{$_}->[0]}++} keys %{$g1p};
#
# Generate Template.pm
#
my $grammarAlias = $ecmaAst->grammarAlias;
my $file = File::Spec->catfile($parentDir, 'lib', 'MarpaX', 'Languages', 'ECMAScript', 'AST', 'Grammar', $grammarAlias, 'Template.pm');
if (! open(FILE, '>', $file)) {
    die "Cannot open $file, $!";
}
#
# We search for the LHS '[:start]'. The real starting point
# will be its LHS
#
my $startRuleId = undef;
foreach (keys %{$g1p}) {
    my $ruleId = $_;
    my $rulesp = $g1p->{$ruleId};
    my ($lhs, @rhs) = @{$rulesp};
    if ($lhs eq '[:start]') {
	$startRuleId = $ruleId;
    }
}
if (! defined($startRuleId)) {
    croak 'Cannot find :start';
}

print "Generating $file\n";
print FILE <<HEADER;
#
# This is a generated file using the command:
# $^X $0 @COPYARGV
#
use strict;
use warnings FATAL => 'all';
no warnings 'recursion';

package MarpaX::Languages::ECMAScript::AST::Grammar::${grammarAlias}::Template;
HEADER
#
# The fixed stuff: new(), lexeme(), indent(), transpile()
#
print FILE do {local $/; <DATA>};
foreach (sort {$a <=> $b} keys %{$g1p}) {
    my $ruleId = $_;
    my $rulesp = $g1p->{$ruleId};
    my ($lhs, @rhs) = @{$rulesp};
    print FILE "
#
# ---------------------------------------------------
# $lhs ::= @rhs
# ---------------------------------------------------
sub G1_$ruleId {
    my (\$self, \$value, \$index) = \@_;

    my \$rc = '';

";
    foreach (0..$#rhs) {
        printf FILE "    %sif (\$index == $_) {\n", $_ > 0 ? 'els' : '';
	if (exists($lhs{$rhs[$_]})) {
            #print FILE "    my \$method$_ = defined(\$value->[$_]) ? \"G1_\$value->[$_]->{ruleId}\" : undef;\n";
            #print FILE "    my \$value$_ = (defined(\$method$_) ? (\$indent . \$self->\$method$_(\$value->[$_]->{values})) : '');\n";
	    #push(@value, "\$value$_");
	} else {
            print FILE "        \$rc = \$self->lexeme(\$value);\n";
	}
        print FILE "    }\n";
    }
    print FILE "\n";
    print FILE "    return \$rc;\n";
    print FILE "}\n";
}
print FILE "\n1;\n";

if (! close(FILE)) {
    warn "Cannot close $file, $!";
}
exit(EXIT_SUCCESS);

__DATA__

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
