#
# Code to draw the output from dot in a canvas. Then a tcl script can
# use dot (or dag) as a filter to draw graphs.
#
# Changed by Jim, May 97, to not overwrite the global variable "nodes". This
# global is also used in the goal tree, so interaction in the goal tree was
# destroyed after viewing any dag.
#
# 19sep97 Changed drawGenericGraph code to call saveCanvasFileBox instead of 
#         directly writing postscript image to disk. [cox]
#


set dagprog $ui_home/dagshell
set dotprog $ui_home/dotshell

# Puts up the dag in a window with buttons buts, as well as a "done"
# button that removes the window and one to dump a postscript file. 
# Each element of the button list is a two-element list {name body}

proc drawGenericGraph {w wtitle lisp_string buts click_command} {
  global dagprog
  lisp_command $lisp_string
  exec $dagprog /tmp/tmp.dag /tmp/tmp.pic
  drawGenericGraphWin $w $wtitle $buts
  display_dag_canv /tmp/tmp.pic $w.f.c
  bind $w.f.c <Button-1> $click_command
}

proc dotGenericGraph {w wtitle lisp_string buts click_command} {
  global dotprog
  lisp_command $lisp_string
  exec $dotprog /tmp/tmp.dot /tmp/tmp.plain
  drawGenericGraphWin $w $wtitle $buts
  display_dot_canv /tmp/tmp.plain $w.f.c
  bind $w.f.c <Button-1> $click_command
}

# Changed to call saveCanvasFileBox instead of directly writing file using
# dag_ps_opts.  Does not, however use the -rotate postscrtipt option any 
# longer. [cox 19sep97]
#
proc drawGenericGraphWin {w wtitle buts} {
  catch {destroy $w}
  global canvasGeneric
  toplevel $w
  wm title $w $wtitle
  wm minsize $w 200 200
  frame $w.buts
  button $w.buts.done -text "Done" -command "destroy $w"
  pack $w.buts.done -in $w.buts -side right -padx 10
  set canvasGeneric $w.f.c
  button $w.buts.postscript -text "Postscript" \
    -command "saveCanvasFileBox genericType"
  pack $w.buts.postscript -in $w.buts -side right -padx 10
  foreach userbut $buts {
    set name [lindex $userbut 0]
    set body [lindex $userbut 1]
    button $w.buts.$name -text $name -command $body
    pack $w.buts.$name -in $w.buts -side right -padx 10
  }
  pack $w.buts -in $w -side top
  frame $w.f -relief sunken -borderwidth 2
  pack $w.f -side bottom -expand yes -fill both
  canvas $w.f.c -scrollregion "-1i -1i 120i 120i"\
    -xscrollcommand "$w.f.hs set" -yscrollcommand "$w.f.vs set" -background white
  scrollbar $w.f.vs -command "$w.f.c yview" -relief sunken
  scrollbar $w.f.hs -orient horiz -command "$w.f.c xview" -relief sunken
  pack $w.f.vs -in $w.f -side right -fill y
  pack $w.f.hs -in $w.f -side bottom -fill x
  pack $w.f.c -in $w.f -expand yes -fill both
}


# Returns the next bit of a string. The index is just before the next
# bit should start.
proc next_part {string index} {
  for {incr index} {[string index $string $index] == " "} {incr index} {
    }
  set first $index
  if {[string index $string $index] == "\""} {
    incr index
    while {[string index $string $index] != "\""} {
      incr index}
    return [list [string range $string [expr $first+1] [expr $index-1]] \
                 [expr $index+1]]
  } else {
    incr index
    while {[string index $string $index] != " "} {incr index}
    return [list [string range $string $first [expr $index-1]] $index]
  }
}

proc generic_display {filename type {w .graphpic} title} {
  global nx ny
  catch {destroy $w}
  toplevel $w
  wm title $w $title
  wm minsize $w 100 100
  frame $w.f -relief sunken -borderwidth 2
  button $w.b -text "Done" -command "destroy $w"
  pack $w.b -side bottom -pady 5
  pack $w.f -side top -expand yes -fill both

  canvas $w.f.c -scrollregion "-1i -1i 30i 30i"\
    -xscrollcommand "$w.f.hs set" -yscrollcommand "$w.f.vs set"
  scrollbar $w.f.vs -command "$w.f.c yview" -relief sunken
  scrollbar $w.f.hs -orient horiz -command "$w.f.c xview" -relief sunken
  pack $w.f.vs -side right -fill y
  pack $w.f.hs -side bottom -fill x
  pack $w.f.c -expand yes -fill both
  if {$type == "dot"} {
    display_dot_canv $filename $w.f.c
  } elseif {$type == "dag"} {
    display_dag_canv $filename $w.f.c}
  # enlarge or shrink canvas as necessary
  
}

proc display_dot {filename {w .dotpic} {title "View of $filename"}} {
  generic_display $filename dot $w $title}

proc display_dag {filename {w .dagpic} {title "View of $filename"}} {
  generic_display $filename dag $w $title}

proc display_dot_canv {filename c} {
    global dotmult dotnodes idmap nx ny nheight nwidth edges graphfont nodeid
    set f [open $filename]
    set line [split [gets $f]]
    if {[lindex $line 0] != "graph"} {
	puts stdout "File $filename does not match dot plain syntax"
	return
    }
    set factor [lindex $line 1]
    set boundx [lindex $line 2]
    set boundy [lindex $line 3]
    foreach var "dotnodes nx ny nheight nwidth edges nodeid idmap" {
	catch "unset $var"
    }
    
    # Should calculate a good bounding box. For now, just use the given size
    # in inches
    #set factor [expr $dotmult*$factor]
    set boundx [expr $dotmult*$boundx]
    set boundy [expr $dotmult*$boundy]
    
    set edgenum 0
    set line [gets $f]
    while {[string range $line 0 3] != "stop"} {
	if {[string range $line 0 3] == "node"} {
	    set bit [next_part $line 4]
	    set name [lindex $bit 0]; set next [lindex $bit 1]
	    set bit [next_part $line $next]
	    scan [string range $line $next end] "%f %f %f %f"\
		    nx($name) ny($name) nwidth($name) nheight($name)
	    # Change y coordinates from dot to tcl
	    set ny($name) [expr $boundy-$ny($name)*$dotmult]
	    set nx($name) [expr $nx($name)*$dotmult]
	    set nwidth($name) [expr $nwidth($name)*$dotmult]
	    set nheight($name) [expr $nheight($name)*$dotmult]
	    for {set i 5} {$i > 0} {incr i -1} {
		set bit [next_part $line $next]
		set next [lindex $bit 1]}
		set nlabel($name) [lindex $bit 0]; set next [lindex $bit 1]
		set nodew [$c create oval \
			          [expr $nx($name)-$nwidth($name)/2]i\
			          [expr $ny($name)-$nheight($name)/2]i\
				  [expr $nx($name)+$nwidth($name)/2]i\
				  [expr $ny($name)+$nheight($name)/2]i\
				  -tags node]
                set idmap($nodew) $name
		$c create text $nx($name)i $ny($name)i\
			-font $graphfont -text "$nlabel($name)"
#		set dotnodes($name) \
#			[list $nodew\
#		              [$c create text $nx($name)i $ny($name)i\
#			          -font $graphfont -text "$nlabel($name)"]]
	    } elseif {[string range $line 0 3] == "edge"} {
		set bit [next_part $line 4]; set next [lindex $bit 1]
		set bit [next_part $line $next]; set next [lindex $bit 1]
		# Find out how many points on the bezier curve
		scan [string range $line $next end] "%d" points
		set pointlist {};
		set command {$c create line};
		set next [lindex [next_part $line $next] 1]
		for {set i $points} {$i > 0} {incr i -1} {
		    scan [string range $line $next end] "%f %f" px py
		    set px [expr $px*$dotmult]; set py [expr $boundy-$py*$dotmult]
		    lappend pointlist [list $px $py]
		    lappend command ${px}i ${py}i
		    set next [lindex [next_part $line $next] 1]
		    set next [lindex [next_part $line $next] 1]
		}
		lappend command -smooth on
		set edges($edgenum) [eval $command]
		incr edgenum
	    }
	    set line [gets $f]
	}
	close $f
    }
    
# Basically the same but reads dag files (restricted PIC format)
# This code is flaky and relies on the nodes being all presented
# before the splines, so the bounding y value is calculated correctly.
# It also uses a global variable so only one dag canvas can really be
# displayed at a time - I need to fix this.
proc display_dag_canv {filename c} {
    # idmap takes widgets to names and nodeid takes names to the external id.
    global dagxmult dagymult nx ny ntype nheight nwidth nlabel edges \
	graphfont idmap nodeid
    set f [open $filename]
    
    foreach var "idmap nx ny ntype nheight nwidth nlabel edges nodeid" {
	catch "unset $var"
    }
    set edgenum 0; set boundy 0
    set count [gets $f line]
    while {$count >= 0} {
	if {[string range $line 0 3] == "Node"} {
	    set name [string range $line 4 [expr [string first ":" $line]-1]]
	    set type\
		[string range $line [expr [string first " " $line]+1]\
		     [expr [string first "(" $line]-1]]
	    if {$type == "Ellipse" || $type == "ellipse"} {
		set ntype($name) oval
	    } elseif {$type == "Box" || $type == "box"} {
		set ntype($name) rectangle
	    }				
	    # Read the label.
	    set start [expr [string first "\"" $line]+1]
	    set end \
		[expr $start+[string first "\"" [string range $line $start end]]+1]
	    set nlabel($name) [string range $line $start [expr $end-2]]
	    # Read the width and height.
	    set start [expr $end+1]
	    set end [expr [string first "," [string range $line $start end]]+$start]
	    set end \
		[expr [string first "," [string range $line [expr $end+1] end]]+$end+1]
	    scan [string range $line $start $end] "%f,%f,"\
		nwidth($name) nheight($name)
	    # Read the dag node name.
	    set start [expr $end+1]
	    set end [expr [string first ")" [string range $line $start end]]+$end]
	    set nodeid($name) [string range $line $start $end]
	    # Read the center coordinates.
	    set start [expr [string first "(" [string range $line $end end]]+$end]
	    scan [string range $line $start end] "(%f,%f);" nx($name) ny($name)
	    # Scale it (a hack).
	    set nx($name) [expr $nx($name)*$dagxmult]
	    set nwidth($name) [expr $nwidth($name)*$dagxmult]
	    set nheight($name) [expr $nheight($name)*$dagymult]
	    set ny($name) [expr $ny($name)*$dagymult]
	    if {[expr $ny($name)+$nheight($name)/2] > $boundy} {
		set boundy [expr $ny($name)+$nheight($name)/2]}
	} elseif {[string range $line 0 5] == "spline"} {
	    set pointlist {};
	    set command {$c create line}
	    if {[string first "dotted" $line] != -1} {
		set dotted 1
	    } else { set dotted 0}
	    set next [string first "(" $line]
	    set isnext 1
	    set endb [string first ")" [string range $line $next end]]
	    set points 0
	    while {$isnext > 0} {
		scan [string range $line $next [expr $next+$endb]] "(%f,%f)" px py
		set px [expr $px*$dagxmult]; set py [expr $boundy-$py*$dagymult]
		lappend pointlist [list $px $py]
		lappend command ${px}i ${py}i
		incr points
		set isnext [string first "(" [string range $line [expr $next+1] end]]
		set next [expr $next+$isnext+1]
		set endb [string first ")" [string range $line $next end]]
	    }
	    lappend command -arrow last
	    # Lines aren't drawn if they are smooth but with only two points
	    if {$points > 2} {lappend command -smooth on}
	    # Green lines for dotted - and why not?
	    if {$dotted == 1} {lappend command -fill green}
	    set edges($edgenum) [eval $command]
	    incr edgenum
	}
	set count [gets $f line]
    }
    close $f
    set bg [lindex [$c config -bg] 4]
    foreach name [array names nx] {
	set ny($name) [expr $boundy-$ny($name)]
	set nodew [$c create $ntype($name)\
		       [expr $nx($name)-$nwidth($name)/2]i\
		       [expr $ny($name)-$nheight($name)/2]i\
		       [expr $nx($name)+$nwidth($name)/2]i\
		       [expr $ny($name)+$nheight($name)/2]i\
		       -fill $bg -tags node]
	$c create text $nx($name)i $ny($name)i\
	    -font $graphfont -text "$nlabel($name)"
	set idmap($nodew) $name
    }
}
