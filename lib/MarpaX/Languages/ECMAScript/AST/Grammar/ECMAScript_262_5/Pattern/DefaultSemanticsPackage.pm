use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::Pattern::DefaultSemanticsPackage;
use MarpaX::Languages::ECMAScript::AST::Exceptions qw/:all/;
use List::Compare::Functional 0.21 qw/get_union_ref/;

# ABSTRACT: ECMAScript 262, Edition 5, pattern grammar default semantics package

# VERSION

=head1 DESCRIPTION

This modules provide default host implementation for the actions associated to ECMAScript_262_5 pattern grammar.

=head2 new($class)

Instantiate a new object. The value will be a perl subroutine closure that returns a perl representation of a "MatchResult"; i.e. either a "State", either the perl's undef. A "State" is an ordered pair of [$endIndex, $captures] where $endIndex is an integer, and $captures is array reference whose length is the number of capturing parenthesis, holdign the result of the capture as perl strings. Note, however, that these perl strings are constructed using $str->charAt($index) method.

It will be the responsability of the caller to coerce back into host's representations of array and strings.

The perl subroutine closure will have two parameters: $str and $index.

=over

=item $str

perl's string. Typically this will JavaScript's String.prototype.valueOf() on JavaScript's string.

=item $index

perl's scalar. Typically Number.prototype.valueOf() on JavaScript's number.

=back

The caller will have to localize the following perl's scalar representations of multiline, ignoreCase, like that:

=over

=item MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::multiline

perl scalar representing multiline Regexp object's boolean value. Typically Regexp.property.multiline.prototype.valueOf().

=item MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::ignoreCase

perl scalar representing ignoreCase Regexp object's boolean value. Typically Regexp.property.ignoreCase.prototype.valueOf().

=back

Please note the a SyntaxError error can be thrown.

=cut

sub new {
    return bless {}, shift;
}

#
# IMPORTANT NOTE: These actions DELIBIRATELY do not use any perl regular expression. This is the prove that one can
# write a fresh regular expression engine from scratch. The only important notion is case-folding. There we rely
# on perl.
#

our @LINETERMINATOR = @{MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses::LineTerminator()};
our @WHITESPACE = @{MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses::WhiteSpace()};

sub _Pattern_Disjunction {
    my ($self, $disjunction) = @_;

    my $m = &$disjunction();

    return sub {
	#
	# Note: $str is a true perl string, $index is a true perl scalar
	#
	my ($str, $index) = @_;

	my $input = $str;
	my $inputLength = length($input);
	#
	# We localize input and inputLength
	#
	$MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::input = $input;
	$MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::inputLength = $inputLength;
	#
	# And pre-calculation of number of capturing disjunctions
	#
	$MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::nCapturingParens = scalar(@{$MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::lparen});
	#
	# pre-calculation of 

	my $c = sub {
	    my ($self, $state) = @_;
	    return $state;
	};
	my $cap = [ (undef) x $MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::nCapturingParens ];
	my $x = [ $index, $cap ];

	return &$m($x, $c);
    };
}

sub _Disjunction_Alternative {
    my ($self, $alternative) = @_;
    return &$alternative;
}

sub _Disjunction_Alternative_OR_Disjunction {
    my ($self, $alternative, $disjunction) = @_;

    my $m1 = &$alternative;
    my $m2 = &$disjunction;

    return sub {
	my ($x, $c) = @_;
	my $r = &$m1($x, $c);
        if (! $r) {
          return $r;
        }
        return &$m2($x, $c);
    };
}

sub _Alternative {
    my ($self) = @_;

    return sub {
	my ($x, $c) = @_;
	return &$c($x);
    };
}

sub _Alternative_Alternative_Term {
    my ($self, $alternative, $term) = @_;

    my $m1 = &$alternative;
    my $m2 = &$term;

  return sub {
      my ($x, $c) = @_;
      my $d = sub {
	  my ($y) = @_;
	  return &$m2($y, $c);
      };
      return &$m1($x, $d);
  };
}

sub _Term_Assertion {
    my ($self, $assertion) = @_;

    return sub {
	my ($x, $c) = @_;

	my $t = &$assertion;
	my $r = &$t($x);
	if (! $r) {
	    return 0;
	}
	return &$c($x);
    };
}

sub _Term_Atom {
    my ($self, $atom) = @_;

    return &$atom;
}

sub _repeatMatcher {
  my ($self, $m, $min, $max, $greedy, $x, $c, $parenIndex, $parenCount) = @_;

  if ($max == 0) {
    return &$c($x);
  }
  my $d = sub {
    my ($y) = @_;
    if ($min == 0 && $y->[0] == $x->[0]) {
      return 0;
    }
    my $min2 = ($min == 0) ? 0 : ($min - 1);
    my $max2 = (! defined($max)) ? undef : ($max - 1);
    return _repeatMatcher($m, $min2, $max2, $greedy, $y, $c, $parenIndex, $parenCount);
  };
  my @cap = @{$x->[1]};
  foreach my $k (($parenIndex+1)..($parenIndex+$parenCount)) {
    $cap[$k] = undef;
  }
  my $e = $x->[0];
  my $xr = [$e, \@cap ];
  if ($min != 0) {
    return &$m($xr, $d);
  }
  if (! $greedy) {
    my $z = &$c($x);
    if ($z) {
      return $z;
    }
    return &$m($xr, $d);
  }
  my $z = &$m($xr, $d);
  if ($z) {
    return $z;
  }
  return &$c($x);
}

sub _parenIndexAndCount {
    my ($start, $end) = Marpa::R2::Context::location();
    my $parenIndex = 0;
    my $parenCount = 0;
    foreach (@{$MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::lparen}) {
	if ($_ <= $end) {
	    ++$parenIndex;
	    if ($_ >= $start) {
		++$parenCount;
	    }
	}
    }
    return {parenIndex => $parenIndex, parenCount => $parenCount};
}

#
# Note: we will use undef for $max when its value is infinite
#
sub _Term_Atom_Quantifier {
    my ($self, $atom, $quantifier) = @_;

    my $m = &$atom;
    my ($min, $max, $greedy) = &$quantifier;
    if (defined($max) && $max < $min) {
      SyntaxError("$max < $min");
    }
    my $hashp = _parenIndexAndCount();

    return sub {
      my ($x, $c) = @_;

      return _repeatMatcher($m, $min, $max, $greedy, $x, $c, $hashp->{parenIndex}, $hashp->{parenCount});
    };
}

sub _Assertion_Caret {
    my ($self, $caret) = @_;

    return sub {
	my ($x) = @_;

	my $e = $x->[0];
	if ($e == 0) {
	    return 1;
	}
	if (! $MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::multiline) {
	    return 0;
	}
	my $c = substr($MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::input, $e, 1);
	if (grep {$c == $_} @LINETERMINATOR) {
	    return 1;
	}
	#
	# Could have been writen like that:
	#
	# if (substr($MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::input, $e, 1) =~ /[\p{MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses::IsLineTerminator}]/) {
	#    return 1;
	# }
	return 0;
    };
}

sub _Assertion_Dollar {
    my ($self, $caret) = @_;

    return sub {
	my ($x) = @_;

	my $e = $x->[0];
	if ($e == $MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::inputLength) {
	    return 1;
	}
	if (! $MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::multiline) {
	    return 0;
	}
	my $c = substr($MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::input, $e, 1);
	if (grep {$c == $_} @LINETERMINATOR) {
	    return 1;
	}
	#
	# Could have been writen like that:
	#
	# if (substr($MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::input, $e, 1) =~ /[\p{MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses::IsLineTerminator}]/) {
	#     return 1;
	# }
	return 0;
    };
}

sub _isWordChar {
    my ($e) = @_;

    if ($e == -1 || $e == $MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::inputLength) {
	return 0;
    }
    #
    # This rally refers to ASCII characters, so it is ok to test the ord directly
    #
    my $c = substr($MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::input, $e, 1);
    #
    # I put the most probables (corresponding also to the biggest ranges) first
    if (
	($c >= 'a' && $c <= 'z')
	||
	($c >= 'A' && $c <= 'Z')
	||
	($c >= '0' && $c <= '9')
	||
	($c == '_')
	) {
	return 1;
    }
    #
    # Could have been writen like that:
    #
    # my $c = substr($MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::input, $e, 1);
    # if ($c =~ /[a-zA-Z0-9_/) {
    #     return 1;
    # }
    return 0;
}

sub _Assertion_b {
    my ($self, $caret) = @_;

    return sub {
	my ($x) = @_;

	my $e = $x->[0];
	my $a = _isWordChar($e-1);
	my $b = _isWordChar($e);
	if ($a && ! $b) {
	    return 1;
	}
	if (! $a && $b) {
	    return 1;
	}
	return 0;
    };
}

sub _Assertion_B {
    my ($self, $caret) = @_;

    return sub {
	my ($x) = @_;

	my $e = $x->[0];
	my $a = _isWordChar($e-1);
	my $b = _isWordChar($e);
	if ($a && ! $b) {
	    return 0;
	}
	if (! $a && $b) {
	    return 0;
	}
	return 1;
    };
}

sub _Assertion_DisjunctionPositiveLookAhead {
    my ($self, undef, $disjunction, undef) = @_;

    my $m = &$disjunction;

    return sub {
	my ($x, $c) = @_;

	my $d = sub {
	    my ($y) = @_;
	    return $y;
	};

	my $r = &$m($x, $d);
	if (! $r) {
	    return 0;
	}
	my $y = $r;
	my $cap = $y->[1];
	my $xe = $x->[0];
	my $z = [$xe, $cap];
	return &$c($z);
    };
}

sub _Assertion_DisjunctionNegativeLookAhead {
    my ($self, undef, $disjunction, undef) = @_;

    my $m = &$disjunction;

    return sub {
	my ($x, $c) = @_;

	my $d = sub {
	    my ($y) = @_;
	    return $y;
	};

	my $r = &$m($x, $d);
	if ($r) {
	    return 0;
	}
	return &$c($x);
    };
}

sub _Quantifier_QuantifierPrefix {
    my ($self, $quantifierPrefix) = @_;

    my ($min, $max) = &$quantifierPrefix;
    return ($min, $max, 1);
}

sub _Quantifier_QuantifierPrefix_QuestionMark {
    my ($self, $quantifierPrefix, $questionMark) = @_;

    my ($min, $max) = &$quantifierPrefix;
    return ($min, $max, 0);
}

sub _QuantifierPrefix_Star {
    my ($self, $start) = @_;

    return (0, undef);
}

sub _QuantifierPrefix_Plus {
    my ($self, $plus) = @_;

    return (1, undef);
}

sub _QuantifierPrefix_QuestionMark {
    my ($self, $questionMark) = @_;

    return (0, 1);
}

sub _QuantifierPrefix_DecimalDigits {
    my ($self, undef, $decimalDigits, undef) = @_;

    my $i = int($decimalDigits);
    return ($i, $i);
}

sub _QuantifierPrefix_DecimalDigits_Comma {
    my ($self, undef, $decimalDigits, undef) = @_;

    my $i = int($decimalDigits);
    return ($i, undef);
}

sub _QuantifierPrefix_DecimalDigits_DecimalDigits {
    my ($self, undef, $decimalDigits1, undef, $decimalDigits2, undef) = @_;

    my $i = int($decimalDigits1);
    my $j = int($decimalDigits2);
    return ($i, $j);
}

sub _canonicalize {
    my ($ch) = @_;

    if (! $MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::ignoreCase) {
	return $ch;
    }
    #
    # Note: we use the Unicode Case-Folding feature of perl, i.e. lowercase
    # instead of uppercase - no change in the resulting logic
    #
    my $u = uc($ch);
    if (length($u) != 1) {
	#
	# This is where ECMAScript logic is broken, I don't know why it has
	# been designed like that.
	#
	return $ch;
    }
    my $cu = $u;
    if (ord($ch) >= 128 && ord($cu) < 128) {
	return $ch;
    }
    return $cu;
}

#
# Note: we extend a little the notion of range to:
# * range including characters from ... to ...
# and
# * range NOT including characters from ... to ...
#
# i.e. a character set is [ negation flag, [range] ]
#
# This is different from the invert flag. For example:
# [^\d] means: $A=[0,[0..9]], $invert=1
# [^\D] means: $A=[1,[0..9]], $invert=1, which is equivalent to [\d], i.e.: $A=[0,[0..9], $invert=0

sub _characterSetMatcher {
    my ($A, $invert) = @_;

    my ($Anegation, $Arange) = @{$A};

    if ($Anegation) {
	$invert = ! $invert;
    }

    return sub {
	my ($x, $c) = @_;

	my $e = $x->[0];
	if ($e == $MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::inputLength) {
	    return 0;
	}
	my $ch = substr($MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::inputLength, $e, 1);
	my $cc = _canonicalize($ch);
	if (! $invert) {
	    if (! grep {$cc eq $_} @{$Arange}) {
		return 0;
	    }
	} else {
	    if (grep {$cc eq $_} @{$Arange}) {
		return 0;
	    }
	}
	my $cap = $x->[1];
	my $y = [$e+1, $cap];
	return &$c($y);
    };
}

sub _Atom_PatternCharacter {
    my ($self, $patternCharacter) = @_;

    my $ch = $patternCharacter;
    my $A = [0 , [ $ch ]];
    return _characterSetMatcher($A, 0);
}

sub _Atom_Dot {
    my ($self, $dot) = @_;

    my $A = [1 , \@LINETERMINATOR];
    return _characterSetMatcher($A, 0);


}

sub _Atom_Backslash_AtomEscape {
    my ($self, $backslash, $atomEscape) = @_;

    return &$atomEscape;
}

sub _Atom_Backslash_CharacterClass {
    my ($self, $characterClass) = @_;

    my ($A, $invert) = &$characterClass;
    return _characterSetMatcher($A, $invert);
}

sub _Atom_Lparen_Disjunction_Rparen {
    my ($self, $lparen, $disjunction, $rparen) = @_;

    my $m = &$disjunction;
    my $parenIndex = _parenIndexAndCount()->{parenIndex};
    return sub {
	my ($x, $c) = @_;

	my $d = sub {
	    my ($y) = @_;

	    my @cap = @{$y->[1]};
	    my $xe = $x->[0];
	    my $ye = $y->[0];
	    my $s = substr($MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::input, $xe, $ye-$xe-1);
	    $cap[$parenIndex+1] = $s;
	    my $z = [$ye, \@cap ];
	    return &$c($z);
	};

	return &$m($x, $d);
    };
}

sub _Atom_nonCapturingDisjunction {
    my ($self, undef, $disjunction, undef) = @_;

    return &$disjunction;
}

sub _AtomEscape_DecimalEscape {
    my ($self, $decimalEscape) = @_;

    my $E = &$decimalEscape;

    my $ch = eval { chr($E) };
    if (! $@) {
	my $A = [0 , [ $ch ]];
	return _characterSetMatcher($A, 0);
    }
    my $n = $E;
    if ($n == 0 || $n > $MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::nCapturingParens) {
	SyntaxError("backtrack number $n must be > 0 and <= $MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::nCapturingParens");
    }
    return sub {
	my ($x, $c) = @_;

	my $cap = $x->[1];
	my $s = $cap->[$n];
	if (! defined($s)) {
	    return &$c($x);
	}
	my $e = $x->[0];
	my $len = length($s);
	my $f = $e+$len;
	if ($f > $MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::inputLength) {
	    return 0;
	}
	foreach (0..($len-1)) {
	    if (_canonicalize(substr($s, $_, 1)) ne _canonicalize(substr($MarpaX::Languages::ECMAScript::AST::Grammar::Pattern::input, $e+$_, 1))) {
		return 0;
	    }
	}
	my $y = [$f, $cap];
	return &$c($y);
    };
}

sub _AtomEscape_CharacterEscape {
    my ($self, $characterEscape) = @_;

    my $ch = &$characterEscape;
    my $A = [0 , [ $ch ]];
    return _characterSetMatcher($A, 0);
}

sub _AtomEscape_CharacterClassEscape {
    my ($self, $characterClassEscape) = @_;

    my $A = &$characterClassEscape;
    return _characterSetMatcher($A, 0);
}

sub _CharacterEscape_ControlEscape {
    my ($self, $controlEscape) = @_;

    if ($controlEscape eq 't') {
	return MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses::TAB()->[0];
    }
    elsif ($controlEscape eq 'n') {
	return MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses::LF()->[0];
    }
    elsif ($controlEscape eq 'v') {
	return MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses::VT()->[0];
    }
    elsif ($controlEscape eq 'f') {
	return MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses::FF()->[0];
    }
    elsif ($controlEscape eq 'r') {
	return MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses::CR()->[0];
    }
}

