#!/usr/imports/bin/perl5
# 2/2/98 DRT: changed above line from perl to work here /usr/local/bin/perl5
#========================================================================
#
# speechpp -- A Component of Trains-96 2.2
#
# From Emacs:
$timestamp =  "Time-stamp: <Mon Jan 20 14:53:33 EST 1997 ferguson>";
#
# Author: Eric Ringger <ringger@cs.rochester.edu>
#
# $Header: /u/ringger/research/speechpp/speechpp,v 1.16 1996/05/20 14:44:00 ringger Exp $
#
#========================================================================
#
# (C) Copyright 1995, 1996  Eric K. Ringger and the University of Rochester
#
# Permission to use and/or redistribute this program is granted by the
#   author under the condition that this copyright notice remains intact
#   with this program.
#
# Users/distributors of this program are encouraged to:
#   1. notify the author of use and/or distribution, and
#   2. bring significant changes to the attention of the author.
#
#========================================================================
#
# Purpose:  Given input hypothesis word sequence (one or more words at
#           a time), propose the most likely pre-channel word sequence.
#
# See Man Page for Details.
#
#========================================================================

use strict 'refs';


#================================================================
# Config. Parameters
#================================================================

# just use basename of program, rather than whole path.
@prog = split('/', $0); $prog = pop(@prog);

$# = "%.4g";
$| = 1;				# unbuffered output
$usage = "Usage: $prog [-s] [-v] [-n] [-g] [-t] [-nt] [-i] [-m] [-d]\n"
    .    "       [-f2] [-fh] [-fi]\n"
    .    "       [-c <confusion file>] [-w <wbic file>]\n"
    .    "       [-x <deletions file>] [-sc <split-cand. file>]\n"
    .    "       [-in <insertions file>] [-mc <merge-cand. file>]\n"
    .    "       [-{2,3} <back-off trigram lm file>]\n"
    .    "       [-l <log-dir>]\n"
    .    "       [-q <priority queue depth>]\n";

$TRAINS_BASE_DEFAULT = "/fs/disco/group/systems/trains";
if (!($TRAINS_BASE = $ENV{"TRAINS_BASE"})) {
    $TRAINS_BASE = $TRAINS_BASE_DEFAULT;
}
$MODELS_BASE = "$TRAINS_BASE/etc/SpeechPP/models";
# default models are for *tdc-75*.
#$MODELS_PREFIX = "atis";
$MODELS_PREFIX = "tdc-75";

$fn_log = "speechpp.log";
$log_header = '='x24 . " Begin SpeechPP (v. $VERSION) Log " . '='x24 . "\n";


#----------------------------------------------------------------
# Constants
#----------------------------------------------------------------

$minlp =     -1000.0;
$beamwidth =  100 * $minlp;
$prqe_null = -1;
$nbest_lim =  15;
%h_ll_null =  {};
$ll_null =    \%h_ll_null;


#----------------------------------------------------------------
# Arguments
#----------------------------------------------------------------

$config = "\nConfiguration Parameters:\n";

#
# Default values:
#   (Superceded by "Hard-coded values" below).
#
$f_stats = $f_verbose = $f_nbest = $f_lattice = $f_trains
    = $f_backoff = $f_bigrams = $f_trigrams = $f_minlp
    = $f_fertility_12 = $f_fertility_21 = $f_fertility_01 = $f_iactive = 0;
$logdir = ".";			# ($logdir eq "") is also used to
				#   indicate that the log file is not open.
$prqi_lim =   1;		# priority queue depth
$fn_confusion = "$MODELS_BASE/$MODELS_PREFIX.confusion";
$fn_wbic = "$MODELS_BASE/$MODELS_PREFIX.wbic";
$fn_arpabo = "$MODELS_BASE/$MODELS_PREFIX.arpabo";
$fn_splitcand = "$MODELS_BASE/$MODELS_PREFIX.splitcand";
$fn_mergecand = "$MODELS_BASE/$MODELS_PREFIX.mergecand";
$fn_insertion = "$MODELS_BASE/$MODELS_PREFIX.inserted";

# Currently unused:
$fn_deletion = "$MODELS_BASE/$MODELS_PREFIX.deleted";

#
# *Hard-coded* values:
#
$f_backoff = 1; $config .= "Using Back-off LM (by default)\n";
$f_bigrams = 1; $config .= "Using Bigram Back-off LM (by default)\n";
$f_trains = 1; $config .= "Communicating with Trains Modules (by default)\n";
$f_minlp = 1; $config .= "Using Min. Log-Prob. for LM (by default)\n";

if ($prog eq "tspeechpp") {
    $f_fertility_12 = 1; $config .= "Using 1->2 Fertility in Channel Model (by default)\n";
    $f_fertility_21 = 1; $config .= "Using 2->1 Fertility in Channel Model (by default)\n";
}

while ($arg = shift) {
    if ($arg eq "-s") {
	$f_stats = 1;
	$config .= "Printing stats\n";
    } elsif ($arg eq "-v") {
	$f_verbose = 1;
	$config .= "Printing stats verbosely\n";
    } elsif ($arg eq "-n") {
	$f_nbest = 1;
	$config .= "Printing N-best\n";
    } elsif ($arg eq "-g") {	# word-Graph
	$f_lattice = 1;
	$config .= "Printing Lattice\n";
    } elsif ($arg eq "-t") {
	$f_trains = 1;
	$config .= "Communicating with Trains Modules\n";
    } elsif ($arg eq "-nt") {
	$f_trains = 0;
	$config .= "*Not* Communicating with Trains Modules\n";
    } elsif ($arg eq "-i") {
	$f_iactive = 1;
	$config .= "Running Interactive (prompt etc.)\n";
    } elsif ($arg eq "-m") {
	$f_minlp = 1;
	$config .= "Using Min. Log-Prob. for LM\n";
    } elsif ($arg eq "-d") {
	$f_dump = 1;
	$config .= "Dumping internal state at end of utterance\n";
    } elsif ($arg eq "-f2") {
	$f_fertility_12 = 1;
	$config .= "Using 1->2 Fertility in Channel Model\n";
    } elsif ($arg eq "-fh") {
	$f_fertility_21 = 1;
	$config .= "Using 2->1 Fertility in Channel Model\n";
    } elsif ($arg eq "-fi") {
	$f_fertility_01 = 1;
	$config .= "Using 0->1 Fertility in Channel Model\n";
    } elsif ($arg eq "-2") {
	($fn_arpabo = shift) || die $usage;
	$f_backoff = 1;
	$config .= "Using Back-off LM\n";
	if ($f_trigrams) {
	    die("$prog: opts -2 and -3 are mutually exclusive.\n$usage");
	}
	$f_bigrams = 1;
	$config .= "Using Bigram Back-off LM\n";
	$f_trigrams = 0;
    } elsif ($arg eq "-3") {
	($fn_arpabo = shift) || die $usage;
	$f_backoff = 1;
	if ($f_bigrams) {
	    die("$prog: opts -2 and -3 are mutually exclusive.\n$usage");
	}
	$f_bigrams = 0;
	$f_trigrams = 1;
	$config .= "Using Bigram Back-off LM\n";
    } elsif (($arg eq "-l") || ($arg eq "-logdir")) {
	($logdir = shift) || die $usage;
	$logdir =~ s/\"([^\"]*)\"/$1/;	
    } elsif ($arg eq "-c") {
	($fn_confusion = shift) || die $usage;
	$config .= "Confusion file = $fn_confusion\n";
    } elsif ($arg eq "-x") {
	($fn_deletion = shift) || die $usage;
	$config .= "Deletion file = $fn_deletion\n";
    } elsif ($arg eq "-sc") {
	($fn_splitcand = shift) || die $usage;
	$config .= "Split-Candidates file = $fn_splitcand\n";
    } elsif ($arg eq "-mc") {
	($fn_mergecand = shift) || die $usage;
	$config .= "Merge-Candidates file = $fn_mergecand\n";
    } elsif ($arg eq "-in") {
	($fn_insertion = shift) || die $usage;
	$config .= "Insertion file = $fn_insertion\n";
    } elsif ($arg eq "-w") {
	($fn_wbic = shift) || die $usage;
	$config .= "WBIC file = $fn_wbic\n";
    } elsif ($arg eq "-q") {
	($prqi_lim = shift) || die $usage;
	if (($prqi_lim < 0) || ($prqi_lim > 10)) {
	    warn "$prog: ** Q. Depth out of range. Setting to 1. **\n";
	    $prqi_lim = 1;
	}
	$config .= "prqi = $prqi_lim\n";
    } else {
	die $usage;
    }
}

$config .= "\n";

if ($logdir) {
    open(LOGFILE, ">$logdir/$fn_log")
	|| do {
	    warn "$prog: ** Unable to open $logdir/$fn_log: $! **\n";
	    $logdir = "";
	}
}
if ($logdir) {
    select(LOGFILE); $| = 1; select(STDOUT);
}

&spp_log($log_header);
$timestamp =~ /<([^>]*)\s+ringger>/; $time_date = $1;
$startup_msg = "$0: $time_date EST\n";
if ($f_trains) {
    warn $startup_msg;
}
&spp_log($startup_msg);
&spp_log($config);


#----------------------------------------------------------------
# Initialize channels with the rest of the Trains system.
#----------------------------------------------------------------

if ($f_trains) {
    # If this module is started by the PM (as is the case in practice),
    #   PM does the register'ing itself, so it's commented out here:
    # &send_msg("(register :receiver im :name speech-pp)\n");

    &send_msg("(request :receiver im :content (listen speech-in))\n");
}


#----------------------------------------------------------------
# Globals
#----------------------------------------------------------------
my @seq_ref = ();
my @seq_hyp = ();
my @seq_scores = ();
my @seq_last = ();
my @pr_seq_hyp_i = ();
my @sr_seq_hyp = ();
my @sr_seq_hyp_i = ();
my @sra_seq_hyp_i = ();
my $n_utt;
my $f_start = 0;
my $f_offline = 0;
my $f_wasoffline = 0;
my $f_silence = 0;
my $user_name;
my $user_lang;
my $user_sex;


#================================================================
# Structures
#================================================================

# !! Needs updating with ARPABO structures.

#----------------------------------------------------------------
# Name         Index1  Index2  Index3  Contents
# ------------ ------- ------- ------- --------------------------
# %refwords    refword                 Reference word counts
# %hypwords    hypword                 Hypothesis word counts
# ------------ ------- ------- ------- --------------------------
# %confc       refword hypword         1->1 Confusion count
# %confp       refword hypword         Confusion probability
# %nconfp      refword                 Probability of refword being involved
#                                        in any 1->1 confusion
# %conflp      refword hypword         Confusion log probability
# %confb       refword hypword         (Boolean) Presence of conf lp
# ------------ ------- ------- ------- --------------------------
# *new*
# %conf2c      refword hypword hypword 1->2 Confusion count
# %conf2p      refword hypword hypword Confusion probability
# %nconf2p     refword                 Probability of refword being involved
#                                        in any 1->2 confusion
# %conf2lp     refword hypword hypword Confusion log probability
# %conf2b      refword hypword hypword (Boolean) Presence of conf2 lp
# ------------ ------- ------- ------- --------------------------
# *new*
# %confhc      refword refword hypword 2->1 Confusion count
# %confhp      refword refword hypword Confusion probability
# %confhlp     refword refword hypword Confusion log probability
# %confhb      refword refword hypword (Boolean) Presence of confh lp
# ------------ ------- ------- ------- --------------------------
# $ins_total                           Total number of insertions in train set
# ------------ ------- ------- ------- --------------------------
# %w2c         word1   word2           Word bigram count
# %w2lp        word1   word2           Word bigram log probability
# %w2b         word1   word2           (Boolean) Presence of bigram lp
# ------------ ------- ------- ------- --------------------------
# @states_c    stage                   Number of states (ref. words)
# @states_w    stage   state           Words
# @states_bd   stage   state           (Boolean) Presence of double word
# @states_prq  stage   state   index   Priority Queue of entries that point
#                                        back to a  state and associated
#                                        prq entry (for specific stage, state)
# ------------ ------- ------- ------- --------------------------
# %prqe                        with indices:
#                                      stti = state index
#                                      prqi = priority queue index
#                               *new*  stgi = stage index
#                                      csc  = confusion score total
#                               *new*  c2sc = 1->2 confusion score total
#                               *new*  chsc = 2->1 confusion score total
#                               *new*  insc = 0->1 confusion score total
#                                      lmsc = lang. model score total
#                                      sc   = score total (and priority)
#----------------------------------------------------------------


#================================================================
# Initialize
#================================================================

if (! $f_trains && $f_iactive) {
    print "Starting ... ";
    if ($f_verbose) {
	print "\n";
    }
}
if ($f_stats) { $start = time; }

# slurp in the confusion table
print "Loading $fn_confusion ...\n" if ($f_verbose);
open(CONFTABLE, "$fn_confusion")
    || die("$prog: could not open $fn_confusion: $!\n");
while (<CONFTABLE>) {
    chop;
    my ($rcount, $w_ref, $w_hyp);

    if (! /(\d+)\s+([\w\']+)\s([\w\']+)/) {
	# catch word fragments and other garbage
	# warn "$prog: ** Garbage Found: $_ **\n";
	next;
    }
    ($rcount, $w_ref, $w_hyp) = ($1, $2, $3);
    $refwords{$w_ref} += $rcount;
    $hypwords{$w_hyp} += $rcount; # currently unused
    $confc{$w_ref}{$w_hyp} += $rcount;
}
close(CONFTABLE);

# slurp in the split-candidates file
if ($f_fertility_12) {
    print "Loading $fn_splitcand ...\n" if ($f_verbose);
    open(SCTABLE, "$fn_splitcand")
	|| die("$prog: could not open $fn_splitcand: $!\n");
    while (<SCTABLE>) {
	chop;
	my ($scount, $w_ref, $w_hyp1, $w_hyp2);

	if (! /^\s+(\d+)\s+([\w\']+)\s+==>\s+([\w\']+)\s+([\w\']+)\s*$/) {
	    # warn "$prog: ** Garbage Found: $_ **\n";
	    next;
	}
	($scount, $w_ref, $w_hyp1, $w_hyp2) = ($1, $2, $3, $4);
	$spltcndc{$w_ref} += $scount;
	$conf2c{$w_ref}{$w_hyp1}{$w_hyp2} += $scount;
    }
    close(SCTABLE);
    # add new reference words encountered in the split-candidates table
    foreach $w_ref (keys(%spltcndc)) {
	&newrefword($w_ref, $spltcndc{$w_ref}, 1)
	    unless exists $refwords{$w_ref};
    }
}

# slurp in the merge-candidates file
if ($f_fertility_21) {
    print "Loading $fn_mergecand ...\n" if ($f_verbose);
    open(MCTABLE, "$fn_mergecand")
	|| die("$prog: could not open $fn_mergecand: $!\n");
    while (<MCTABLE>) {
	chop;
	my ($mcount, $w_ref1, $w_ref2, $w_hyp);

	if (! /^\s+(\d+)\s+([\w\']+)\s+([\w\']+)\s+==>\s+([\w\']+)\s*$/) {
	    # warn "$prog: ** Garbage Found: $_ **\n";
	    next;
	}
	($mcount, $w_ref1, $w_ref2, $w_hyp) = ($1, $2, $3, $4);
	$mrgcndc{$w_ref1} += $mcount;
	$mrgcndc{$w_ref2} += $mcount;
	$confhc{$w_ref1}{$w_ref2}{$w_hyp} += $mcount;
    }
    close(MCTABLE);
    # add new ref. words encountered in the merge-candidates table
    foreach $w_ref (keys(%mrgcndc)) {
	&newrefword($w_ref, $mrgcndc{$w_ref}, 1)
	    unless exists $refwords{$w_ref};
    }
}

# slurp in the insertions table
if ($f_fertility_01) {
    print "Loading $fn_insertion ...\n" if ($f_verbose);
    $instotal = 0;
    open(INSTABLE, "$fn_insertion")
	|| die("$prog: could not open $fn_insertion: $!\n");
    while (<INSTABLE>) {
	chop;
	my ($icount, $w_hyp);

	if (! /^\s+(\d+)\s+([\w\']+)\s*$/) {
	    # warn "$prog: ** Garbage Found: $_ **\n";
	    next;
	}
	($icount, $w_hyp) = ($1, $2);
	$insc{$w_hyp} += $icount;
	$ins_total += $icount;
    }
    close(INSTABLE);
}

# slurp in the deletions table
# open(DELTABLE, "$fn_deletion")
#     || die("$prog: could not open $fn_deletion: $!\n");
# while (<DELTABLE>) {
#     chop;
#     my ($dcount, $w_ref);
# 
#     if (! /^\s+(\d+)\s+([\w\']+)\s+$/) {
#         warn "$prog: ** Garbage Found: $_ **\n";
#         next;
#     }
#     ($dcount, $w_ref) = ($1, $2);
#     &newrefword($w_ref, $dcount, 1) unless exists $refwords{$w_ref};
#     $delc{$w_ref} += $dcount;
# }
# close(DELTABLE);

if ($f_stats && $f_verbose) {
    $c_confusable_words = keys(%refwords);
    print "# possible confusable words: $c_confusable_words\n";
    print "# global beam width: $beamwidth\n";
}

# slurp in the word bigram count table
print "Loading $fn_wbic ...\n" if ($f_verbose);
open(WBICTABLE, "$fn_wbic") || die("$prog: could not open $fn_wbic: $!\n");
while (<WBICTABLE>) {
    chop;
    if (! /([\w\'<>\/]+)\s([\w\'<>\/]+)\s+(\d+)/) {
	# catch word fragments and other garbage
	# warn "$prog: ** Garbage Found: $_ **\n";
	next;
    }
    ($w1, $w2, $bcount) = ($1, $2, $3);
    # Count only the occurrences of $w1, since the $w2 occurrences are
    #   duplications.  This leaves out the sentence terminal symbol
    #   </s>, which we don't need to tabulate anyway.
    $w1c{$w1} += $bcount;
    $w2c{$w1}{$w2} += $bcount;
}
close(WBICTABLE);

# slurp in the ARPA format back-off language model
if ($f_backoff) {
    print "Loading $fn_arpabo ...\n" if ($f_verbose);
    open(ARPABOFILE, "$fn_arpabo")
	|| die("$prog: could not open $fn_arpabo: $!\n");
    $flag_1g = $flag_2g = $flag_3g = 0;
    $log10 = log(10);
    while (<ARPABOFILE>) {
	chop;
	next if (/^\s*$/);

	if (/^\\1-grams:/) {
	    $flag_1g++;
	    next;
	} elsif (/^\\2-grams:/) {
	    $flag_2g++;
	    next;
	} elsif (/^\\3-grams:/) {
	    $flag_3g++;
	    next;
	} elsif (/^\\end\\/) {
	    last;
	}
	if (($flag_1g == 2) && ($flag_2g < 2)) {
	    /(\S+)\s+(\S+)\s+(\S+)/;
	    if (! ($2 && $3)) {
		warn "$prog: ** Garbage Found: $_ **\n";
		next;
	    }
	    ($lp1, $w, $bo1) = ($1, $2, $3);
	    $w1lp{$w} = $lp1 * $log10; # convert to natural log.
	    $w1bo{$w} = $bo1 * $log10; # convert to natural log.
	    $w1b{$w} = 1;
	} elsif (($flag_2g == 2) && ($flag_3g < 2)) {
	    /(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/;
	    if (! ($2 && $3 && $4)) {
		warn "$prog: ** Garbage Found: $_ **\n";
		next;
	    }
	    ($lp2, $w1, $w2, $bo2) = ($1, $2, $3, $4);
	    $w2lp{$w1}{$w2} = $lp2 * $log10; # convert to natural log.
	    $w2bo{$w1}{$w2} = $bo2 * $log10; # convert to natural log.
	    $w2b{$w1}{$w2} = 1;
	} elsif (($flag_3g == 2)) {
	    /(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/;
	    if (! ($2 && $3 && $4)) {
		warn "$prog: ** Garbage Found: $_ **\n";
		next;
	    }
	    ($lp3, $w1, $w2, $w3) = ($1, $2, $3, $4);
	    $w3lp{$w1}{$w2}{$w3} = $lp3 * $log10; # convert to natural log.
	    $w3b{$w1}{$w2}{$w3} = 1;
	} else {
	    # warn "$prog:  ** Extra Line Found: $_ **\n";
	}
    }
    close(ARPABOFILE);
}

# calculate 1->1 word confusion log-probabilities
foreach $w_ref (keys(%confc)) {
    foreach $w_hyp (keys(%{$confc{$w_ref}})) {
	if ($w1c{$w_ref} == 0) {
	    # warn "$prog: ** Word Unigram Count for $w_ref: 0 **\n";
	    next;
	}
	$confp{$w_ref}{$w_hyp} = $confc{$w_ref}{$w_hyp} / $w1c{$w_ref};
	$nconfp{$w_ref} += $confp{$w_ref}{$w_hyp};
	$conflp{$w_ref}{$w_hyp} = log($confp{$w_ref}{$w_hyp});
	$confb{$w_ref}{$w_hyp} = 1;
	# print "$w_ref $w_hyp:  $conflp{$w_ref}{$w_hyp}\n";
    }
}

# calculate the non-confusion (1->1 same) log-probabilities
foreach $w (keys(%refwords)) {
    $confp{$w}{$w} = 1 - $nconfp{$w};
    $confb{$w}{$w} = 1;
    if ($confp{$w}{$w} <= 0.0) {
	$conflp{$w}{$w} = $minlp;
	# flag out-of-vocab (OOV) words:
	# print "** Possible Out-of-vocab. Ref. Word: $w **\n";
	if ($confp{$w}{$w} < 0.0) {
	    # warn "$prog: ** Negative Prob.: $confp{$w}{$w} **\n";
	}
    } else {
	$conflp{$w}{$w} = log($confp{$w}{$w});
    }
    # print "$w $w:  $conflp{$w}{$w}\n";
}

# calculate 1->2 word confusion log-probabilities
if ($f_fertility_12) {
    foreach $w_ref (keys(%conf2c)) {
	foreach $w_hyp1 (keys(%{$conf2c{$w_ref}})) {
	    foreach $w_hyp2 (keys(%{$conf2c{$w_ref}{$w_hyp1}})) {
		if ($w1c{$w_ref} == 0) {
		    # warn "$prog: ** Word Unigram Count for $w_ref: 0 **\n";
		    next;
		}

		# ignore singletons
		# if ($conf2c{$w_ref}{$w_hyp1}{$w_hyp2} == 1) {
		#     next;
		# }

		$conf2p{$w_ref}{$w_hyp1}{$w_hyp2}
		  = $conf2c{$w_ref}{$w_hyp1}{$w_hyp2} / $w1c{$w_ref};
		# $nconf2p is currently unused
		$nconf2p{$w_ref} += $conf2p{$w_ref}{$w_hyp1}{$w_hyp2};
		$conf2lp{$w_ref}{$w_hyp1}{$w_hyp2}
		  = log($conf2p{$w_ref}{$w_hyp1}{$w_hyp2});
		$conf2b{$w_ref}{$w_hyp1}{$w_hyp2} = 1;
		# print "$w_ref $w_hyp1 $w_hyp2:  $conf2lp{$w_ref}{$w_hyp1}{$w_hyp2}\n";
	    }
	}
    }
}

# calculate 2->1 word confusion log-probabilities
if ($f_fertility_21) {
    foreach $w_ref1 (keys(%confhc)) {
	foreach $w_ref2 (keys(%{$confhc{$w_ref1}})) {
	    foreach $w_hyp (keys(%{$confhc{$w_ref1}{$w_ref2}})) {
		if ($w2c{$w_ref1}{$w_ref2} == 0) {
		    # warn "$prog: ** Word Bigram Count for ($w_ref1, $w_ref2): 0 **\n";
		    next;
		}

		$confhp{$w_ref1}{$w_ref2}{$w_hyp}
		  = $confhc{$w_ref1}{$w_ref2}{$w_hyp} / $w2c{$w_ref1}{$w_ref2};
		$confhlp{$w_ref1}{$w_ref2}{$w_hyp}
		  = log($confhp{$w_ref1}{$w_ref2}{$w_hyp});
		$confhb{$w_ref1}{$w_ref2}{$w_hyp} = 1;
		# print "$w_ref1 $w_ref2 $w_hyp:  $confhlp{$w_ref1}{$w_ref2}{$w_hyp}\n";
	    }
	}
    }
}

# calculate 0->1 word insertion log-probabilities
if ($f_fertility_01) {
    foreach $w_hyp (keys(%insc)) {
	$insp{$w_hyp} = $insc{$w_hyp}/$ins_total;
	$inslp{$w_hyp} = log($insp{$w_hyp});
	$insb{$w_hyp} = 1;
	# print "$w_hyp:  $inslp{$w_hyp}\n";
    }
}

# calculate word bigram log probabilities
if ($f_backoff) {
    # use Good-Turing (gt) estimator.
    # Back-off occurs on the fly.
} else {
    # use maximum likelihood estimator (mle)
    foreach $w1 (keys(%w2c)) {
	foreach $w2 (keys(%{$w2c{$w1}})) {
	    $w2lp{$w1}{$w2} = log($w2c{$w1}{$w2}) - log($w1c{$w1});
	    $w2b{$w1}{$w2} = 1;
	    # print "$w1 $w2:  $w2lp{$w1}{$w2}\n";
	}
    }   
}

# prep.
if (! $f_trains) {
    if ($f_stats) {
	if (! $f_verbose) {
	    $finish = time;
	    printf("%d secs\n", $finish-$start);
	}
    } elsif ($f_iactive) {
	&clearline;
    }
}


#================================================================
# Main Loop
#================================================================

# Inform Trains system that we're ready to go.
if ($f_trains) {
    &send_msg("(tell :receiver im :content (ready))\n");
} else {
    &search_init();
}    

$n_utt = 0;
&prompt($n_utt);

# Input word(s)/commands and perform search incrementally
while (<>) {
    if (! /^\s*$/) {
	if ($f_trains) {
	    if ($f_offline) {
		if (!&offline_kqml_msg($_)) {
		    last;	# msg said "exit"
		}
	    } else {
		if (!&dispatch_kqml_msg($_)) {
		    last;	# msg said "exit"
		}
	    }
	} else {
	    my (@words, $w_hyp);

	    # the non-trains mode no longer allows EOF to denote </s>
	    chomp;
	    &spp_log("$_\n", 3);
	    @words = split('\s', $_);
	    foreach $w_hyp (@words) {
		if (!&process_word($w_hyp, $n_utt)) {
		    &search_end(); # Finalize search
		    $n_utt++;
		    print "\n";
		    &search_init(); # Prepare for next search
		}
	    }
	}
    }

    &prompt($n_utt);
}

# clean up
print "\n" if ($f_iactive);

if ($logdir) {
    close(LOGFILE);
}

# Done
exit(0);


#================================================================
# Subroutines
#================================================================

#----------------
# search_init
#
sub search_init {
    my (%prqe, $r_prqe);

    $prqe{stti} = -1;		# null backpointer
    $prqe{prqi} = -1;		# null backpointer
    $prqe{stgi} = -1;		# null backpointer
    $prqe{csc} = 0.0;
    $prqe{c2sc} = 0.0;
    $prqe{chsc} = 0.0;
    $prqe{insc} = 0.0;
    $prqe{lmsc} = 0.0;
    $prqe{sc} = 0.0;
    $r_prqe = \%prqe;		# reference

    $states_c[0] = 1;		# one 0-length sequence
    $states_w[0][0] = "<s>";	# initial word is SGML begin marker
    $states_bd[0][0] = 0;
    &prq_init(0, 0);		# initialize @states_prq[0][0][]
    &prq_push(0, 0, $r_prqe);	# initialize @states_prq[0][0][0]

    &gprq_init(0);		# initialize @gprq[0][]
    &gprq_push(0, $r_prqe);	# initialize @gprq[0][0]

    @seq_hyp = ();
    push(@seq_hyp, "<s>");	# begin with the SGML begin marker
    @seq_ref = ();
    @seq_last = ();
    @pr_seq_hyp_i = ();
    $pr_seq_hyp_i[0] = 0;
    @sr_seq_hyp = ();
    @sr_seq_hyp_i = ();
    $sr_seq_hyp_i[0] = 0;
    @sra_seq_hyp_i = ();
    $sra_seq_hyp_i[0] = 0;
}


#----------------
# search_end
#
sub search_end {
    my (%prqe, $r_prqe, @seq);

    # handle end marker
    push(@seq_hyp, "</s>");
    if ($f_stats) { print "H: @seq_hyp"; }
    &newrefword("</s>") unless exists $refwords{"</s>"};
    if ($f_stats && ($f_trains || $f_verbose)) { print "\n"; }
    &advance_search("</s>", $seq_hyp[$#seq_hyp-1], ($#seq_hyp-1), 1);
    # update the parser.
    &update_out($#seq_hyp-1, 0, $n_utt);

    # create terminal entries in priority queues
    $prqe{stti} = 0;
    $prqe{prqi} = 0;
    $prqe{stgi} = $#seq_hyp;
    $prqe{csc} = $states_prq[$#seq_hyp][0][0]{csc};
    $prqe{c2sc} = $states_prq[$#seq_hyp][0][0]{c2sc};
    $prqe{chsc} = $states_prq[$#seq_hyp][0][0]{chsc};
    $prqe{insc} = $states_prq[$#seq_hyp][0][0]{insc};
    $prqe{lmsc} = $states_prq[$#seq_hyp][0][0]{lmsc};
    $prqe{sc} = $states_prq[$#seq_hyp][0][0]{sc};
    $r_prqe = \%prqe;		# make a reference (to be copied only!)
    &prq_push($#seq_hyp+1, $states_c[$#seq_hyp+1], $r_prqe);
    &gprq_push($#seq_hyp+1, $r_prqe);

    # update the parser.
    &update_out($#seq_hyp, 1, $n_utt);

    # optional N-best output.
    if ($f_nbest) { &nbest_dump($#seq_hyp); }

    # optional word-lattice output.
    if ($f_lattice) { &bp_dump($#seq_hyp); }

    if ($f_dump) { &states_dump($#seq_hyp); } # for debugging
}


#----------------
# newrefword
# 
# purpose:  interns a new reference word.
# returns:  nothing.
#
sub newrefword {
    my $w_hyp = shift;
    my $count = shift;
    my $f_startup = shift;

    if (! $count) { $count = 1; }

    # give this reference word the full log probability.
    $conflp{$w_hyp}{$w_hyp} = 0.0;
    $confb{$w_hyp}{$w_hyp} = 1;
    if ($f_stats && !$f_startup) { print "*"; }
    $refwords{$w_hyp} = $count;
}

#----------------
# advance_search
# 
# purpose:    consider each possible reference word that could have been
#             the pre-channel word for the given hyp. word.
# arguments:  $w_hyp      Hypothesis (input) word.
#             $w_hyp_prev Previous Hypothesis word.
#             $len        Current hyp. sequence length.
#             $f_end      Boolean flag indicating whether the end of
#                           seq. is now being processed.
# returns:    nothing.
#
sub advance_search {
    my $w_hyp = shift;
    my $w_hyp_prev = shift;
    my $len = shift;
    my $f_end = shift;

    my $len_next = $len + 1;
    my ($w_ref, $w_prev);
    my ($stti, $prqi, $clp, $c2lp, $chlp, $inslp, $lmlp);
    my ($w_prev2);
    my ($f_state_added);
    my (@conf_words, $conf_paths, @conf2_words, $conf2_paths,
	@confh_words, $confh_paths, @ins_words, $ins_paths);

    &gprq_init($len_next);
    $states_c[$len_next] = 0;	# 0 states for stage $len_next

    $bo[3] = $bo[2] = $bo[1] = $bo[0] = 0; # 0 LM usage stats

    $conf_paths = 0;		# 0 proposed 1->1 paths to stage $len_next

    # Loop for 1->1 confusion
    foreach $w_ref (keys(%refwords)) {
	next unless $confb{$w_ref}{$w_hyp};

	# Hack:  Don't allow "<s> NOW" --> "<s> NO".
	next if (($w_hyp eq "NOW") && ($w_ref eq "NO") && ($len == 0));

	push(@conf_words, $w_ref);

	# save this word $w_ref in current lattice node.
	$states_w[$len_next][$states_c[$len_next]] = $w_ref;
	$states_bd[$len_next][$states_c[$len_next]] = 0;
	# compute confusion lp delta.
	$clp = ($f_end) ? 0.0 : $conflp{$w_ref}{$w_hyp};
	# initialize the priqueue for $len_next and current state.
	&prq_init($len_next, $states_c[$len_next]);

	$f_state_added = 0;
	# consider every proposed ref. sequence to stage $len on
	#   the priority queues of all states at stage $len.
	for ($stti = 0; $stti < $states_c[$len]; $stti++) {
	    $w_prev = &get_word($len, $stti);
	    # compute lang. model lp delta.
	    $lmlp = &lmlp_wrapper_b($w_prev, $w_ref);

	    for ($prqi = 0; $prqi < $prqi_lim; $prqi++) {
		next if ($states_prq[$len][$stti][$prqi] == $prqe_null);

		# compute lang. model lp delta.
		if ($f_trigrams) {
		    $w_prev2 = &get_word_b1($len, $stti, $prqi);
		    $lmlp = &lmlp_wrapper_t($w_prev2, $w_prev, $w_ref);
		}

		# update the stage-level and stage/state-level priority queues
		$f_state_added = &prqs_update($len, $len_next, $stti, $prqi,
					      $clp, 0.0, 0.0, 0.0, $lmlp,
					      \$conf_paths);
	    }
	}
	$states_c[$len_next]++ if ($f_state_added);
    } # end foreach $w_ref

    $conf2_paths = 0;		# 0 proposed 1->2 paths to stage $len_next

    if ($f_fertility_12 && ! $f_silence) {
	# Loop for 1->2 confusion.
	foreach $w_ref (keys(%conf2b)) {
	    next unless $conf2b{$w_ref}{$w_hyp_prev}{$w_hyp};

	    push(@conf2_words, $w_ref);

	    # save this word $w_ref in current lattice node.
	    $states_w[$len_next][$states_c[$len_next]] = $w_ref;
	    $states_bd[$len_next][$states_c[$len_next]] = 0;
	    # compute 1->2 confusion lp delta.
	    $c2lp = ($f_end) ? 0.0 : $conf2lp{$w_ref}{$w_hyp_prev}{$w_hyp};
	    # initialize the priqueue for $len_next and current state.
	    &prq_init($len_next, $states_c[$len_next]);

	    $f_state_added = 0;
	    # consider every proposed ref. sequence to stage $len-1 on
	    #   the priority queues of all states at stage $len-1.
	    for ($stti = 0; $stti < $states_c[$len-1]; $stti++) {
		$w_prev = &get_word($len-1, $stti);
		# compute lang. model lp delta.
		$lmlp = &lmlp_wrapper_b($w_prev, $w_ref);

		for ($prqi = 0; $prqi < $prqi_lim; $prqi++) {
		    if ($states_prq[$len-1][$stti][$prqi] == $prqe_null) {
			next;
		    }

		    # compute lang. model lp delta.
		    if ($f_trigrams) {
			$w_prev2 = &get_word_b1($len-1, $stti, $prqi);
			$lmlp = &lmlp_wrapper_t($w_prev2, $w_prev, $w_ref);
		    }

		    # update stage-level and stage/state-level
		    #   priority queues.
		    $f_state_added = &prqs_update($len-1, $len_next, $stti,
						  $prqi, 0.0, $c2lp, 0.0, 0.0,
						  $lmlp, \$conf2_paths);
		}
	    }
	    $states_c[$len_next]++ if ($f_state_added);
	} # end foreach $w_ref
    }

    $confh_paths = 0;		# 0 proposed 2->1 paths to stage $len_next

    if ($f_fertility_21) {
	# Loop for 2->1 confusion.
	foreach $w_ref1 (keys(%confhb)) {
	    foreach $w_ref2 (keys(%{$confhb{$w_ref1}})) {
		next unless $confhb{$w_ref1}{$w_ref2}{$w_hyp};

		push(@confh_words, "($w_ref1, $w_ref2)");

		# save this word pair $w_ref1, $w_ref2 in current lattice node.
		$states_w[$len_next][$states_c[$len_next]] = [$w_ref1,$w_ref2];
		$states_bd[$len_next][$states_c[$len_next]] = 1;
		# compute 2->1 confusion lp delta.
		$chlp = ($f_end) ? 0.0 : $confhlp{$w_ref1}{$w_ref2}{$w_hyp};
		# initialize the priqueue for $len_next and current state.
		&prq_init($len_next, $states_c[$len_next]);

		$f_state_added = 0;
		# consider every proposed ref. sequence to stage $len on
		#   the priority queues of all states at stage $len.
		for ($stti = 0; $stti < $states_c[$len]; $stti++) {
		    $w_prev = &get_word($len, $stti);
		    # compute lang. model lp delta.
		    $lmlp = &lmlp_wrapper_b($w_prev, $w_ref1)
			+ &lmlp_wrapper_b($w_wref1, $w_ref2);

		    for ($prqi = 0; $prqi < $prqi_lim; $prqi++) {
			if ($states_prq[$len][$stti][$prqi] == $prqe_null) {
			    next;
			}

			# compute lang. model lp delta.
			if ($f_trigrams) {
			    $w_prev2 = &get_word_b1($len, $stti, $prqi);
			    $lmlp = &lmlp_wrapper_t($w_prev2, $w_prev, $w_ref1)
				+ &lmlp_wrapper_t($w_prev, $w_wref1, $w_ref2);
			}

			# update stage-level and stage/state-level
			#   priority queues.
			$f_state_added = &prqs_update($len, $len_next, $stti,
						      $prqi,
						      0.0, 0.0, $chlp, 0.0,
						      $lmlp, \$confh_paths);
		    }
		}
	        $states_c[$len_next]++ if ($f_state_added);
	    } # end foreach $w_ref2
        } # end foreach $w_ref1
    }

    $ins_paths = 0;		# 0 proposed 0->1 paths to stage $len_next

    if ($f_fertility_01 && $insb{$w_hyp_prev}) {
	push(@ins_words, "-$w_hyp_prev");

	# Loop for 0->1 confusion.
	foreach $w_ref (keys(%refwords)) {
	    next unless $confb{$w_ref}{$w_hyp};

	    # Hack:  Don't allow "<s> <any> NOW" --> "<s> <del> NO".
	    next if (($w_hyp eq "NOW") && ($w_ref eq "NO") && ($len == 1));

	    # save this word $w_ref in current lattice node.
	    $states_w[$len_next][$states_c[$len_next]] = $w_ref;
	    $states_bd[$len_next][$states_c[$len_next]] = 0;
	    # compute 0->1 insertion lp delta.
	    $inslp = $inslp{$w_hyp_prev};
	    # initialize the priqueue for $len_next and current state.
	    &prq_init($len_next, $states_c[$len_next]);

	    $f_state_added = 0;
	    # consider every proposed ref. sequence to stage $len-1 on
	    #   the priority queues of all states at stage $len-1.
	    for ($stti = 0; $stti < $states_c[$len-1]; $stti++) {
		$w_prev = &get_word($len-1, $stti);
		# compute lang. model lp delta.
		$lmlp = &lmlp_wrapper_b($w_prev, $w_ref);

		for ($prqi = 0; $prqi < $prqi_lim; $prqi++) {
		    if ($states_prq[$len-1][$stti][$prqi] == $prqe_null) {
			next;
		    }

		    # compute lang. model lp delta.
		    if ($f_trigrams) {
			$w_prev2 = &get_word_b1($len-1, $stti, $prqi);
			$lmlp = &lmlp_wrapper_t($w_prev2, $w_prev, $w_ref);
		    }

		    # update stage-level and stage/state-level
		    #   priority queues
		    $f_state_added = &prqs_update($len-1, $len_next, $stti,
						  $prqi,
						  0.0, 0.0, 0.0, $inslp,
						  $lmlp, \$ins_paths);
		}
	    }
	    $states_c[$len_next]++ if ($f_state_added);
	} # end foreach $w_ref
    }

    if ($f_stats && $f_verbose) {
	print "######## Summary:\n";
	print "# proposed 1->1 confusable words: (",
	      int(@conf_words), ") @conf_words\n";
	print "# proposed 1->1 paths: $conf_paths\n";
	if ($f_fertility_12) {
	    print "# proposed 1->2 confusable words: (",
	          int(@conf2_words), ") @conf2_words\n";
	    print "# proposed 1->2 paths: $conf2_paths\n";
	}
	if ($f_fertility_21) {
	    print "# proposed 2->1 confusable words: (",
	          int(@confh_words), ") @confh_words\n";
	    print "# proposed 2->1 paths: $confh_paths\n";
	}
	if ($f_fertility_01) {
	    print "# proposed 0->1 inserted words: (",
	          int(@ins_words), ") @ins_words\n";
	    print "# proposed 0->1 paths: $ins_paths\n";
	}
	print "# non globally pruned confusable words: $states_c[$len_next]\n";
	print "# tri = $bo[3]; bi = $bo[2]; uni = $bo[1]; minlp = $bo[0]\n";
    }
}


#----------------
# lmlp_wrapper_b
#
sub lmlp_wrapper_b {
    my $w1 = shift;
    my $w2 = shift;
    my $lmlp;

    if (! $f_backoff) {
	$lmlp = &lmlp_nobackoff($w1, $w2);
    } elsif ($f_bigrams && $f_minlp) {
	$lmlp = &lmlp_bigrambo_min($w1, $w2);
    } elsif ($f_bigrams && !$f_minlp) {
	$lmlp = &lmlp_bigrambo_nomin($w1, $w2);
    }

    return $lmlp;
}

#----------------
# lmlp_wrapper_t
#
sub lmlp_wrapper_t {
    my $w1 = shift;
    my $w2 = shift;
    my $w3 = shift;
    my $lmlp;

    if (! $w1) {
	$w1 = $f_minlp ? "<S>" : "<UNK>"; # pre-start.
    }

    if ($f_minlp) {
	$lmlp = &lmlp_trigrambo_min($w1, $w2, $w3);
    } else {
	$lmlp = &lmlp_trigrambo_nomin($w1, $w2, $w3);
    }

    return $lmlp;
}

sub prqs_update {
    my $stgi = shift;
    my $stgi_next = shift;
    my $stti = shift;
    my $prqi = shift;
    my $clp = shift;
    my $c2lp = shift;
    my $chlp = shift;
    my $inslp = shift;
    my $lmlp = shift;
    my $r_cnt = shift;
    my (%prqe, $r_prqe);
    my $f_state_added = 0;

    # point back to predecessor.
    $prqe{stti} = $stti;
    $prqe{prqi} = $prqi;
    $prqe{stgi} = $stgi;
    # compute cumulative confusion scores using confusion lps.
    $prqe{csc} = $states_prq[$stgi][$stti][$prqi]{csc} + $clp;
    $prqe{c2sc} = $states_prq[$stgi][$stti][$prqi]{c2sc} + $c2lp;
    $prqe{chsc} = $states_prq[$stgi][$stti][$prqi]{chsc} + $chlp;
    $prqe{insc} = $states_prq[$stgi][$stti][$prqi]{insc} + $inslp;
    # compute cumulative lang. model score using LM lp.
    $prqe{lmsc} = $states_prq[$stgi][$stti][$prqi]{lmsc} + $lmlp;
    # compute cumulative total score
    $prqe{sc} = $states_prq[$stgi][$stti][$prqi]{sc} + $clp + $c2lp + $chlp
	+ $inslp + $lmlp;
    # make a reference (to be copied only!)
    $r_prqe = \%prqe;

    # prune (for large enough $beamwidth, this is irrelevant)
    if ($prqe{sc} >= $beamwidth) {
	# potentially insert into priority queue.
	#   (this is where the real pruning occurs)
	&prq_push($stgi_next, $states_c[$stgi_next], $r_prqe);
	&gprq_push($stgi_next, $r_prqe);
	# in any case, increment the counter/index.
	${$r_cnt}++;
	$f_state_added = 1;
    }

    return $f_state_added;
}

#----------------
# lmlp_nobackoff
#
sub lmlp_nobackoff {
    my $w1 = shift;
    my $w2 = shift;

    return ($w2b{$w1}{$w2} ? $w2lp{$w1}{$w2} : $minlp);
}

#----------------
# lmlp_bigrambo_min
#
sub lmlp_bigrambo_min {
    my $w1 = shift;
    my $w2 = shift;
    my $lmlp;
    my $msg;

    if ($w2b{$w1}{$w2}) {
	$bo[2]++;
	$lmlp = $w2lp{$w1}{$w2};
    } elsif ($w1b{$w2}) {
	$msg = "$prog: ** Backing off to unigram:  $w1, $w2 **\n";
	$bo[1]++;
	$lmlp = $w1bo{$w1} + $w1lp{$w2};
    } else {
	$msg = "$prog: ** Backing off to min. LP:  $w1, $w2 **\n";
	$bo[0]++;
	$lmlp = $minlp;
    }

    # print $msg if $f_stats;
    return $lmlp;
}

#----------------
# lmlp_bigrambo_nomin
#
sub lmlp_bigrambo_nomin {
    my $w1_in = shift;
    my $w2_in = shift;
    my ($w1, $w2);
    my $lmlp;
    my $msg;

    $w1 = $w1b{$w1_in} ? $w1_in : "<UNK>";
    $w2 = $w1b{$w2_in} ? $w2_in : "<UNK>";
    if ($w2b{$w1}{$w2}) {
	$bo[2]++;
	$lmlp = $w2lp{$w1}{$w2};
    } else {
	$msg = "$prog: ** Backing off to unigram(1):  $w1, $w2 **\n";
	$bo[1]++;
	$lmlp = $w1bo{$w1} + $w1lp{$w2};
    }

    # print $msg if $f_stats;
    return $lmlp;
}

#----------------
# lmlp_trigrambo_min
#
sub lmlp_trigrambo_min {
    my $w1 = shift;
    my $w2 = shift;
    my $w3 = shift;
    my ($lp, $lmlp);
    my $msg;

    if ($w3b{$w1}{$w2}{$w3}) {
	$bo[3]++;
	$lmlp = $w3lp{$w1}{$w2}{$w3};
    } elsif ($w2b{$w1}{$w2}) {
	if ($w2b{$w2}{$w3}) {
	    $msg = "$prog: ** Backing off to bigram(1):  $w1, $w2, $w3 **\n";
	    $bo[2]++;
	    $lp = $w2lp{$w2}{$w3};
	} elsif ($w1b{$w2} && $w1b{$w3}) {
	    $msg = "$prog: ** Backing off to unigram(1):  $w1, $w2, $w3 **\n";
	    $bo[1]++;
	    $lp = $w1bo{$w2} + $w1lp{$w3};
	} else {
	    $msg = "$prog: ** Backing off to min lp(1):  $w1, $w2, $w3 **\n";
	    $bo[0]++;
	    $lp = $minlp;
	}
	$lmlp = $w2bo{$w1}{$w2} + $lp;
    } else {
	if ($w2b{$w2}{$w3}) {
	    $msg = "$prog: ** Backing off to bigram(2):  $w1, $w2, $w3 **\n";
	    $bo[2]++;
	    $lp = $w2lp{$w2}{$w3};
	} elsif ($w1b{$w2} && $w1b{$w3}) {
	    $msg = "$prog: ** Backing off to unigram(2):  $w1, $w2, $w3 **\n";
	    $bo[1]++;
	    $lp = $w1bo{$w2} + $w1lp{$w3};
	} else {
	    $msg = "$prog: ** Backing off to min lp(2):  $w1, $w2, $w3 **\n";
	    $bo[0]++;
	    $lp = $minlp;
	}
	$lmlp = $lp;
    }

    # print $msg if $f_stats;
    return $lmlp;
}

#----------------
# lmlp_trigrambo_nomin
#
sub lmlp_trigrambo_nomin {
    my $w1_in = shift;
    my $w2_in = shift;
    my $w3_in = shift;
    my ($w1, $w2, $w3);
    my ($lp, $lmlp);
    my $msg;

    $w1 = $w1b{$w1_in} ? $w1_in : "<UNK>";
    $w2 = $w1b{$w2_in} ? $w2_in : "<UNK>";
    $w3 = $w1b{$w3_in} ? $w3_in : "<UNK>";
    if ($w3b{$w1}{$w2}{$w3}) {
	$bo[3]++;
	$lmlp = $w3lp{$w1}{$w2}{$w3};
    } elsif ($w2b{$w1}{$w2}) {
	if ($w2b{$w2}{$w3}) {
	    $msg = "$prog: ** Backing off to bigram(1):  $w1, $w2, $w3 **\n";
	    $bo[2]++;
	    $lp = $w2lp{$w2}{$w3};
	} else {
	    $msg = "$prog: ** Backing off to unigram(1):  $w1, $w2, $w3 **\n";
	    $bo[1]++;
	    $lp = $w1bo{$w2} + $w1lp{$w3};
	}
	$lmlp = $w2bo{$w1}{$w2} + $lp;
    } else {
	if ($w2b{$w2}{$w3}) {
	    $msg = "$prog: ** Backing off to bigram(2):  $w1, $w2, $w3 **\n";
	    $bo[2]++;
	    $lp = $w2lp{$w2}{$w3};
	} else {
	    $msg = "$prog: ** Backing off to unigram(2):  $w1, $w2, $w3 **\n";
	    $bo[1]++;
	    $lp = $w1bo{$w2} + $w1lp{$w3};
	}
	$lmlp = $lp;
    }

    # print $msg if $f_stats;
    return $lmlp;
}

#----------------
# prompt
# 
# purpose:  Prompt the user if running interactively.
# returns:  nothing.
#
sub prompt {
    my $n = shift;

    if ($f_iactive) {
	if (!$f_stats && !$f_trains) { print "\n"; }
	print "speechpp($n)> ";
    }
}

#----------------
# clearline
# 
# purpose:  Clear 80 characters on a tty line using ^H.
# returns:  nothing.
#
sub clearline {
    my $i;

    for ($i = 0; $i <= 7; $i++) {
	printf("%c%c%c%c%c%c%c%c%c%c", 0x08, 0x08, 0x08, 0x08, 0x08,
	       0x08, 0x08, 0x08, 0x08, 0x08);
    }
    # for ($i = 0; $i <= 7; $i++) { printf("          "); }
    print ' ' x 80;
    for ($i = 0; $i <= 7; $i++) {
	printf("%c%c%c%c%c%c%c%c%c%c", 0x08, 0x08, 0x08, 0x08, 0x08,
	       0x08, 0x08, 0x08, 0x08, 0x08);
    }
}

#----------------
# backtrace
# 
# purpose:  provide word sequence from current lattice node.
# returns:  word sequence.
#
sub backtrace {
    my $len_last = shift;
    my $stti = shift;
    my $prqi = shift;
    my @words;
    my $len = $len_last - 1;
    my ($stti_new, $prqi_new);
    my ($str_len, @w);

    @seq_scores = ();

    if ($states_prq[$len][$stti][$prqi] != $prqe_null) {
	while ($len >= 0) {
	    unshift(@words, &get_words($len, $stti));
	    unshift(@seq_scores, $states_prq[$len][$stti][$prqi]{sc});
	    if ($f_stats && $f_verbose) {
		$str_len = "$len";
		if (length($str_len) < 2) {
		    $str_len = "# $len: ";
		} else {
		    $str_len = "#$len: ";
		}
		print $str_len;
		if ($states_prq[$len][$stti][$prqi] != $prqe_null) {
		    @w = split(' ', &get_words($len, $stti));
		    if (length($w[0]) < (8-length($str_len))) { $w[0] .= "\t" }
		    print "$w[0]\t";
		    &prqe_print($states_prq[$len][$stti][$prqi]);
		    if (@w > 1) {
			print " " x length($str_len), $w[1], "\n";
		    }
		} else {
		    print "[NULL]\n";
		}
	    }
	    # get new indices for next iteration
	    $stti_new = $states_prq[$len][$stti][$prqi]{stti};
	    # print "debug: stti = $stti_new\n";
	    $prqi_new = $states_prq[$len][$stti][$prqi]{prqi};
	    # print "debug: prqi = $prqi_new\n";
	    $len = $states_prq[$len][$stti][$prqi]{stgi};
	    # print "debug: stgi = $len\n";
	    $stti = $stti_new;
	    $prqi = $prqi_new;
	    last if ($states_prq[$len][$stti][$prqi] == $prqe_null);
	}
    }

    return @words;
}

#----------------
# bp_dump
# 
# purpose:  provide backpointer table (word lattice) dump.
# returns:  nothing.
#
sub bp_dump {
    my $len = shift;
    my ($l, $stti, $prqi, $w);
    my ($l_prev, $stti_prev, $prqi_prev, $w_prev);
    my ($clp, $c2lp, $chlp, $inslp, $lmlp, $sc);
    my $oldfs;

    print "\nWord Lattice:\n";

    $oldfs = $,; $, = "\t";
    # print header
    print "#", "begin", "end", "word", "", "conf1", "conf2", "lm", "total",
      "prev(index)\n";
    $l = 0;
    while ($l <= $len) {
	print "-------", "-------", "-------", "---------------",
	  "-------", "-------", "-------", "-------", "-------", "-------",
	  "---------------\n";
	for ($stti = 0; $stti < $states_c[$l]; $stti++) {
	    $w = &get_words($l, $stti);
	    if (length($w) < 8) { $w .= "\t"; }
	    for ($prqi = 0; $prqi < $prqi_lim; $prqi++) {
		next if ($states_prq[$l][$stti][$prqi] == $prqe_null);
		# find predecessor info.
		$l_prev = $states_prq[$l][$stti][$prqi]{stgi};
		if ($l_prev >= 0) {
		    $stti_prev = $states_prq[$l][$stti][$prqi]{stti};
		    $prqi_prev = $states_prq[$l][$stti][$prqi]{prqi};
		    $w_prev = &get_words($l_prev, $stti_prev);
		    $w_prev .= "($prqi_prev)";
		    $clp = $states_prq[$l][$stti][$prqi]{csc};
		    $c2lp = $states_prq[$l][$stti][$prqi]{c2sc};
		    $chlp = $states_prq[$l][$stti][$prqi]{chsc};
		    $inslp = $states_prq[$l][$stti][$prqi]{insc};
		    $lmlp = $states_prq[$l][$stti][$prqi]{lmsc};
		    $sc = $states_prq[$l][$stti][$prqi]{sc};
		} else {
		    $w_prev = "[NULL]";
		    $clp = "N/A";
		    $lmlp = "N/A";
		    $sc = "N/A";
		}
		# print line
		print $prqi, $l, $l+1, $w, $clp, $c2lp, $chlp, $inslp, $lmlp, $sc, $w_prev, "\n";
	    }
	}
	$l++;
    }
    $, = $oldfs;
}

#----------------
# prq_init
#
sub prq_init {
    my $len = shift;
    my $stti = shift;
    my $prqi;

    for ($prqi = 0; $prqi < $prqi_lim; $prqi++) {
	$states_prq[$len][$stti][$prqi] = $prqe_null;
    }
}

#----------------
# gprq_init
#
sub gprq_init {
    my $len = shift;
    my $gprqi;

    for ($gprqi = 0; $gprqi < $nbest_lim; $gprqi++) {
	$gprq[$len][$gprqi] = $prqe_null;
	$gprq[$len+1][$gprqi] = $prqe_null;
    }
}

#----------------
# gprq_print
#
sub gprq_print {
    my $len = shift;
    my $gprqi;

    if ($f_stats) { print "\n"; }
    print "  Ranks at Position ", $len-1, ":\n";
    for ($gprqi = 0; $gprqi < $nbest_lim; $gprqi++) {
	print "  $gprqi:\t";
	if ($gprq[$len][$gprqi] != $prqe_null) {
	    print &get_words($len-1, $gprq[$len][$gprqi]{stti}) . "\t";
	    &prqe_print($gprq[$len][$gprqi]);
	} else {
	    print "[NULL]\n";
	}
    }
}

#----------------
# prqe_print
#
sub prqe_print {
    my $r_prqe = shift;
    my $oldfs;
    my $csc = substr($r_prqe->{csc}, 0, 7);
    my $c2sc = substr($r_prqe->{c2sc}, 0, 7);
    my $chsc = substr($r_prqe->{chsc}, 0, 7);
    my $insc = substr($r_prqe->{insc}, 0, 7);
    my $lmsc = substr($r_prqe->{lmsc}, 0, 7);
    my $sc = substr($r_prqe->{sc}, 0, 7);

    $oldfs = $,; $, = "\t";
    print  "[$r_prqe->{stgi} $r_prqe->{stti} $r_prqe->{prqi}]   ",
	   $csc, $c2sc, $chsc, $insc, $lmsc, $sc, "\n";
    $, = $oldfs;
}

#----------------
# prq_push
#
sub prq_push {
    # warn "$prog:  ** prq_push() called **\n";

    my $len = shift;
    my $stti = shift;
    my $r_prqe = shift;
    my ($prqi, $score, $score_last, %prqe_mv, $r_prqe_mv, $r_prqe_old);
    my $prqi_mark = $prqi_lim;
    my $prqi_last = $prqi_lim - 1;

    $score = $r_prqe->{sc};

    # check against last entry in the priority queue.
    if ($states_prq[$len][$stti][$prqi_last] != $prqe_null) {
	$score_last = $states_prq[$len][$stti][$prqi_last]{sc};
	return if ($score <= $score_last);
    }

    for ($prqi = 0; $prqi < $prqi_lim; $prqi++) {
	if ($states_prq[$len][$stti][$prqi] != $prqe_null) {
	    if ($states_prq[$len][$stti][$prqi]{sc} < $score) {
		$prqi_mark = $prqi;
		last;
	    }
	} else {
	    $prqi_mark = $prqi;
	    last;
	}
    }

    if ($prqi_mark < $prqi_lim) {
	# then insert
	$prqe_mv{stti} = $r_prqe->{stti};
	$prqe_mv{prqi} = $r_prqe->{prqi};
	$prqe_mv{stgi} = $r_prqe->{stgi};
	$prqe_mv{csc} = $r_prqe->{csc};
	$prqe_mv{c2sc} = $r_prqe->{c2sc};
	$prqe_mv{chsc} = $r_prqe->{chsc};
	$prqe_mv{insc} = $r_prqe->{insc};
	$prqe_mv{lmsc} = $r_prqe->{lmsc};
	$prqe_mv{sc} = $r_prqe->{sc};
	$r_prqe_mv = \%prqe_mv;
	for ($prqi = $prqi_mark; $prqi < $prqi_lim; $prqi++) {
	    $r_prqe_old = $states_prq[$len][$stti][$prqi];
	    $states_prq[$len][$stti][$prqi] = {};
	    $states_prq[$len][$stti][$prqi] = $r_prqe_mv;
	    $r_prqe_mv = $r_prqe_old;
	    last if ($r_prqe_mv == $prqe_null);
	}
    }
}

#----------------
# gprq_push
#
sub gprq_push {
    my $len = shift;
    my $r_prqe = shift;
    my ($gprqi, $score, %prqe_mv, $r_prqe_mv, $r_prqe_old);
    my $gprqi_mark = $nbest_lim;
    my $gprqi_last = $nbest_lim - 1;

    $score = $r_prqe->{sc};

    if ($gprq[$len][$gprqi_last] != $prqe_null) {
	$score_last = $gprq[$len][$gprqi_last]{sc};
	return if ($score <= $score_last);
    }

    for ($gprqi = 0; $gprqi < $nbest_lim; $gprqi++) {
	if ($gprq[$len][$gprqi] != $prqe_null) {
	    if ($gprq[$len][$gprqi]{sc} < $score) {
		$gprqi_mark = $gprqi;
		last;
	    }
	} else {
	    $gprqi_mark = $gprqi;
	    last;
	}
    }

    if ($gprqi_mark < $nbest_lim) {
	# then insert
	$prqe_mv{stti} = $r_prqe->{stti};
	$prqe_mv{prqi} = $r_prqe->{prqi};
	$prqe_mv{stgi} = $r_prqe->{stgi};
	$prqe_mv{csc} = $r_prqe->{csc};
	$prqe_mv{c2sc} = $r_prqe->{c2sc};
	$prqe_mv{chsc} = $r_prqe->{chsc};
	$prqe_mv{insc} = $r_prqe->{insc};
	$prqe_mv{lmsc} = $r_prqe->{lmsc};
	$prqe_mv{sc} = $r_prqe->{sc};
	$r_prqe_mv = \%prqe_mv;
	for ($gprqi = $gprqi_mark; $gprqi < $nbest_lim; $gprqi++) {
	    $r_prqe_old = $gprq[$len][$gprqi];
	    $gprq[$len][$gprqi] = {};
	    $gprq[$len][$gprqi] = $r_prqe_mv;
	    $r_prqe_mv = $r_prqe_old;
	    last if ($r_prqe_mv == $prqe_null);
	}
    }
}

#----------------
# nbest_dump
#
sub nbest_dump {
    my $len = shift;
    my ($gprqi, @seq);

    print "\nN-Best:\n";

    # &gprq_print($len);		# for debugging

    for ($gprqi = 0; $gprqi < $nbest_lim; $gprqi++) {
	next if ($gprq[$len][$gprqi] == $prqe_null);
	@seq = &backtrace($len, $gprq[$len][$gprqi]{stti},
			  $gprq[$len][$gprqi]{prqi});
	print "$gprqi: @seq  ";
	print "(", $gprq[$len][$gprqi]{csc}, " + ", $gprq[$len][$gprqi]{c2sc},
	      " + ", $gprq[$len][$gprqi]{chsc},
	      " + ", $gprq[$len][$gprqi]{insc},
	      " + ", $gprq[$len][$gprqi]{lmsc},
	      ")\n";
    }
}


#----------------
# spp_log
#
sub spp_log {
    my $msg = shift;
    my $id_pfx = shift;
    my $pfx;

    if ($logdir) {
	if ($id_pfx == 1) {
	    $pfx = "hyp :  ";
	} elsif ($id_pfx == 2) {
	    $pfx = "out>:  ";
	} elsif ($id_pfx == 3) {
	    $pfx = "in <:  ";
	} elsif ($id_pfx == 4) {
	    $pfx = "err :  ";
	} else {
	    $pfx = "";
	}
	chomp($msg);
	print LOGFILE "$pfx$msg\n";
    }
}


#----------------
# states_dump
#
sub states_dump {
    my $stgi_max = shift;
    my ($stgi, $stti, $prqi);
    my (@w, $str_len);

    print "\n", "=" x 64, "\n";
    print "LATTICE STATES:\n\n";
    for ($stgi = 0; $stgi <= $stgi_max; $stgi++) {
	print "Length:  $stgi  ", "-" x 48, "\n";
	for ($stti = 0; $stti < $states_c[$stgi]; $stti++) {
	    for ($prqi = 0; $prqi < $prqi_lim; $prqi++) {
		next if ($states_prq[$stgi][$stti][$prqi] == $prqe_null);
		$str_len = "$stti";
		if (length($str_len) < 2) {
		    $str_len = "  $stti: ";
		} else {
		    $str_len = " $stti: ";
		}
		print $str_len;
		@w = split(' ', &get_words($stgi, $stti));
		if (length($w[0]) < (8-length($str_len))) { $w[0] .= "\t"; }
		print "$w[0]\t";
		&prqe_print($states_prq[$stgi][$stti][$prqi]);
		if (@w > 1) {
		    print " " x length($str_len), $w[1], "\n";
		}
	    }
	}
    }
}


#----------------
# offline_kqml_msg
#
# Ignore everything between (offline t) and (offline nil) except (exit).
#
sub offline_kqml_msg {
    my $msg_in = shift;
    my $logdir_new;

    # Check to see whether to come back online
    if ($msg_in =~ /\(offline\s+(\S+)\)/i) {
	$f_offline = ($1 eq "t") ? 1 : 0;
	# Mark the log file.
	if (!$f_offline) {
	    &spp_log('=' x 24 . " Coming online " . '=' x 24);
	    $f_wasoffline = 1;
	}

    } elsif ($msg_in =~ /:content\s+\(exit/i) {
	print "\n" if ($f_iactive);
	if ($f_start) {
	    # &search_end(); # Finalize search
	    warn "$prog:  ** Warning: search state discarded at exit while offline. **\n";
	    $f_start = 0;
	}
	return 0;

    # Change log directory.
    } elsif ($msg_in =~ /\(chdir\s+\"(\S+)\"/i) {
	$logdir_new = $1;
	$logdir_new =~ s/\"([^\"]*)\"/$1/;
	if ($logdir ne $logdir_new) {
	    close(LOGFILE) if ($logdir);
	    $logdir = $logdir_new;
	    open(LOGFILE, ">$logdir/$fn_log")
		|| do {
		    warn "$prog: ** Unable to open $logdir/$fn_log: $! **\n";
		    $logdir = "";
		};
	}
	if ($logdir) {
	    select(LOGFILE); $| = 1; select(STDOUT);
	    &spp_log($log_header);
	    &spp_log($config);
	}

    } else {
	# simply swallow the message
    }

    return 1;
}


#----------------
# dispatch_kqml_msg
#
sub dispatch_kqml_msg {
    my $msg_in = shift;
    my ($cmd, @words, $tail, $w_hyp, $msg_out);
    my ($sr_i, $sr_start_i, $sr_end_i, $sr_start_wi, $sr_wlen);
    my ($seq_score, $utt_index);
    my $logdir_new;

    # Segment the log file.
    if ($msg_in =~ /:content\s+\(start/i) {
	&spp_log('=' x 64);
    } else {
	&spp_log('-' x 16);
    }
    # log the incoming message
    &spp_log("$msg_in", 3);

    # Change log directory.
    if ($msg_in =~ /\(chdir\s+\"(\S+)\"/i) {
	$logdir_new = $1;
	$logdir_new =~ s/\"([^\"]*)\"/$1/;
	if ($logdir ne $logdir_new) {
	    close(LOGFILE) if ($logdir);
	    $logdir = $logdir_new;
	    open(LOGFILE, ">$logdir/$fn_log")
		|| do {
		    warn "$prog: ** Unable to open $logdir/$fn_log: $! **\n";
		    $logdir = "";
		};
	}
	if ($logdir) {
	    select(LOGFILE); $| = 1; select(STDOUT);
	    &spp_log($log_header);
	    &spp_log($config);
	}

    # Go offline?
    } elsif ($msg_in =~ /\(offline\s+(\S+)\)/i) {
	$f_offline = ($1 eq "t") ? 1 : 0;
	# print "$prog: ** f_offline = $f_offline; param = $1 **\n";
	if ($f_offline) {
	    &spp_log('=' x 24 . " Going offline " . '=' x 24);
	}
	
    # Handle one-word commands.
    } elsif ($msg_in =~ /:content\s+\((start|end|input-end|exit|end-conversation)[^-\w]+/i) {
	# warn "$prog: ** Received command **\n";

	$cmd = $1;
	if ($cmd =~ /^end$/i) {
	    print "\n" if ($f_iactive);
	    if ($f_start) {
		&search_end(); # Finalize search
		$f_start = 0;
	    } else {
		warn "$prog: ** Ignoring \"end\" without \"start\" **\n";
		&spp_log("** Ignoring \"end\" without \"start\" **\n", 4);
	    }

	} elsif ($cmd =~ /^exit$/i) {
	    print "\n" if ($f_iactive);
	    if ($f_start) {
		&search_end();	# Finalize search
		$f_start = 0;
	    }
	    return 0;

	} elsif ($cmd =~ /^start$/i) {
	    if ($f_start) {
		warn "$prog: ** Received \"start\" during utterance; Inserting \"end\" **\n";
		&spp_log("** Received \"start\" during utterance; Inserting \"end\" **\n", 4);
		&search_end();	# Finalize search
	    }
	    $f_start = 1;	# set start flag
	    $n_utt++;		# up the utterance counter
	    &send_msg("(tell :content (start :uttnum $n_utt))\n");
	    &search_init();	# Prepare for search

	} else {
	    # swallow the message and bail out.
	    # currently swallowed: "input-end", "end-conversation".
	    return 1;
	}

    # Handle start of conversation.
    } elsif ($msg_in =~ /:content\s+\(start-conversation(.*)$/i) {
	if ($f_start) {
	    warn "$prog: ** Received \"start-conversation\" during utterance; Inserting \"end\" **\n";
	    &spp_log("** Received \"start-conversation\" during utterance; Inserting \"end\" **\n", 4);
	    &search_end();	# Finalize search
	}
	$n_utt = 0;		# reset the utterance counter

	$tail = $1;
	if ($tail =~ /\s+:name\s+\"([^\"]*)\"/i) {
	    $user_name = $1;
	}
	if ($tail =~ /\s+:lang\s+\"([^\"]*)\"/i) {
	    $user_lang = $1;
	}
	if ($tail =~ /\s+:sex\s+\"([^\"]*)\"/i) {
	    $user_sex = $1;
	}

    # Handle new word hypotheses.
    } elsif ($msg_in =~ /:content\s+\(word\s+\"([^\"]*)\"(.*)$/i) {
	# warn "$prog: ** Received word(s) **\n";

	if (!$f_start) {
	    warn "$prog: ** Received word(s) without \"start\"; Inserting \"start\" **\n";
	    &spp_log("** Received word(s) without \"start\"; Inserting \"start\" **\n", 4);
	    &spp_log('=' x 64);
	    $f_start = 1;	# set start flag
	    $n_utt++;		# up the utterance counter
	    &send_msg("(tell :content (start :uttnum $n_utt))\n");
	    &search_init();	# Prepare for search
	}

	@words = split('\s', $1);
	if (! @words) {
	    # swallow the message and bail out
	    return 1;
	}

	$tail = $2;
	if ($tail =~ /\s+:index\s+((\d+)|\((\d+)\s+(\d+)\))/i) {
	    # ignore $1, the whole index argument.
	    $sr_i = $2;
	    # OR
	    $sr_start_i = $3;
	    $sr_end_i = $4;
	}
	if (!$sr_start_i && !$sr_i) {
	    $sr_i = @sr_seq_hyp + 1;
	}
	if (!$sr_start_i && $sr_i) {
	    $sr_start_i = $sr_i;
	    $sr_end_i = $sr_i + &count_parser_words(@words);
	}
	# at this point, $sr_start_i & $sr_end_i are certainly defined.
	# warn "$prog: ** Start = $sr_start_i; End = $sr_end_i **\n";

	if ($tail =~ /\s+:score\s+(\d+)/i) {
	    $seq_score = $1;
	}
	if ($tail =~ /\s+:uttnum\s+(\d+)/i) {
	    $utt_index = $1;
	    if ($utt_index != $n_utt) {
		if ($f_wasoffline) {
		    $f_wasoffline = 0;
		    # reset the utterance counter
		    $n_utt = $utt_index;
		    &spp_log("** Resetting utt count: a few utts were missed while offline **\n", 4);
		} else {
		    warn "$prog: ** Utt. counts unequal **\n";
		    &spp_log("** Utt. counts unequal **\n", 4);
		}
	    }
	}

	# this assumes that words previously reported for
	#   position $sr_start_wi need not already be explicityly backto'd,
	#   but can be replaced by reusing the index.
	$sr_start_wi = $sr_start_i;

	my $pr_i = &pr_cur_i;
	if (($sr_seq_hyp_i[$sr_start_wi] < $pr_i) && ($pr_i > 0)) {
	    # we have to back up first.
	    &backup($sr_start_wi);
	}

	$sr_seq_hyp_i[$sr_start_wi] = &pr_cur_i;

	# Parser treats compound words, contractions, and possessives
	#   as separate words, whereas we treat them as one.
	#   We have to keep track of this correspondence.
	$sra_seq_hyp_i[$sr_start_wi] = $#sr_seq_hyp;

	foreach $w_hyp (@words) {
	    $sr_wlen = &count_parser_words(($w_hyp));
	    &process_word($w_hyp, $n_utt, $sr_start_wi, $sr_wlen, $seq_score);
	    push(@sr_seq_hyp, $w_hyp);

	    # SR treats silences as words, whereas we ignore them.
	    #   We have to keep track of this difference of opinion.
	    $sr_start_wi += $sr_wlen;
	    $sr_seq_hyp_i[$sr_start_wi] = &pr_cur_i;
	    $sra_seq_hyp_i[$sr_start_wi] = $#sr_seq_hyp;
	}

	# Assertion:
	if ($sr_start_wi != $sr_end_i) {
	    warn "$prog: ** Word counts unequal **\n";
	    &spp_log("** Word counts unequal **\n", 4);
	}

    # Handle hypothesis back-ups.
    } elsif ($msg_in =~ /:content\s+\(backto(.*)$/i) {
	# backto means "everything to inter-word index n"
	# warn "$prog: ** Received backto **\n";

	if (!$f_start) {
	    warn "$prog: ** Ignoring \"backto\" without \"start\" **\n";
	    &spp_log("** Ignoring \"backto\" without \"start\" **\n", 4);
	    return 1;
	}

	$tail = $1;
	if ($tail =~ /\s+:index\s+(\d+)/i) {
	    if (&backup($1)) {
		# update the parser
		&update_out($#seq_hyp, 0, $n_utt);
	    }
	}
	# else swallow the message and do nothing

    # Ignore unprocessed messages.
    } else {
	$msg_in =~ /\(\s*([^\s\)]+)\s*/i;
	warn "$prog: ** Unrecognized message ignored: **\n";
	warn "$prog:    $msg_in";
	# don't need whole msg in log, since it already went there.
	&spp_log("** Unrecognized \"$1\" message ignored. **\n", 4);
    }

    return 1;
}


sub backup {
    my $sr_base = shift;
    my $pr_base = $sr_seq_hyp_i[$sr_base];
    my $pp_base = $pr_seq_hyp_i[$pr_base];
    my $pp_max = $#seq_hyp;
    my $sra_base = $sra_seq_hyp_i[$sr_base];
    my $sra_max = $#sr_seq_hyp;
    my ($pp_delta, $sra_delta, $i);

    # for debugging back up
#     print "# backup details:\n";
#     print "# sr_seq_hyp: @sr_seq_hyp[0..$sra_base] ($sra_base)\n";
#     print "# sr_seq_hyp_i: @sr_seq_hyp_i ($sr_base)\n";
#     print "# pr_seq_hyp_i: @pr_seq_hyp_i ($pr_base)\n";
#     print "# seq_hyp: @seq_hyp[0..$pp_base] ($pp_base)\n";
#     print "# sra_seq_hyp_i: @sra_seq_hyp_i ($sr_base)\n";

    if (defined $pp_base) {
	$pp_delta = $pp_max - $pp_base + 1;
	$sra_delta = $sra_max - $sra_base + 1;
    } else {
	warn "$prog: ** backto unreached index $pp_base **\n";
	$pp_delta = 0;
	$sra_delta = 0;
    }

    if ($pp_delta > 0) {
	# print "# backing up ", $pp_delta-1, " steps\n";
	for ($i = $pp_base; $i < $pp_max; $i++) {
	    # pop'ing @seq_hyp backs up the entire search by one word.
	    pop(@seq_hyp);
	}
	# truncate the index arraytoo
	$#pr_seq_hyp_i = $pr_base;

	for ($i = $sra_base; $i < $sra_max; $i++) {
	    pop(@sr_seq_hyp);
	}
	# truncate the index arrays too
	$#sr_seq_hyp_i = $sr_base;
	$#sra_seq_hyp_i = $sr_base;
    }

    return $pp_delta;
}


sub send_msg {
    my $msg = shift;

    if ($f_stats && $f_trains) { print "MSG: "; }
    print STDOUT $msg;
    &spp_log($msg, 2);
}


sub process_word {
    my $w_hyp = shift;
    my $n_utt = shift;
    my $sr_start_wi = shift;
    my $sr_wlen = shift;
    my $w_score = shift;
    my $i;

    $w_hyp =~ tr/a-z/A-Z/;
    $w_hyp =~ tr/\s//d;
    if ($w_hyp =~ m:</S>:) {
	return 0;		# last
    }
    if ($w_hyp =~ /<SIL>/) {
	$f_silence = 1;
	&spp_log("      Silence noted:  blocking 1->X (X>1) fertility");
	return 1;		# continue
    }

    if (($w_hyp !~ m/<S>/) && ($w_hyp !~ m/^$/)) {
	if ($f_trains) {
	    # Augment the current "hypothesis" sequence.
	    $pr_seq_hyp_i[$sr_seq_hyp_i[$sr_start_wi]] = $#seq_hyp;
	    push(@seq_hyp, $w_hyp);
	    $sr_end_wi = $sr_start_wi + $sr_wlen;
	    for ($i = $sr_seq_hyp_i[$sr_start_wi]+1; $i <= $sr_end_wi; $i++) {
		# Parser treats compound words, contractions, and possessives
		#   as separate words, whereas we treat them as one.
		#   We have to keep track of this correspondence.
		$pr_seq_hyp_i[$i] = $#seq_hyp;
	    }
	} else {
	    push(@seq_hyp, $w_hyp);
	}

	if ($f_stats) { print "H: @seq_hyp"; }
	# if the hyp word was never seen, then assume it is a reference word
	#   that was never confused.
	&newrefword($w_hyp) unless exists $refwords{$w_hyp};
	if ($f_stats) { print "\n"; }
	&advance_search($w_hyp, $seq_hyp[$#seq_hyp-1], ($#seq_hyp-1), 0);
	# update the parser.
	&update_out($#seq_hyp-1, 0, $n_utt);
	# reset silence flag.
	$f_silence = 0;
    }

    return 1;
}


sub update_out {
    my $len = shift;
    my $f_end = shift;
    my $n_utt = shift;
    my @seq;
    my $stgi = $len + 1;
    my $oldfs;

    if ($f_stats && $f_verbose) {
	print "######## Trace:\n";
	$oldfs = $,; $, = "\t";
	print "#    word(s)", "[stg stt prq]", "c", "c1->2", "c2->1", "c0->1",
           "lm", "total\n";
	$, = $oldfs;
    }

    if ($stgi - $gprq[$stgi][0]{stgi} > 1) {
	if ($f_stats && $f_verbose) {
	    print "# Top candidate skips stage ", $stgi - 1, ".\n";
	}
	@seq = @seq_last;
    } else {
	@seq = &backtrace($stgi, $gprq[$stgi][0]{stti}, $gprq[$stgi][0]{prqi});
	@seq_last = @seq;
    }

    if ($f_stats && $f_verbose) {
	print "########:\n";
    }

    if ($f_trains) {
	shift(@seq);		# get rid of initial <s>
	if ($f_end) {
	    pop(@seq);		# get rid of final </s>
	}
	&spp_log("@seq\n", 1);
	@seq_ref = &seq_diff(\@seq, \@seq_ref, $n_utt);
	if ($f_end) {
	    &send_msg("(tell :content (end :uttnum $n_utt))\n");
	}
    } else {
	if ($f_iactive || $f_stats) {
	    &clearline unless $f_stats;
	    print "R: @seq";
	} elsif ($f_end) {
	    print "@seq";
	}
	&spp_log("@seq\n", 2);
    }
    if ($f_stats && (! $f_trains)) {
	print "\n";
	print "S: (", $gprq[$len][0]{csc}, " + ", $gprq[$len][0]{c2sc},
	      " + ", $gprq[$len][0]{chsc},
	      " + ", $gprq[$len][0]{insc},
	      " + ", $gprq[$len][0]{lmsc},
	      ")\n";
    }
}


#----------------
# seq_diff
#
# Assumes &backtrace was called first, to set @seq_scores.
#
sub seq_diff {
    my $r_newseq = shift;
    my @newseq = @{$r_newseq};
    my $r_oldseq = shift;
    my @oldseq = @{$r_oldseq};
    my $n_utt = shift;
    my ($i, $j);
    my ($pp_base, $pr_base, @ch, $w_index, $w, $lscore, $score);
    my ($pr_starti, $pr_endi);

    # warn "$prog: ** \"@oldseq\" vs. \"@newseq\" **\n";

    # 1. find point of difference
    for ($i = 0; ($i <= $#newseq) && ($i <= $#oldseq); $i++) {
	last if ($newseq[$i] ne $oldseq[$i]);
    }
    $pp_base = $i;
    $pr_base = &count_parser_words(@oldseq[0..($pp_base-1)]) + 1;
    if ($pr_base < 1) { $pr_base = 1; }

    if ($pp_base <= $#oldseq) {
	# 2. tell parser where to back up to.
	# backto means "everything to inter-word index n"
	&send_msg("(tell :content (backto :index $pr_base :uttnum $n_utt))\n");
	$#oldseq = $pp_base-1;	# truncate @oldseq.
    }

    if ($pp_base <= $#newseq) {
	# 3. tell parser about new words
	$pr_starti = $pr_base;
	for ($i = $pp_base; $i <= $#newseq; $i++) {
	    $w = $newseq[$i];
	    $lscore = $seq_scores[$i+1] - $seq_scores[$i];
	    $score = sprintf("%.4g", exp($lscore));
	    $pr_endi = $pr_starti + &count_parser_words(@newseq[$i]);
	    &send_msg("(tell :content (word \"$w\" :index ($pr_starti $pr_endi) :score $score :uttnum $n_utt))\n");
	    $oldseq[$i] = $newseq[$i];
	    $pr_starti = $pr_endi;
	}
	$#oldseq = $#newseq;	# Is this necessary?
    }

    # warn "$prog: ** \"@oldseq\" vs. \"@newseq\" **\n";
    return @oldseq;
}


sub count_parser_words {
    my @seq = @_;
    my ($wd_str, @wds, $w, @ch);
    my $w_count = $#seq + 1;	# counts word boundaries, not words.
    
    foreach $wd_str (@seq) {
	@wds = split(' ', $wd_str); # each member of @seq may be multiple words
	$w_count += $#wds;
	foreach $w (@wds) {
	    @ch = split(/ */, $w); # split into chars.
	    for ($i = 0; $i < @ch; $i++) {
		if ($ch[$i] =~ m/(\'|_)/) {
		    $w_count++;
		}
	    }
	}
    }

    return $w_count;
}


sub get_word {
    my $stgi = shift;
    my $stti = shift;
    my $w;

    if ($states_bd[$stgi][$stti]) {
	$w = $states_w[$stgi][$stti][1];
    } else {
	$w = $states_w[$stgi][$stti];
    }

    return $w;
}

sub get_word_b1 {
    my $stgi = shift;
    my $stti = shift;
    my $prqi = shift;
    my ($w, $stti_prev, $stgi_prev);

    if ($states_bd[$stgi][$stti]) {
	$w = $states_w[$stgi][$stti][0];
    } else {
	$stti_prev = $states_prq[$stgi][$stti][$prqi]{stti};
	$stgi_prev = $states_prq[$stgi][$stti][$prqi]{stgi};
	if ($stgi_prev >= 0) {
	    $w = &get_word($stgi_prev, $stti_prev);
	} else {
	    $w = 0;
	}
    }

    return $w;
}

sub get_words {
    my $stgi = shift;
    my $stti = shift;
    my $w;

    if ($states_bd[$stgi][$stti]) {
	$w = $states_w[$stgi][$stti][0] . " " . $states_w[$stgi][$stti][1];
    } else {
	$w = $states_w[$stgi][$stti];
    }

    return $w;
}

sub pr_cur_i {
    return (&count_parser_words(@seq_hyp[1..$#seq_hyp]) + 1);
}


#================================================================
# Unused
#================================================================

#----------------
# nbest_init
#
sub nbest_init {
    $nbest_list{head} = $ll_null;
    $nbest_list{length} = 0;
}

#----------------
# nbest_insert
#
sub nbest_insert {
    my $len = shift;
    my $stti = shift;
    my $prqi = shift;
    my $score = $states_prq[$len][$stti][$prqi]{sc};
    my (%nle, $r_nle, $r_nle_cur);

    if ($nbest_list{head} == $ll_null) {
	$nle{len} = $len;
	$nle{stti} = $stti;
	$nle{prqi} = $prqi;
	$nle{prev} = $ll_null;
	$nle{next} = $ll_null;
	$r_nle = \%nle;
	$nbest_list{head} = $r_nle;
	$nbest_list{length} = 1;
    } else {
	for ($r_nle_cur = $nbest_list{head};
	     $r_nle_cur != $ll_null;
	     $r_nle_cur = $r_nle_cur->{next}) {
	    if ($score > $states_prq[$r_nle_cur->{len}][$r_nle_cur->{stti}][$r_nle_cur->{prqi}]{sc}) {
		# set up new nbest_list entry.
		$nle{len} = $len;
		$nle{stti} = $stti;
		$nle{prqi} = $prqi;
		$nle{prev} = $r_nle_cur->{prev};
		$nle{next} = $r_nle_cur;
		$r_nle = \$nle;	# get reference
		# change prev pointer on current entry
		$r_nle_cur->{prev} = $r_nle;
		# change next pointer on previous entry
		if ($nle{prev} != $ll_null) {
		    $nle{prev}{next} = $r_nle;
		}
		$nbest_list{length}++;
		last;
	    }
	}
    }
}

#----------------
# nbest_first
#
sub nbest_first {
    $r_nle_mark = $nbest_list{head};
    return ($r_nle_mark->{len}, $r_nle_mark->{stti}, $r_nle_mark->{prqi});
}

#----------------
# nbest_next
#
sub nbest_next {
    $r_nle_mark = $r_nle_mark->{next};
    return ($r_nle_mark->{len}, $r_nle_mark->{stti}, $r_nle_mark->{prqi});
}

# Local Variables:
# mode: perl
# End:
