#!/usr/local/bin/perl5
#
# pview - Parse Tree Viewer
#
# From Emacs:
my $timestamp = "Time-stamp: <Mon Jan 20 14:55:30 EST 1997 ferguson>";
#
# From RCS:
my $rcs_hdr = '$Header: /u/ringger/research/trains/pview/RCS/pview,v 1.3 1996/08/12 18:43:28 ringger Exp ringger $ ';
#
# History:
#   96 Mar 18  ringger - sexp2tree created.
#   96 May 24  ringger - Added Tk stuff.  Renamed to pview.  Integrated with
#                        Trains-96.
#   96 Jun 17  ringger - Added better KQML parsing.
#   96 Aug 09  ringger - Fixed multiple-tree overstrike bug.
#   96 Aug 12  ringger - Fixed scrollbars.  Requires fixed-size canvas for now.
#   96 Aug 12  ringger - Added tree-node highlighting.  Prelude to Inspection.
#
# To Do: !!
#   - Implement ability to inspect nodes.
#   - Improve constituent width measurement.
#   - Dynamically size the canvas.
#

BEGIN {
    # just use basename of program, rather than whole path.
    @prog = split('/', $0); $prog = pop(@prog);
    
    $TRAINS_BASE_DEFAULT = "/u/trains/96/2.2";
    if ($prog eq "tpview") {
	if (!($TRAINS_BASE = $ENV{"TRAINS_BASE"})) {
	    $TRAINS_BASE = $TRAINS_BASE_DEFAULT;
	}
	$LIB = "$TRAINS_BASE/etc/pview";
    } else {
	$LIB = "/u/ringger/research/trains/pview";
    }
    # add to path for loading kqml and tree code
    unshift(@INC, $LIB)
}

require 5.001;
use Tk;
use strict 'refs';
require "kqml.perl";
require "tree.perl";


#================================================================
# Config. Parameters
#================================================================

$| = 1;				# unbuffered output


#------------------------ Constants ------------------------
$timestamp =~ /<([^>]*)\s+ringger>/;
my $time_date = $1;

my $nbuild;
if ($rcs_hdr =~ /,v\s+([\.\d]+)/) {
    $nbuild = "#$1";
} else {
    $nbuild = "";
}
my $startup_msg = "$0: pview 1.0 $nbuild $time_date EST\n";


#------------------------ Globals ------------------------
my $c_parens = 0;
my $msg = "";


#================================================================
# Initialize GUI
#================================================================

my $mw = MainWindow->new();
$mw->title('Trains Parse-Tree Viewer');
$mw->iconify;

# Menubar
my $menu = $mw->Frame (-relief => 'raised', -bd => 2);
$menu->pack (-side => 'top', -fill => 'x');
my $file_menu = $menu->Menubutton (-text => 'File', -underline => 0);
$file_menu->command (-label => 'Get Parse-Tree',
		     -command => \&send_msg);
$file_menu->separator;
$file_menu->command (-label => 'Quit',
		     -command => ['destroy', $mw]);
$file_menu->pack (-side => 'left');

my $top_frame = $mw->Frame(-relief => 'sunken', -bd => 2);
$top_frame->pack (-fill => 'both', -expand => 'yes');

# Set up buttons
my $bottom_frame = $mw->Frame;
$bottom_frame->pack (-side => 'bottom',
		     -fill => 'x',
		     -pady => '2m');
my $msg_button = $bottom_frame->Button (-command => \&send_msg,
					-text => 'Get Parse-Tree');
$msg_button->pack (-side => 'left', -expand => 1);

# set up text
# my $text = $top_frame->Text (-state => 'disabled',
# 			     -height => 60, -width => 100,
# 			     -font => $font, -wrap => 'none');
# Hook up Text with Scrollbars
# my $yscroll = $top_frame->Scrollbar (-command => ['yview', $text]);
# $text->configure (-yscrollcommand => ['set', $yscroll]);
# $yscroll->pack (-side => 'right', -fill => 'y');
# $text->pack (-side => 'left', -fill => 'both', -expand => 'yes');

# set up canvas
my $canv = $top_frame->Canvas (-scrollregion => ['0c', '0c', '50c', '100c']);
# Hook up Canvas with Scrollbars
my $yscroll = $top_frame->Scrollbar (-command => ['yview', $canv]);
my $xscroll = $top_frame->Scrollbar (-command => ['xview', $canv],
				     -orient => 'horiz');
$canv->configure (-yscrollcommand => ['set', $yscroll],
		  -xscrollcommand => ['set', $xscroll]);
$yscroll->pack (-side => 'right', -fill => 'y');
$xscroll->pack (-side => 'bottom', -fill => 'x');
$canv->pack (-expand => 'yes', -fill => 'both');

# Let button-2 scroll the region
$canv->Tk::bind('<2>' => sub {
    my $e = $canv->XEvent;
    $canv->scan('mark', $e->x, $e->y);
});
$canv->Tk::bind('<B2-Motion>' => sub {
    my $e = $canv->XEvent;
    $canv->scan('dragto', $e->x, $e->y);
});

# Attach events to text entities
my $old_fill = "";
$canv->bind('text', '<Any-Enter>' => [\&cscroll_enter, \$old_fill]);
$canv->bind('text', '<Any-Leave>' => [\&cscroll_leave, \$old_fill]);

# Accept input from stdin only:
$mw->fileevent(STDIN, 'readable' => \&get_text);


#------------------------ Negotiate with Trains-96 IM ------------------------
warn $startup_msg;

# registration is automatic when using run script.
# print STDOUT "(register :receiver im :name pview)\n";

#print STDOUT "(request :receiver im :content (listen parser))\n";
print STDOUT "(tell :receiver im :content (ready))\n";


#------------------------ Event loop ------------------------
MainLoop;


#================================================================
# Sub-routines
#================================================================

#----------------
# get_text
#
# globals affected: $c_parens, $msg
#
sub get_text {
    my $line = <>;
    my @tokens = split('', $line); # split into characters
    my ($ch, $c_open, $c_close);

    if ($line) {
	# $mw->deiconify;

	if ($line !~ /^\s*$/) {
	    foreach $ch (@tokens) {
		if ($ch eq '(') {
		    $c_open++;
		} elsif ($ch eq ')') {
		    $c_close++;
		}
	    }
	    $c_parens += $c_open - $c_close;
	    if ($c_parens > 0) {
		$msg .= $line;
	    } elsif ($c_parens < 0) {
		$msg = "";
		$c_parens = 0;
		warn "$prog: ** badly formatted s-expression **\n";
	    } else {		# $c_parens == 0
		$msg .= $line;
		$r_msg = &parse_kqml($msg);
		# warn "$prog: Dispatching ...\n";
		if (!&dispatch_msg($r_msg, $msg)) {
		    exit 0;	# msg said "exit"
		}
		$msg = "";
	    }
	}
    } else {
	# warn "$prog:  Got EOF.  Quitting.\n";
	exit 0;			# we got EOF
    }

}


#----------------
# dispatch_msg
#
sub dispatch_msg {
    my $r_msg = shift;
    my %ms = %{$r_msg};
    my $msg = shift;

    my ($cmd, $tree, $r_tree, @tokens);
    my $rv = 1;

    # warn "$prog: Entering dispatch_msg()\n";
    # Handle one-word commands.
    if ((exists $ms{content}{type}) && !(exists $ms{content}{default})) {
	# warn "$prog: ** Received command **\n";

	$cmd = $ms{content}{type};

	if ($cmd eq "exit") {
	    $rv = 0;

	} elsif ($cmd eq "show-window") {
	    $mw->deiconify;

	} elsif ($cmd eq "hide-window") {
	    $mw->iconify;

	} elsif (($cmd eq "start-conversation")
		 || ($cmd eq "end-conversation")) {
	    # swallow the message and bail out.
	}

    # Process parse-trees.
    } elsif ($ms{content}{type} eq "parse-tree") {

	$tree = $ms{content}{default};
	# warn "$prog: Working on tree for $tree ...\n";
	$r_tree= &tree_build($tree);
	&add_tree($canv, $r_tree);

    # Ignore certain messages.
    } elsif ($ms{content}{type} eq "chdir") {
	# swallow the message and bail out.

    # Warn about truly unknown messages
    } else {
	warn "$prog: ** Unrecognized \"", $ms{type}, "\" message ignored: **\n";
	warn "$prog:    $msg";
    }

    # warn "$prog: Exiting dispatch_msg()\n";
    return $rv;
}


sub send_msg {

    print "(request :content (parse-tree) :receiver parser)\n";
}


sub cscroll_enter {
    my $c = shift;
    my $r_old_fill = shift;

    my $id = $canv->find('withtag', 'current');
    my $color = ($canv->itemconfigure($id, -fill))[4];

    ${$r_old_fill} = $color;
    $canv->itemconfigure($id, -fill => 'red');
} # end cscroll_enter


sub cscroll_leave {
    my $c = shift;
    my $r_old_fill = shift;

    my $id = $canv->find('withtag', 'current');
    my $color = ${$r_old_fill};

    $canv->itemconfigure($id, -fill => $color);
} # end cscroll_leave

# Local Variables:
# mode: perl
# End:
