# -*- perl -*-
#
# tree.perl - Perl sub-routines for working with parse-trees.
#
# Time-stamp: <96/08/12 13:41:13 ringger>
#
# RCS $Header: /u/ringger/research/trains/pview/RCS/tree.perl,v 1.2 1996/08/12 18:43:35 ringger Exp ringger $
#
# History:
#   96 Jun 19  ringger - Created.
#   96 Jun 20  ringger - Added node marking to avoid duplicate trees.
#   96 Jul 02  ringger - Vertical tree drawing.
#


#------------------------ Constants ------------------------

my $y_inc = 32;
my $x_inc = 16;
my $y_indent = 8;
my $x_indent = 24;
my $font = '-Adobe-Courier-Medium-R-Normal--*-120-*-*-*-*-*-*';
my $w_delim = 2000;


#------------------------ Globals ------------------------

$y_depth = 0;
$y_base = 0;


#================================================================
# Sub-routines
#================================================================

sub tree_build {
    my $tree = shift;

    my @tokens = split('', $tree); # split into characters
    my $tok;
    my $f_root = 0;
    my $state = "key";
    my ($key, $feat, $val);
    my %t;
    
    while (@tokens) {
	if ($tokens[0] eq '(') {
	    $f_root = 1;
	    shift(@tokens);
	    next;
	}
	if ($tokens[0] eq ')') {
	    shift(@tokens);
	    last;
	}
	if ($tokens[0] =~ /\s/) {
	    shift(@tokens);
	    next;
	}
	if ($tokens[0] eq '"') {
	    $state = "key";
	}

	if ($state eq "key") {
	    $key = &parse_string(\@tokens);
	    # if (defined $t{$key}) {
	    #    warn "$prog: ** noticed $key again! **\n";
	    # }
	    if ($f_root) {
		$t{"root"} = $key;
		$f_root = 0;
	    }
	    if ($key =~ /^\"UTT\d+\"$/) {
		$t{"utts"}{$key} = 1;
	    }
	    $state = "type";
	} elsif ($state eq "type") {
	    $t{$key}{"type"} = &parse_word(\@tokens);
	    $state = "feat";
	} elsif ($state eq "feat") {
	    $feat = &parse_word(\@tokens);
	    $state = "val";
	} elsif ($state eq "val") {
	    if ($feat > 0) {
		$val = &parse_word(\@tokens);
		# if (defined $t{"\"$val\""}) {
		#     warn "$prog: ** use of predefined $val! **\n";
		# }
		$t{$key}{"dtr"}[$feat] = $val;
		if ($t{$key}{"c_dtr"} < $feat) {
		    # save the high index
		    $t{$key}{"c_dtr"} = $feat;
		}
	    } else {
		$t{$key}{$feat} = &parse_word(\@tokens);
	    }
	    $state = "feat";
	}
    }

    # mark each non-top-level utterance
    &mark_tree(\%t);

    return \%t;
}

sub mark_tree {
    my $r_tree = shift;		# reference to tree structure

    my $u;

    # mark each utterance
    foreach $u (sort keys %{$r_tree->{"utts"}}) {
	&mark_branch($r_tree, $u, 1);
    }
}

sub mark_branch {
    my $r_tree = shift;		# ref. to tree structure
    my $node = shift;		# node name
    my $f_top = shift;		# a root node?

    my $key = ($f_top) ? $node : "\"$node\"";
    my ($d, $d_max);

    if (!$f_top) {
	$r_tree->{$key}{"done"} = 1;
    }

    if (exists $r_tree->{$key}{"c_dtr"}) {
	$d_max = $r_tree->{$key}{"c_dtr"};
	for ($d = 1; $d <= $d_max; $d++) {
	    &mark_branch($r_tree, $r_tree->{$key}{"dtr"}[$d], 0);
	}
    } elsif (exists $r_tree->{$key}{"LEX"}) {
	if ($r_tree->{$key}{"LEX"} eq "START-OF-UTTERANCE") {
	    # replace with short SGML-style mark
	    $r_tree->{$key}{"LEX"} = "<s>";
	} elsif ($r_tree->{$key}{"LEX"} eq "END-OF-UTTERANCE") {
	    # replace with short SGML-style mark
	    $r_tree->{$key}{"LEX"} = "</s>";
	}
    }	
}

sub add_tree {
    my $canv = shift;		# canvas
    my $r_tree = shift;		# reference to tree structure

    my $u;

    &add_delim($canv, 1);
    $y_base++;
    foreach $u (sort keys %{$r_tree->{"utts"}}) {
	next if (exists $r_tree->{$u}{"done"});
	&measure_branch($r_tree, $u, 1, 0, 0);
	&add_branch($canv, $r_tree, $u, 1, "");
	$y_base += $y_depth + 2;
	&add_delim($canv, 0);
	$y_base++;
    }
}

sub measure_branch {
    my $r_tree = shift;		# ref. to tree structure
    my $node = shift;		# node name
    my $f_top = shift;		# a root node?
    my $x_start = shift;	# start index
    my $y_level = shift;	# level

    my $key = ($f_top) ? $node : "\"$node\"";
    my ($d, $d_max);
    my $w;

    $r_tree->{$key}{"width"} = 0;
    $r_tree->{$key}{"x_start"} = $x_start;
    $r_tree->{$key}{"y_level"} = $y_level;
    if (exists $r_tree->{$key}{"c_dtr"}) {
	$d_max = $r_tree->{$key}{"c_dtr"};
	for ($d = 1; $d <= $d_max; $d++) {
	    $w = &measure_branch($r_tree, $r_tree->{$key}{"dtr"}[$d], 0,
				 $x_start + $r_tree->{$key}{"width"},
				 $y_level + 1);
	    $r_tree->{$key}{"width"} += $w;
	}
    } elsif (exists $r_tree->{$key}{"LEX"}) {
	$r_tree->{$key}{"width"} = length($r_tree->{$key}{"LEX"}) * $x_inc;
    }	

    return $r_tree->{$key}{"width"};
}

sub add_branch {
    my $canv = shift;		# canvas
    my $r_tree = shift;		# ref. to tree structure
    my $node = shift;		# node name
    my $f_top = shift;		# root node?
    my $p_key = shift;

    my ($key, $type);
    my ($d, $d_max);
    my $i;
    my ($x_start, $y_level);

    if (!$f_top) {
	$key = "\"$node\"";	# key name ($node with quotes)
    } else {
	$key = $node;
    }

    $type = $r_tree->{$key}{"type"};
    $x_start = $r_tree->{$key}{"x_start"};
    $y_level = $r_tree->{$key}{"y_level"};
    if ($y_level > $y_depth) {
	$y_depth = $y_level;
    }
    # $type .= "($x_start,$y_level)";
    &add_text($canv, $type, $x_start, $y_level + $y_base, 0, $f_top);
    if (!$f_top) {
	&add_line($canv, $x_start, $y_level + $y_base,
		  $r_tree->{$p_key}{"x_start"},
		  $r_tree->{$p_key}{"y_level"} + $y_base,
		  0);
    }
    if (exists $r_tree->{$key}{"LEX"}) {
	&add_text($canv, $r_tree->{$key}{"LEX"},
		  $x_start, $y_level + $y_base, 1, 0);
	&add_line($canv, $x_start, $y_level + $y_base,
		  $x_start, $y_level + $y_base,
		  1);
    }
    if (exists $r_tree->{$key}{"c_dtr"}) {
	$d_max = $r_tree->{$key}{"c_dtr"};
	for ($d = 1; $d <= $d_max; $d++) {
	    &add_branch($canv, $r_tree, $r_tree->{$key}{"dtr"}[$d], 0, $key);
	}
    }
}

sub add_text {
    my $canv = shift;
    my $txt = shift;
    my $x_start = shift;
    my $y_level = shift;
    my $f_lex = shift;
    my $f_top = shift;

    # my $x = $x_indent + $x_start * $x_inc;
    my $x = $x_indent + $x_start;
    my $y = $y_indent + $y_level * $y_inc
	+ ($f_lex ? $y_inc : 0);
    my $fill = $f_lex ? 'blue' : ($f_top ? 'red' : 'black');

    # warn "$prog: \_$txt\_ at ($x,$y)\n";
    $canv->create('text', $x, $y,
		  -fill => $fill,
		  -anchor => 'n',
		  -font => $font,
		  -text => $txt,
		  -tags => 'text');
}

sub add_line {
    my $canv = shift;
    my $x_start = shift;
    my $y_level = shift;
    my $px_start = shift;
    my $py_level = shift;
    my $f_lex = shift;

    # my $x = $x_indent + $x_start * $x_inc;
    my $x = $x_indent + $x_start;
    my $y = $y_indent + $y_level * $y_inc + ($f_lex ? $y_inc : 0);
    # my $px = $x_indent + $px_start * $x_inc;
    my $px = $x_indent + $px_start;
    my $py = $y_indent + $py_level * $y_inc + 12;
    my $fill = $f_lex ? 'blue' : 'black';

    $canv->create('line', $x, $y, $px, $py,
		  -fill => $fill,
		  -tags => 'nontext'); 
}

sub add_delim {
    my $canv = shift;
    my $f_thick = shift;

    my $y = $y_indent + $y_base * $y_inc;

    $canv->create('line', 0, $y, $w_delim, $y,
		  -fill => 'red',
		  -tags => 'nontext'); 
    if ($f_thick) {
	$canv->create('line', 0, $y+2, $w_delim, $y+2,
		      -fill => 'red',
		      -tags => 'nontext'); 
	$canv->create('line', 0, $y+4, $w_delim, $y+4,
		      -fill => 'red',
		      -tags => 'nontext'); 
    }
}


1;
