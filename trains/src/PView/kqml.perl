# -*- perl -*-
#
# kqml.perl - Perl sub-routines for handling KQML message strings.
#
# Time-stamp: <96/06/17 15:39:05 ringger>
#
# RCS $Header: /u/ringger/research/trains/pview/RCS/kqml.perl,v 1.1 1996/06/20 17:13:27 ringger Exp $
#
# History:
#   96 Jun 17  ringger - Created.
#


sub parse_kqml {
    my $msg = shift;
    my @ch;

    $msg =~ s/\n/ /sg;		# make into single line
    $msg =~ s/^\s+//g;		# eliminate leading white-space
    $msg =~ s/\s+$//g;		# eliminate trailing white-space
    $msg =~ s/\s+/ /g;		# condense to single space

    @ch = split('', $msg);	# split into characters

    return &parse_kqml2(\@ch, "message");
}

sub parse_kqml2 {
    my $r_ch = shift;
    my @ch = @{$r_ch};
    my $label = shift;
    my %m;
    my $attrib, $val;

    # warn "$prog: Entering parse_kqml2()\n";

    # get type
    $c = shift(@ch);
    if ($c ne '(') {
	warn "$prog: ** Ill-defined KQML: no open paren. **\n";
	warn "$prog:    $msg";
	return \%m;
    }
    while ($ch[0] =~ /\s/) {
	shift(@ch);
    }
    $type = &parse_word(\@ch);
    $type =~ tr/A-Z/a-z/;
    # warn "$prog: Parsing $label of type $type ...\n";
    $m{"type"} = $type;

    # get attribute/value pairs
    for ($c = shift(@ch); @ch; $c = shift(@ch)) {

	if ($c =~ /\s/) {
	    next;
	}

	if ($c eq ')') {
	    # if (@ch > 0) {
	    #     warn "$prog: ** Ill-defined KQML: no final paren. **\n";
	    #     warn "$prog:    $msg";
	    # }
	    last;
	}

	# get attribute
	if ($c eq ':') {
	    $attrib = &parse_word(\@ch);
	    $attrib =~ tr/A-Z/a-z/;
	    if ($attrib eq "type") {
		warn "$prog: ** Attribute \"type\" encountered ! **\n";
	    }
	    # handle content attribute as though it were a message of its own.
	    if ($attrib eq "content") {
		$m{$attrib} = &parse_kqml2(\@ch, "content");
		$attrib = "";
	    }		
	    next;
	}

	# get value
	if ($c eq '(') {
	    unshift(@ch, $c);
	    $val = &parse_sexp(\@ch);
	} elsif ($c eq '"') {
	    unshift(@ch, $c);
	    $val = &parse_string(\@ch);
	} else {
	    unshift(@ch, $c);
	    $val = &parse_word(\@ch);
	}

	# store pair
	if (!$attrib) {
	    $attrib = "default";
	}
	# warn "$prog: Identified pair for $label: $attrib = $val\n";
	$m{$attrib} = $val;
	$attrib = "";
    }

    # warn "$prog: Exiting parse_kqml2()\n";
    return \%m;
}

sub parse_word {
    my $r_ch = shift;
    my $wd;
    my $c;

    # warn "$prog: Entering parse_word()\n";

    for ($c = shift(@{$r_ch}); @{$r_ch}; $c = shift(@{$r_ch})) {
	last if ($c =~ /\s/);
	if ($c eq ')') {
	    unshift(@{$r_ch}, $c);
	    last;
	}
	$wd .= $c;
    }

    # warn "$prog: parse_word() returning $wd\n";
    return $wd;
}

sub parse_string {
    my $r_ch = shift;
    my ($str, $c, $c_quote);

    # warn "$prog: Entering parse_string()\n";

    for ($c = shift(@{$r_ch}); @{$r_ch}; $c = shift(@{$r_ch})) {
	if ($c eq '"') {
	    $c_quote++;
	}
	$str .= $c;
	last if ($c_quote >= 2);
    }

    # warn "$prog: parse_string() returning $str\n";
    return $str;
}

sub parse_sexp {
    my $r_ch = shift;
    my ($sexp, $c, $c_parens);

    # warn "$prog: Entering parse_sexp()\n";

    for ($c = shift(@{$r_ch}); @{$r_ch}; $c = shift(@{$r_ch})) {
	$sexp .= $c;

	if ($c eq '(') {
	    $c_parens++;
	} elsif ($c eq ')') {
	    $c_parens--;
	}
	if ($c_parens < 0) {
	    $sexp = "";
	    warn "$prog: ** Badly formatted s-expression **\n";
	} elsif ($c_parens == 0) {
	    last;
	}
    }
    
    # warn "$prog: parse_sexp() returning $sexp\n";
    return $sexp;
}

1;
