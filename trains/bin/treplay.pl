#!/usr/imports/bin/perl5
#
# treplay.pl : Module to replay im.log messages
#
# George Ferguson, ferguson@cs.rochester.edu, 15 Jul 1996
# Time-stamp: <Fri Jan 10 16:37:34 EST 1997 ferguson>
#
# usage: treplay [log directory]
#
# Note: Skips messages with :receiver AUDIO to avoid problems with
#       draining during playback, and so forth.
#
# To fix: single step when delaying doesn't get the next delay interval right
#

print STDERR "$0: @(#)treplay.pl 2.0.5 Thu Oct 10 13:37:36 EDT 1996\n";

# Pipes are piping hot
$| = 1;

# For PerlTk
require 5.002;
use English;
use Tk;

$BITMAP_DIR = '/u/trains/96/2.0/etc/replay/bitmaps';
$PLAIN_FONT = '-*-Helvetica-Medium-R-Normal--*-140-*-*-*-*-*-*';
$SMALL_FONT = '-*-Helvetica-Medium-R-Normal--*-100-*-*-*-*-*-*';
$SLANT_FONT = '-*-Helvetica-Medium-O-Normal--*-140-*-*-*-*-*-*';

# Create windows
&initWindow();

# Load directory if given on command-line
if ($#ARGV >= 0) {
    $logdir = $ARGV[0];
    &load_dialogue();
}

# Tell IM we are "ready" (and lie about other modules)
print "(tell :receiver IM :content (ready))\n";
print "(reply :receiver SPEECH-X :content (status speech-in READY))\n";
print "(reply :receiver SPEECH-X :content (status speech-pp READY))\n";

# Off we go...
MainLoop;

# NOTREACHED
exit(0);

##############
# Subroutines

# Loads the dialogue from $logdir
sub load_dialogue {
    # Open im.log (either in logdir or after "archiving" by Eric)
    $imlogfile = "$logdir/im.log";
    $speechdir = $logdir;
    if (!open(IMLOG, "<$imlogfile")) {
	$imlogfile = "$logdir/sys/im.log";
	$speechdir = "$logdir/data";
	if (!open(IMLOG, "<$imlogfile")) {
	    warn("$0: can't find im.log in \"$logdir\"\n");
	    return 0;
	}
    }
    # Snarf entire file into memory
    undef $/;
    $file = <IMLOG>;
    $/ = "\n";
    # Close im.log
    close(IMLOG);
    # Read first line ("log starts") and skip it
    if ($file !~ /^-- (\d\d):(\d\d):(\d\d) \[log starts\]\n\n/) {
	die("$0: couldn't find start of log in $imlogfile\n");
    }
    $file = $';
    # Enable multi-line matching
    $* = 1;
    # Break rest of file into msgs
    undef($num_msgs);
    undef(@msg_type); undef(@msg_from); undef(@msg_time); undef(@msg_text);
    undef($num_utts);
    undef(@utt_start);
    while ($file =~ m/^\S.*\n([ \t].*\n)*/g) {
	$_ = $&;
	# Extract components of message
	my ($type, $from, $h, $m, $s) =
	    m/^(\S)(\S+)\s+(\d+):(\d+):(\d+)\s+/;
	# Skip incoming messages
	next if ($type ne '>');
	# Ok, save the mesage components
	$msg_type[$num_msgs] = $type;
	$msg_from[$num_msgs] = $from;
	$msg_time[$num_msgs] = $h*3600 + $m*60 + $s;
	$msg_text[$num_msgs] = $';
	#print STDERR "type=$type, from=$from, time=" . $msg_time[$num_msgs] . "\n";
	#print STDERR $msg_text[$num_msgs];
	# Additional processing at this point:
	if (/:name \"([^\"]*)\" :lang \"([^\"]*)\" :sex \"([^\"]*)\"/){
	    # Extract user info for display on panel
	    $user_info = "$1 (language=$2, sex=$3)";
	} elsif (!defined($num_utts) && /Welcome to Trains/) {
	    # ^^This decides where the dialogue starts (ie., the 0th utt)
	    $num_utts = 0;
	    $utt_start[0] = $num_msgs;
	} elsif (/request :receiver speech-in :content \(start\)/i ||
		 /tell :content \(word .* :index 1\).*:receiver parser/i) {
	    # ^^This decides where each "real" utt starts
	    $num_utts += 1;
	    $utt_start[$num_utts] = $num_msgs;
	    $utt_delay[$num_utts] =
		$msg_time[$num_msgs] - $msg_time[$num_msgs-1];
	}
	$num_msgs += 1;
    }
    #print STDERR "treplay: $num_msgs messages, $num_utts utterances\n";
    # Display the messages in the text window
    &setMessageText();
    # Initialize globals
    $current_utt = 0;
    $current_msg = 0;
}

# Play from current message in "real time"
sub play {
    &displayUttnum($current_utt);
    my $start_stamp = $msg_time[$current_msg];
    my $start_time = time;
    while ($playing && $current_msg < $num_msgs) {
	# Play speech file if at start of utt
	if ($current_utt > 0 && $current_msg == $utt_start[$current_utt]) {
	    &playSpeechFile($current_utt);
	}
	# Send the message and update the displays
	#print STDERR $current_msg . " @ " . $msg_time[$current_msg] . ": " . $msg_text[$current_msg] . "\n";
	&displayTime($msg_time[$current_msg]);
	&displayMsg($current_msg);
	&sendMsg($current_msg);
	$MW->update();
	# Next message (and possibly next utt)
	$current_msg += 1;
	if ($current_utt < $num_utts &&
	    $current_msg == $utt_start[$current_utt+1]) {
	    $current_utt += 1;
	    &displayUttnum($current_utt);
	}
	# Delay if needed
	if (($log_delta = $msg_time[$current_msg] - $start_stamp) > 0) {
	    local($h,$m,$s) = ($time_info =~ /(\d+):(\d+):(\d+)/);
	    $delaying = 1;
	    while ($delaying && $playing &&
		   ($real_delta = time - $start_time) < $log_delta) {
		# Update countdown timer
		local($secs) = $log_delta - $real_delta;
		$delay_info = sprintf("%02d:%02d", int($secs/60), $secs % 60);
		# Refresh windows (and process events)
		$MW->update();
		# Now wait a sec
		sleep(1);
		# Update timer
		if (++$s >= 60) {
		    $s = 0;
		    if (++$m >= 60) {
			$m = 0;
			$h += 1;
		    }
		}
		$time_info = sprintf("%02d:%02d:%02d", $h, $m, $s);
	    }
	    $delay_info = "";
	}
    }
    $playing = 0;
    # End of dialogue
    if ($current_msg == $num_msgs) {
	$w_play_button->configure(-image => 'play');
    }
}

sub stampToTime {
    local($stamp) = @_;
    local($h,$m,$s) = ($stamp =~ /(\d+):(\d+):(\d+)/);
    $h*60*60 + $m*60 + $s;
}

# Sleep but process events (eg., pause, quit)
sub delay {
    local($secs) = @_;
    local($h,$m,$s) = ($time_info =~ /(\d+):(\d+):(\d+)/);
    $delaying = 1;
    while ($secs && $playing && $delaying) {
	if (++$s >= 60) {
	    $s = 0;
	    if (++$m >= 60) {
		$m = 0;
		$h += 1;
	    }
	}
	$time_info = sprintf("%02d:%02d:%02d", $h, $m, $s);
	$delay_info = sprintf("%02d:%02d", int($secs/60), $secs % 60);
	$MW->update();
	sleep(1);
	$secs -= 1;
    }
    $delaying = 0;
    $delay_info = "";
}

# Plays a speech file by sending a message to SFX module
sub playSpeechFile {
    local($uttnum) = @_;
    my $file = sprintf("%s/utt.%03d.au", $speechdir, $uttnum);
    print "(request :receiver SFX :content (play \"$file\"))\n";
}

# Sends a msg by printing to stdout (some messages need extra work)
sub sendMsg {
    local($msgnum) = @_;
    if ($msg_text[$msgnum] =~ /:content \(start\) :sender speech-x/) {
	print "(request :receiver speech-x :content (set-button))\n";
    } elsif ($msg_text[$msgnum] =~ /:content \(stop\) :sender speech-x/) {
	print "(request :receiver speech-x :content (unset-button))\n";
    } elsif ($msg_text[$msgnum] =~ /:receiver audio/ ||
	     $msg_text[$msgnum] =~ /\(chdir/) {
	# Skip requests which will screw up the playback
	# Skip chdir messages which may reopen various logs
	return 0;
    }
    print $msg_text[$msgnum];
}

#
# PerlTk routines
#
sub initWindow {
    $MW = MainWindow->new;
    $MW->title('TRAINS Replay');
    &initBitmaps();
    &initMenuBar();
    &initLabels();
    &initButtons();
    &initText();
}

sub initMenuBar {
    my $menuBar = $MW->Frame(-relief => 'raised', -borderwidth => 2);
    $menuBar->pack(-side => 'top', -fill => 'x');
    my $menuBar_file = $menuBar->Menubutton(-text      => 'File',
					    -underline => 0,
					    );
    $menuBar_file->command(-label     => 'Quit',
			   -underline => 0,
			   -command   => \&menuQuit,
			   );
    $menuBar_file->pack(-side => 'left');
    my $menuBar_help = $menuBar->Label(-textvariable => \$help_info,
				       -justify => 'right',
				       -font => $SLANT_FONT,
				       );
    $menuBar_help->pack(-side => 'right');
}

sub menuQuit {
    print "(request :receiver IM :content (exit 0))\n";
}

sub initBitmaps {
    foreach $bitmap ('play', 'pause', 'next1', 'next2', 'prev1', 'prev2',
		     'start', 'end', 'play1') {
	$MW->Bitmap($bitmap,
		    -file => "$BITMAP_DIR/$bitmap.xbm",
		    -maskfile => "$BITMAP_DIR/$bitmap.xbm",
		    );
    }
}

sub initLabels {
    my $w_frame = $MW->Frame;
    $w_frame->pack(qw(-fill x));
    my $l = $w_frame->Label(-text => 'Directory:');
    $l->pack(qw(-side left));
    $w_logdir = $w_frame->Entry(-font => $PLAIN_FONT,
				-width => 40,
				-textvariable => \$logdir,
				);
    $w_logdir->pack(qw(-side left));
    $w_logdir->bind('<Return>' => \&load_dialogue);

    $w_frame = $MW->Frame;
    $w_frame->pack(qw(-fill x));
    $l = $w_frame->Label(-text => 'User:');
    $l->pack(qw(-side left));
    $w_user_info = $w_frame->Label(-textvariable => \$user_info,
				   -justify => 'left',
				   -font => $PLAIN_FONT,
				   );
    $w_user_info->pack(qw(-side left));
    $delay_info = "";
    $w_delay = $w_frame->Label(-textvariable => \$delay_info,
			       -justify => 'right',
			       -font => $PLAIN_FONT,
			       );
    $w_delay->pack(qw(-side right));

    $w_frame = $MW->Frame;
    $w_frame->pack(qw(-fill x));
    $l = $w_frame->Label(-text => 'Utterance:');
    $l->pack(qw(-side left));
    $w_uttnum = $w_frame->Label(-textvariable => \$utt_info,
				-justify => 'left',
				-font => $PLAIN_FONT,
				);
    $w_uttnum->pack(qw(-side left));
    $time_info = "00:00:00";
    $w_time = $w_frame->Label(-textvariable => \$time_info,
			      -justify => 'right',
			      -font => $PLAIN_FONT,
			      );
    $w_time->pack(qw(-side right));
    $l = $w_frame->Label(-text => 'Time:');
    $l->pack(qw(-side right));
}

sub initText {
    my $w_frame = $MW->Frame;
    $w_frame->pack(qw(-side bottom -fill x));
    $w_msgtext = $w_frame->Text(-relief => 'sunken',
				-bd => '2',
				-setgrid => 'true',
				-font => $SMALL_FONT,
				-width => 80,
				-height => 25,
				);
    $w_msgscroll = $w_frame->Scrollbar(-command => [$w_msgtext => 'yview']);
    $w_msgtext->configure(-yscrollcommand => [$w_msgscroll => 'set']);
    $w_msgscroll->pack(-side => 'right', -fill => 'y');
    $w_msgtext->pack(-expand => 'yes', -fill => 'both');
    # Set up display tag for highlighting
    $w_msgtext->tag('configure', 'highlight',
		    -background => '#a0b7ce');
}

# Now fill the text widget with the messages
sub setMessageText {
    my $uttnum = 0;
    my $msgnum = 0;
    my $pos = 0;
    undef(@msg_pos);
    undef(@utt_pos);
    $w_msgtext->delete('0.0', 'end');
    for ($msgnum=0; $msgnum <= $num_msgs; $msgnum++) {
	#print "msg $msgnum @ $pos\n";
	$msg_pos[$msgnum] = $pos;
	$w_msgtext->insert('end', $msg_text[$msgnum]);
	$w_msgtext->mark('set', 'insert', 'end');
	$pos += length($msg_text[$msgnum]);
	if ($msgnum+1 == $utt_start[$uttnum]) {
	    $w_msgtext->insert('end', '='x80 . "\n");
	    $w_msgtext->mark('set', 'insert', 'end');
	    $pos += 81;
	    #print "utt $uttnum @ $pos\n";
	    $utt_pos[$uttnum++] = $pos;
	}
    }
}

sub initButtons {
    my $w_frame = $MW->Frame(-relief => 'sunken', -borderwidth => 2);
    $w_frame->pack(qw(-fill x -pady 2m));

    my(@pl) = (-side => 'left', -expand => 'no');

    my $b = $w_frame->Button(-image => 'start', -command => \&buttonStart);
    $b->pack(@pl);
    $b->bind('<Enter>' => sub { $help_info = "Start of dialogue"; });
    $b->bind('<Leave>' => sub { $help_info = ""; });

    $b = $w_frame->Button(-image => 'prev2', -command => \&buttonPrev2);
    $b->pack(@pl);
    $b->bind('<Enter>' => sub { $help_info = "Previous utterance"; });
    $b->bind('<Leave>' => sub { $help_info = ""; });

    $b = $w_frame->Button(-image => 'prev1', -command => \&buttonPrev1);
    $b->pack(@pl);
    $b->bind('<Enter>' => sub { $help_info = "Previous message"; });
    $b->bind('<Leave>' => sub { $help_info = ""; });

    $w_play_button = $w_frame->Button(-image => 'play',
				      -command => \&buttonPlayPause);
    $w_play_button->pack(@pl);
    $w_play_button->bind('<Enter>' => sub { $help_info = "Play/Pause"; });
    $w_play_button->bind('<Leave>' => sub { $help_info = ""; });

    $b = $w_frame->Button(-image => 'next1', -command => \&buttonNext1);
    $b->pack(@pl);
    $b->bind('<Enter>' => sub { $help_info = "Next message"; });
    $b->bind('<Leave>' => sub { $help_info = ""; });

    $b = $w_frame->Button(-image => 'next2', -command => \&buttonNext2);
    $b->pack(@pl);
    $b->bind('<Enter>' => sub { $help_info = "Next utterance"; });
    $b->bind('<Leave>' => sub { $help_info = ""; });

    $b = $w_frame->Button(-image => 'end', -command => \&buttonEnd);
    $b->pack(@pl);
    $b->bind('<Enter>' => sub { $help_info = "End of dialogue"; });
    $b->bind('<Leave>' => sub { $help_info = ""; });
}

#
# Button callbacks
#
sub buttonPlayPause {
    #print STDERR "PLAY/PAUSE\n";
    $playing = !$playing;
    if ($playing) {
	$w_play_button->configure(-image => 'pause');
	&play;
    } else {
	$w_play_button->configure(-image => 'play');
    }
}

sub buttonStart {
    #print STDERR "START DIALOGUE\n";
    # Reset modules that need to be
    print "(request :receiver display :content (restart))\n";
    print "(request :receiver speech-x :content (reset))\n";
    # Reset globals
    $current_msg = 0;
    $current_utt = 0;
    # Reset displays
    &displayUttnum(-1);
    &displayTime($msg_time[0]);
    &displayMsg(0);
    #$w_msgtext->tag('remove', 'highlight', '0.0', 'end');
    #$w_msgtext->see('0.0');
}

sub buttonPrev1 {
    #print STDERR "PREV MSG\n";
    if ($current_msg > 0) {
	$current_msg -= 1;
	&displayMsg($current_msg);
	if ($current_utt != 0 && $current_msg == $utt_start[$current_utt-1]) {
	    $current_utt -= 1;
	    &displayUttnum($current_utt);
	}
	$delaying = 0;
    } else {
	$MW->bell;
    }
}

sub buttonPrev2 {
    #print STDERR "PREV UTT\n";
    if ($current_utt > 0) {
	$current_utt -= 1;
	&displayUttnum($current_utt);
	$current_msg = $utt_start[$current_utt];
	&displayMsg($current_msg);
	$delaying = 0;
	# Have to reset display in order to backup
	print "(request :receiver display :content (restart))\n";
	for ($i=0; $i != $current_msg; $i++) {
	    if ($msg_text[$i] =~ /:receiver display/i) {
		print $msg_text[$i];
	    }
	}
	# Also clear speech-x
	print "(request :receiver speech-x :content (reset))\n";
	print "(request :receiver speech-x :content (unset-button))\n";
    } else {
	$MW->bell;
    }
}

# Next msg unless delaying, in which case just stop delaying
sub buttonNext1 {
    #print STDERR "NEXT MSG\n";
    if ($current_msg < $num_msgs) {
	if (!$delaying) {
	    $current_msg += 1;
	    &displayMsg($current_msg);
	    if ($current_utt != $num_utts &&
		$current_msg == $utt_start[$current_utt+1]) {
		$current_utt += 1;
		&displayUttnum($current_utt);
	    }
	}
	$delaying = 0;
    } else {
	$MW->bell;
    }
}

sub buttonNext2 {
    #print STDERR "NEXT UTT\n";
    if ($current_utt < $num_utts) {
	$current_utt += 1;
	&displayUttnum($current_utt);
	$current_msg = $utt_start[$current_utt];
	&displayMsg($current_msg);
	$delaying = 0;
    } else {
	$MW->bell;
    }
}

sub buttonEnd {
    print STDERR "END DIALOGUE\n";
    # Set globals
    $current_msg = $num_msgs-1;
    $current_utt = $num_utts;
    # Set displays
    &displayUttnum($current_utt);
    &displayTime($msg_time[$current_msg]);
    &displayMsg($current_msg);
}

#
# Display functions
#
sub displayUttnum {
    local($uttnum) = @_;
    if ($uttnum >= 0) {
	$utt_info = sprintf("%03d/%03d", $uttnum, $num_utts);
    } else {
	$utt_info = sprintf("---/%03d", $num_utts);
    }
}

sub displayTime {
    local($time) = @_;
    $time -= $msg_time[0];
    $h = int($time / 3600);
    $m = int(($time % 3600) / 60);
    $s = $time % 60;
    $time_info = sprintf("%02d:%02d:%02d", $h, $m, $s);
}

sub displayMsg {
    local($msgnum) = @_;
    my $start = "0.0+" . $msg_pos[$msgnum] . " chars";
    my $end = ($msgnum == $num_msgs) ? 'end' :
	"0.0+" . $msg_pos[$msgnum+1] . " chars";
    #print "$msgnum: start=$start, end=$end\n";
    $w_msgtext->see($end);
    $w_msgtext->tag('remove', 'highlight', '0.0', 'end');
    $w_msgtext->tag('add', 'highlight', $start, $end);
}

# Local Variables:
# mode: perl
# End:
