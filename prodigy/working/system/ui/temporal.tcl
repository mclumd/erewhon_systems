# This file draws a temporal Bayes net: each horizontal line
# represents a different variable, and each vertical one a different
# time point.

set bfont -*-Helvetica-Medium-R-Normal--*-120-*-*-*-*-*-*
set nfont -*-Helvetica-Medium-R-Normal--*-100-*-*-*-*-*-*
set dag_ps_opts "-file /tmp/temporal.ps -rotate true \
-pagewidth 10i -pageheight 8i"

# Radius of the bayes node circles
set radius 10
set actionOffset 30

# Controlling the spacing of the temporal bnet
set ygap 30
set txgap 100
set txleft 0

# Function to send information about the belief net
set tempFunc "(weaver::send-temporal-net)"

set eventColor gray

proc showTemporalNet {{w .temp} {title "Temporal Bayes Net"}
		      {lisp_string notSet}} {
    
    global dag_ps_opts lisp bfont tempFunc

    if {$lisp_string == "notSet"} {
	set lisp_string $tempFunc
    }

    # This is like dragGenericGraphWin
    catch {destroy $w}
    toplevel $w
    wm title $w $title
    frame $w.buts
    button $w.buts.done -text "Done" -command "destroy $w" -font $bfont
    pack $w.buts.done -in $w.buts -side right -padx 10
    button $w.buts.postscript -text "Postscript" -font $bfont \
	-command "doPostscript $w.f.c"
    pack $w.buts.postscript -in $w.buts -side right -padx 10
    pack $w.buts -side top
    frame $w.f -relief sunken -borderwidth 2
    pack $w.f -side bottom -expand yes -fill both
    canvas $w.f.c -scrollregion "-1i -1i 120i 120i"\
	-xscrollcommand "$w.f.hs set" -yscrollcommand "$w.f.vs set" -background white
    scrollbar $w.f.vs -command "$w.f.c yview" -relief sunken
    scrollbar $w.f.hs -orient horiz -command "$w.f.c xview" -relief sunken
    pack $w.f.vs -in $w.f -side right -fill y
    pack $w.f.hs -in $w.f -side bottom -fill x
    pack $w.f.c -in $w.f -expand yes -fill both

    # A little hackery to use this at home
    #set lisp [open "/jim/temp.dat"]
    readTemporalNet tnet $lisp_string
    #close $lisp
    drawTemporalNet tnet $w.f.c
}

# Made this a separate function since the bounding box is computed.
proc doPostscript {c} {
    global dag_ps_opts

    set bb [$c bbox all]

    eval "$c postscript -x [lindex $bb 0] -y [lindex $bb 1] \
	-width [expr [lindex $bb 2] - [lindex $bb 0]] \
	-height [expr [lindex $bb 3] - [lindex $bb 1]] \
	$dag_ps_opts"
}
    

# Read a temporal net specification from the lisp process and store it 
# in the variable given.
# The strings from lisp can be of these types:
# "v<i> <name>" says that variable <i> has name <name>
# "e<i1> <t1> <b1> <i2> <t2> <b2> colour" says that there is an edge from 
#   variable i1 at time t1 in branch b1 to variable i2 at t2 in branch b2,
#   that should be drawn with colour colour.
# "a<i> <b> <name>" says the action at time <i> in branch <b> has name <name>.
# "o <list>" says that <list> is the order the variables should be in
# "0" means that the net is complete.
# The net is represented with an array variable, a number key for each
# variable, the "edges" key for all edges, each edge as {n1 t1 n2 t2},
# the "vars" key giving the list of variable numbers used, and the
# "branches" key giving all the branches in the order they are encountered.

proc readTemporalNet {varname lisp_string} {
    global lisp
    upvar \#0 $varname v
    
    lisp_blat $lisp_string
    set line [gets $lisp]
    foreach field {edges vars order branches times} {
      set v($field) ""
    }
    set v(events) ""
    while {$line != "0"} {
	set c [string index $line 0]
	if {$c == "v"} {
	    set space [string first " " $line]
	    set vnum [string range $line 1 [expr $space-1]]
	    set vname [string range $line [expr $space+1] end]
	    # Make sure to get the end of the list.
	    while {[string first ")" $vname] == -1} {
		set vname "$vname [gets $lisp]"
	    }
	    set v($vnum) $vname
	    lappend v(vars) $vnum
	} elseif {$c == "e"} {
	    set list [split [string range $line 1 end]]
	    lappend v(edges) $list
	    foreach branch [list [lindex $list 2] [lindex $list 5]] {
	      if {[lsearch -exact $v(branches) $branch] == -1} {
	        lappend v(branches) $branch
	      }
            }
	    foreach time [list [lindex $list 1] [lindex $list 4]] {
		if {[lsearch -exact $v(times) $time] == -1} {
		    lappend v(times) $time
		}
	    }
	} elseif {$c == "a"} {
	    set space [string first " " $line]
	    set rest [string range $line [expr $space+1] end]
	    set space2 [string first " " $rest]
	    set aname [string range $rest [expr $space2+1] end]
	    set branch [string range $rest 0 [expr $space2-1]]
	    set v(a[string range $line 1 [expr $space-1]],$branch) $aname
	    if {[lsearch -exact $v(branches) $branch] == -1} {
	      lappend v(branches) $branch
	    }
	} elseif {$c == "o"} {
	    set v(order) [split [string range $line 2 end]]
	} elseif {$c == "x"} {
	    lappend v(events) [string range $line 1 end]
        } else {
	    puts "Unparsed line: $line"
        }
	set line [gets $lisp]
    }
    set v(times) [lsort -real $v(times)]
}

set skip 1

# Draw a temporal net given by the array name in the given canvas
proc drawTemporalNet {varname c} {
    global bfont ygap txgap txleft skip
    upvar \#0 $varname v

    $c delete all

    set thisleft $txleft

    # Put a name and a dotted line in for each variable
    set y 10
    if {$v(order) == ""} {set v(order) $v(vars)}
    foreach branch [lsort $v(branches)] {
	set v(nodes,$branch) ""
	foreach var $v(order) {
	    # Only draw lines if the variable is used in this branch.
	    if {[varInBranch $var $branch $varname] == "true"} {
		# In order to make a nice graphic, cut off the text at the 
		# second space
		set first [string first " " $v($var)]
		incr first
		set second \
		    [string first " " [string range $v($var) $first end]]
		if {$second == -1} {
		    set line $v($var)
		} else {
		    set line [string range $v($var) 0 [expr $first + $second]]
		}
		# puts "$v($var): first $first, second $second"
		set t [$c create text 10 $y -anchor w -text $line \
			   -tags "v$var vname" -font $bfont]
		set x2 [lindex [$c bbox $t] 2]
		if {$x2 > $thisleft} {
		    set thisleft $x2
		}
		set v(y${var},$branch) $y
		incr y $ygap
	    }
	}
	$c create line 10 [expr $y - ($ygap/2)] 450 [expr $y - ($ygap/2)]
	set timey $y
    }
    # Shift 'em all over to be right-justified
    $c itemconfigure vname -anchor e
    $c move vname [expr $thisleft - 10] 0
    incr thisleft 20
    foreach edge $v(edges) {
	set v1 [lindex $edge 0]
	set t1 [lindex $edge 1]
	set b1 [lindex $edge 2]
	if {$skip == 1} {
	    set o1 [lsearch -exact $v(times) ${t1}]
	} else {
	    set o1 ${t1}
	}
	set v2 [lindex $edge 3]
	set t2 [lindex $edge 4]
	set b2 [lindex $edge 5]
	if {$skip == 1} {
	    set o2 [lsearch -exact $v(times) ${t2}]
	} else {
	    set o2 ${t2}
	}
	set x1 [expr $thisleft + ($o1 * $txgap)]
	set x2 [expr $thisleft + ($o2 * $txgap)]
	if {[lsearch -exact $v(nodes,$b1) ${v1}-${t1}] == -1} {
	    drawTemporalNode $c $x1 $v1 $t1 $varname $b1 $o1
	    lappend v(nodes,$b2) ${v1}-${t1}
	}
	if {[lsearch -exact $v(nodes,$b2) ${v2}-${t2}] == -1} {
	    drawTemporalNode $c $x2 $v2 $t2 $varname $b2 $o2
	    lappend v(nodes,$b2) ${v2}-${t2} 
	}
	writeTimeStep $c $t1 $x1 $timey
	writeTimeStep $c $t2 $x2 $timey
	drawTemporalArc $c $x1 $v1 $b1 $x2 $v2 $b2 $varname $edge
    }
    # Put all the circles above the arcs, and all text above everything
    $c raise node 
    $c raise actionname
    # Set nodes to display the bayes node beliefs
    bind $c <1> "showNodeBelief $varname"
    # Sets right button to enter the recursive display thingy.
    bind $c <3> "navigateNode $varname"
}

# The "order" is where the node falls in the time order. It's just used
# to stagger the action labels.
proc drawTemporalNode {c x var time tnet branch order} {
    global nfont radius actionOffset eventColor
    upvar #0 $tnet v
    set y $v(y${var},$branch)
    set delta [expr $radius / sqrt(2)]
    set fillColor white
    # Push actions out a little and write their name
    if {[string match *action* [string tolower $v($var)]] == 1} {
        incr x $actionOffset
	set m [expr $order % 3]
	if {$m == 0} {set texty [expr $y - 15]
	} elseif {$m == 1} {set texty $y
	} else {set texty [expr $y + 15]}
	set id [$c create text $x $texty -text $v(a${time},$branch) \
		    -font $nfont -anchor center \
		    -tags "v$var actionname branch$branch time$time"]
	set bb [$c bbox $id]
	$c create rectangle [lindex $bb 0] [lindex $bb 1] \
		[lindex $bb 2] [lindex $bb 3] -fill white -outline "" \
		-tags "v$var actionname background branch$branch time$time" 
	$c raise $id
    } elseif {[lsearch -exact $v(events) $var] != -1} {
	incr x $actionOffset
	set fillColor $eventColor
    }
    $c create oval [expr $x - $delta] [expr $y - $delta] \
       [expr $x + $delta] [expr $y + $delta] \
       -tags "v$var node branch$branch time$time" -fill $fillColor
}

# Assume the destination node is a circle of the given radius and set the end
# node accordingly.
proc drawTemporalArc {c x1 v1 b1 x2 v2 b2 tnet list} {
    global radius actionOffset
    upvar #0 $tnet v
    if {[string match *action* [string tolower $v($v1)]] == 1 || [lsearch -exact $v(events) $v1] != -1} {
	incr x1 $actionOffset
    }
    if {[string match *action* [string tolower $v($v2)]] == 1 || [lsearch -exact $v(events) $v2] != -1} {
	incr x2 $actionOffset
    }
    if {[llength $list] < 7} {
	set colour black
    } else {
	set colour [lindex $list 6]
    }
    # Offset factor is sqrt(r^2 / d^2)
    set y1 $v(y${v1},$b1)
    set y2 $v(y${v2},$b2)
    set dis [expr sqrt((($x1 - $x2) * ($x1 - $x2)) + (($y1 - $y2) * ($y1 - $y2)))]
    if {$dis == 0} {
	set theta 0
    } else {
	set theta [expr $radius / $dis]
    }
    $c create line $x1 $y1 \
	[expr ($theta * $x1) + ((1 - $theta) * $x2)] \
	[expr ($theta * $y1) + ((1 - $theta) * $y2)] \
	-tags "v$v1 $v2 arc branch$b1 branch$b2" \
	-fill $colour -arrow last
}


proc writeTimeStep {c time x y} {
    global bfont
    if {[$c find withtag timelabel$time] == ""} {
	$c create text $x $y -text [string range $time 0 5] -anchor n \
	    -font $bfont -tags timelabel$time
    }
}


# Very similar to show_bayes_node in bayes.tcl. The main difference is
# the code to access the node.
proc showNodeBelief {tnet} {
    global node_name b_id_map lisp
    set tags [.temp.f.c gettags current]
    set node 0
    if {[lsearch -exact $tags node] != -1 || [lsearch -exact $tags actionname] == 1} {
	upvar #0 $tnet tn
	foreach tag $tags {
	    foreach field {v branch time} {
		if {[string first $field $tag] != -1} {
		    set $field [string range $tag [string length $field] end]
		}
	    }
	}
	lisp_flush
	lisp_blat "(send-node-from-name-time-branch '$tn($v) $time '$branch)"
	set node_name [gets $lisp]
	set w .bayesinfo
	if {[winfo exists $w] == 0} {
	    set colour LightSteelBlue
	    toplevel $w -background $colour
	    wm geometry $w +700+55
	    frame $w.frame -borderwidth 10 -background $colour
	    frame $w.buts
	    pack $w.frame -side top
	    pack $w.buts -side bottom
	    text $w.frame.text -relief sunken -borderwidth 2 -background white \
		-font -adobe-helvetica-bold-r-*-*-16-*-*-*-*-*-*-*
	    button $w.buts.ok -text Ok -command {wm withdraw .bayesinfo 
		destroy .bayesinfo} -background $colour
	    pack $w.buts.ok
	} else {
	    $w.frame.text delete 0.0 end
	}
	wm title $w $node_name
	set lines 0
	set maxwidth 0
	for {set readlines 1} {$readlines == 1} {} {
	    set line [gets $lisp]
	    if {$line == " 0"} {
		set readlines 0
	    } elseif {$line == ""} {
		# This happens because of a newline in the title.
	    } else {
		$w.frame.text insert end "$line\n"
		incr lines
		if {[string length $line] > $maxwidth} {
		    set maxwidth [string length $line]
		}
	    }
	}
	$w.frame.text configure -height $lines -width [expr $maxwidth+2]
	pack $w.frame.text -side left -in $w.frame
	raise $w
    } 
}

proc navigateNode {tnet} {
    global node_name b_id_map lisp globCounter
    set tags [.temp.f.c gettags current]
    set node 0
    if {[lsearch -exact $tags node] != -1 || [lsearch -exact $tags actionname] == 1} {
	upvar #0 $tnet tn
	foreach tag $tags {
	    foreach field {v branch time} {
		if {[string first $field $tag] != -1} {
		    set $field [string range $tag [string length $field] end]
		}
	    }
	}
	set accessor "find-node-from-name-time-branch '$tn($v) $time '$branch "
	lisp_flush
	lisp_blat "(compute-expression-4-tcl ( $accessor ))"
	gets $lisp line
	# Add root expression for navigation
	set data [lreplace $line 0 0 $accessor]
	lisp_object_dialog tempvar$globCounter .lispobj$globCounter\
	    "Weaver node $tn($v) $time $branch" $data \
	    "OK" "destroy .lispobj$globCounter"
	incr globCounter
    }
}



# Find out if the variable has any nodes in this branch
proc varInBranch {var branch varname} {

    upvar \#0 $varname v

    foreach edge $v(edges) {
	if {([lindex $edge 0] == $var && [lindex $edge 2] == $branch) ||
	    ([lindex $edge 3] == $var && [lindex $edge 5] == $branch)} {
	    return true
	}
    }
    return false
}