sub _CharacterEscape_ControlLetter {
    my ($self, undef, $controlLetter) = @_;

    my $ch = $controlLetter;
    my $i = ord($ch);
    my $j = $i % 32;
    return chr($j);
}

sub _HexEscapeSequence { return chr(16 * hex($_[1]) + hex($_[2])); }
sub _UnicodeEscapeSequence { return chr(4096 * hex($_[2]) + 256 * hex($_[3]) + 16 * hex($_[4]) + hex($_[5])); }

sub _CharacterEscape_HexEscapeSequence {
    my ($self, $hexEscapeSequence) = @_;

    return $hexEscapeSequence;
}

sub _CharacterEscape_UnicodeEscapeSequence {
    my ($self, $unicodeEscapeSequence) = @_;

    return $unicodeEscapeSequence;
}

sub _CharacterEscape_IdentityEscape {
    my ($self, $identityEscape) = @_;

    return $identityEscape;
}

sub _DecimalEscape_DecimalIntegerLiteral {
    my ($self, $decimalIntegerLiteral) = @_;

    my $i = $decimalIntegerLiteral;
    if ($i == 0) {
	return \N{0000};
    }
    return chr($i);
}

sub _CharacterClassEscape {
    my ($self, $cCharacterClassEscape) = @_;

    if ($cCharacterClassEscape eq 'd') {
	return [0 , [ '0'..'9' ]];
    }
    elsif ($cCharacterClassEscape eq 'D') {
	return [1 , [ '0'..'9' ]];
    }
    elsif ($cCharacterClassEscape eq 's') {
	return [0 , [ @WHITESPACE, @LINETERMINATOR ]];
    }
    elsif ($cCharacterClassEscape eq 'S') {
	return [1 , [ @WHITESPACE, @LINETERMINATOR ]];
    }
    elsif ($cCharacterClassEscape eq 'w') {
	return [0 , [ 'a'..'z', 'A'..'Z', '0'..'9', '_' ]];
    }
    elsif ($cCharacterClassEscape eq 'W') {
	return [1 , [ 'a'..'z', 'A'..'Z', '0'..'9', '_' ]];
    }

}

sub _CharacterClass_ClassRanges {
    my ($self, undef, $classRanges, undef) = @_;

    return (&$classRanges, 0);
}

sub _CharacterClass_CaretClassRanges {
    my ($self, undef, $classRanges, undef) = @_;

    return (&$classRanges, 1);
}

sub _ClassRanges {
    my ($self) = @_;

    return [0, []];
}

sub _ClassRanges_NonemptyClassRanges {
    my ($self, $nonemptyClassRanges) = @_;

    return &$nonemptyClassRanges;
}

sub _NonemptyClassRanges_ClassAtom {
    my ($self, $classAtom) = @_;

    return &$classAtom;
}

sub _rangeComplement {
    my ($A) = @_;

    my ($Anegation, $Arange) = @{$A};

    my %hash = map {$_ => 1} @{$Arange};

    return [ $Anegation ? 0 : 1, [ grep {! exists($hash{$_})} (1.65535) ] ];
  
}

sub _charsetUnion {
    my ($A, $B) = @_;

    my ($Anegation, $Arange) = @{$A};
    my ($Bnegation, $Brange) = @{$A};

    my $lc = List::Compare->new('--unsorted', '--accelerated', $Arange, $Brange);

    if ($Anegation == $Bnegation) {
	#
	# If A and B have the same negation, then this really is a normal union
	#
	return [ $Anegation, get_union_ref('--unsorted', [ $Arange, $Brange ]) ];
    } else {
	#
	# If not A and B have the same negation, then this really is a normal union.
	# We choose the one with the smallest number of elements
	#
	my $Aelements = $#{$A->[1]};
	my $Belements = $#{$B->[1]};
	#
	# 65534 because this is the maximum index in JavaScript, limited explicitely to UCS-2
	#
	my $AelementsRevert = 65534 - $#{$A->[1]};
	my $BelementsRevert = 65534 - $#{$B->[1]};

	if (($Aelements + $BelementsRevert) <= ($AelementsRevert + $Belements)) {
	    #
	    # We take the union of A and reverted B
	    #
	    return _charsetUnion($A, _rangeComplement($B));
	} else {
	    #
	    # We take the union of reverted A and B
	    #
	    return _charsetUnion(_rangeComplement($A), $B);
	}
    }
}

sub _NonemptyClassRanges_ClassAtom_NonemptyClassRangesNoDash {
    my ($self, $classAtom, $nonemptyClassRangesNoDash) = @_;

    my $A = &$classAtom;
    my $B = &$nonemptyClassRangesNoDash;
    return _charsetUnion($A, $B);
}

sub _characterRange {
    my ($A, $B) = @_;

    my ($Anegation, $Arange) = @{$A};
    my ($Bnegation, $Brange) = @{$A};

    if ($Anegation != $Bnegation) {
	# We choose the one with the smallest number of elements
	#
	my $Aelements = $#{$A->[1]};
	my $Belements = $#{$B->[1]};
	#
	# 65534 because this is the maximum index in JavaScript, limited explicitely to UCS-2
	#
	my $AelementsRevert = 65534 - $#{$A->[1]};
	my $BelementsRevert = 65534 - $#{$B->[1]};

	if ($AelementsRevert <= $BelementsRevert) {
	    #
	    # We take the reverted A
	    #
	    ($Anegation, $Arange) = _rangeComplement($A);
	} else {
	    #
	    # We take the reverted B
	    #
	    ($Bnegation, $Brange) = _rangeComplement($B);
	}
    }

    if ($#{$Arange} != 0 || $#{$Brange} != 0) {
	SyntaxError("Doing characterRange requires both charsets to have exactly one element");
    }
    my $a = $Arange->[0];
    my $b = $Brange->[0];
    my $i = ord($a);
    my $j = ord($b);
    if ($i > $j) {
	SyntaxError("Doing characterRange requires first char '$a' to be <= second char '$b'");
    }

    return [$Anegation, [ map {chr($_)} ($i..$j) ]];

}

sub _NonemptyClassRanges_ClassAtom_ClassAtom_ClassRanges {
    my ($self, $classAtom1, undef, $classAtom2, $classRanges) = @_;

    my $A = &$classAtom1;
    my $B = &$classAtom2;
    my $C = &$classRanges;
    my $D = _characterRange($A, $B);
    return _charsetUnion($D, $C);
}

sub _NonemptyClassRangesNoDash_ClassAtom {
    my ($self, $classAtom) = @_;

    return &$classAtom;
}

sub _NonemptyClassRangesNoDash_ClassAtomNoDash_NonemptyClassRangesNoDash {
    my ($self, $classAtomNoDash, $nonemptyClassRangesNoDash) = @_;

    my $A = &$classAtomNoDash;
    my $B = &$nonemptyClassRangesNoDash;
    return _charsetUnion($A, $B);
}

sub _NonemptyClassRangesNoDash_ClassAtomNoDash_ClassAtom_ClassRanges {
    my ($self, $classAtomNoDash, undef, $classAtom, $classRanges) = @_;

    my $A = &$classAtomNoDash;
    my $B = &$classAtom;
    my $C = &$classRanges;
    my $D = _characterRange($A, $B);
    return _charsetUnion($D, $C);
}

sub _ClassAtom_Dash {
    my ($self, undef) = @_;

    return [0, [ '-' ]];
}

sub _ClassAtom_ClassAtomNoDash {
    my ($self, $classAtomNoDash) = @_;

    return &$classAtomNoDash;
}

sub _ClassAtomNoDash_OneChar {
    my ($self, $oneChar) = @_;

    return [0, [ $oneChar ]];
}

sub _ClassAtomNoDash_ClassEscape {
    my ($self, undef, $classEscape) = @_;

    return &$classEscape;
}

sub _ClassEscape_DecimalEscape {
    my ($self, $decimalEscape) = @_;

    my $E = &$decimalEscape;

    my $ch = eval {chr($E)};
    if ($@) {
	SyntaxError("Decimal Escape is not a valid character");
    }
    return [0, [ $ch ]];
}

sub _ClassEscape_b {
    my ($self, undef) = @_;

    return [0, MarpaX::Languages::ECMAScript::AST::Grammar::ECMAScript_262_5::CharacterClasses::BS() ];
}

sub _ClassEscape_CharacterEscape {
    my ($self, $characterEscape) = @_;

    return [0, [ &$characterEscape ]];
}

sub _ClassEscape_CharacterClassEscape {
    my ($self, $characterClassEscape) = @_;

    return &$characterClassEscape;
}

1;
