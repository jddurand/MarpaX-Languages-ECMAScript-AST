#!env perl
use strict;
use warnings FATAL => 'all';
use MarpaX::Languages::ECMAScript::AST;
use File::Path qw/make_path remove_tree/;
use File::Spec;
use File::Basename qw/dirname/;
use Cwd qw/abs_path cwd/;

# -------------------------------
# Generation of grammar templates
# -------------------------------

my $grammarName = shift || '';
if (! $grammarName) {
  die "Usage: $^X $0 grammarName";
}

#
# We generate Xslate templates based on the G1 grammar. Note that we MUST be
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
my $destDir = File::Spec->catdir($parentDir, 'lib', 'MarpaX', 'Languages', 'ECMAScript', 'AST', 'Grammar', $ecmaAst->grammarAlias, 'Template', 'Xslate');
remove_tree($destDir, {verbose => 1});
make_path($destDir, {verbose => 1});
my $g1p = $ecmaAst->describe->{G1};
#
# Get all LHS
#
my %lhs2RuleId = ();
map {$lhs2RuleId{$g1p->{$_}->[0]} = $_} keys %{$g1p};
my $header = do {local $/; <DATA>};
foreach (sort {$a <=> $b} keys %{$g1p}) {
  my $ruleId = $_;
  my $file = File::Spec->catfile($destDir, "$ruleId.tx");
  print "Generating $file\n";
  if (! open(FILE, '>', $file)) {
    die "Cannot open $file, $!";
  }
  print FILE $header;
  my $rulesp = $g1p->{$ruleId};
  my ($lhs, @rhs) = @{$rulesp};
  print FILE <<DESC;
:#
:# Rule Id $ruleId: $lhs ::= @rhs
:# where
DESC
  my $i = 0;
  my @tx = ();
  foreach (@rhs) {
    my $rhs = $_;
    ++$i;
    if (exists($lhs2RuleId{$rhs})) {
      printf FILE ":# RHS No %2d is G1 rule %-4d: %s\n", $i, $lhs2RuleId{$rhs}, $rhs;
      push(@tx, sprintf('$tx.render("%d.tx", $ast[%d])', $lhs2RuleId{$rhs}, $i - 1));
    } else {
      printf FILE ":# RHS No %2d is a lexeme    : %s\n", $i, $rhs;
      push(@tx, sprintf('$ast[%d][2]', $i - 1));
    }
  }
  my $tx = join(' ~ ', @tx);
  print FILE <<BLOCK;
:block G$ruleId -> {
: $tx
:}
BLOCK
  if (! close(FILE)) {
    warn "Cannot close $file, $!";
  }
}
__DATA__
:# --------------------------------------------------
:# This is generated template of Xslate template
:#
:# Default behaviour is:
:# - call another block when an RHS is a G1 rule
:# - output the lexeme as-is if not
:#
:# The caller should "cascade" the template if needed
:# --------------------------------------------------
:# Template input:
:# $tx   : Xslate template object
:# $ast  : Current ast (blessed object)
:#
:# Injected functions:
:# blessed($ast) : returns the bless name
:# data($ast)    : returns the data (array reference)
:# --------------------------------------------------
