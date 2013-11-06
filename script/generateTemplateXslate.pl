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
