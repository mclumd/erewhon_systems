# Overwrites the usual values which are analogy and abstraction.
set special_commands {bayes analogy abstraction}
set special_commands_label {"Bayes" "Analogy" "Abstraction"}

set labels(bayes) {"Improve plan" "Reset plan" "Draw belief net" \
                   "Draw join tree"}
#set commands(bayes) {improvePlan discardPlan drawBeliefNet drawJoinTree }
set commands(bayes) {improvePlan discardPlan showTemporalNet drawJoinTree }
set infotext(bayes) {"Make a plan or improve its probability of success"\
	             "Reset to null plan"\
	             "Draw belief net for plan"\
                     "Draw join tree for belief net"}

# This was called "bayes" in the original jim.tcl - I have added some stuff 
# from runStart to make the plan come up in the canvases.
proc improvePlan {} {
    global lisp lisp_waiting canvasGoalTree canvasAppliedOps 
    global applications applmark operatorfont
    lisp_flush
    set line [lisp_command "(fboundp 'bayes-start)"]
    if {$line != " NIL"} {
	set curprob 0
	$canvasAppliedOps delete all
	set applications []
	set applmark []
	# set *seen* and *used-slots* to nil because we just deleted everthing.
	lisp_blat "(progn (setf user::*seen* nil user::*used-slots* nil) (user::bayes-step :tcl t))"
	$canvasGoalTree delete all
	drawOperator $canvasGoalTree 4 -1 100 10 150 30 {"finish"}
	runLoop
	# Absorb from the puts $lisp above
	set line [gets $lisp]
	set prob [gets $lisp]
	$canvasGoalTree create text 150 25 -text "Global plan belief: $prob" \
		-font $operatorfont -anchor nw
	#puts "improve read prob $prob and line $line\n"
	if {$line == "New net"} {
	    # drawBeliefNet $prob
	    showTemporalNet
	}
    } else {
	mkErrorDialog .error {"The Bayes net code is not loaded"}
    }
}

# The bayes-step lisp command will start again with this variable set like 
# this. 
proc discardPlan {} {
    lisp_flush
    lisp_command "(setf *init* nil)"
}


proc drawBeliefNet {{prob ""}} {
    global dagxmult dagymult idmap nodeid b_id_map lisp_bayes_draw
    set oldxmult $dagxmult
    set oldymult $dagymult
    # Was 0.8 for the old font.
    set dagxmult 1.2
    set dagymult 0.6
    lisp_flush
    catch {unset b_id_map}
    if {$prob != ""} {
	set title "Bayes net for current plan (P(success) = $prob)"
    } else {
	set title "Bayes net for current plan"
    }
#    drawGenericGraph .bayes $title $lisp_bayes_draw\
#	    {{markov-index showMarkovNodeIndices}}\
#	    show_bayes_node
    drawGVDigraph .bayes $title $lisp_bayes_draw \
	    {{markov-index showMarkovNodeIndices}} show_bayes_node
    bind .bayes.f.c <3> show_mc
    .bayes.f.c bind all <Any-Enter> { set bcurid [.bayes.f.c find withtag current] }
    # Save the node map info as well as colour the nodes
    foreach node [array names idmap] {
	set b_id_map($node) $nodeid($idmap($node))
	if {[string index $nodeid($idmap($node)) 0] == "E"} {
	    .bayes.f.c itemconfigure $node -width 2.0 -outline blue
	} elseif {[string index $nodeid($idmap($node)) 0] == "A"} {
	    .bayes.f.c itemconfigure $node -width 2.0 -outline red
	}
	if {[string range $nodeid($idmap($node)) 1 8] == "BRANCH-1"} {
	    .bayes.f.c itemconfigure $node -fill LightGray
	}
    }
    set dagxmult $oldxmult
    set dagymult $oldymult
}

# Creates a window with the probability distribution for the Bayes node.

proc show_bayes_node {} {
    global node_name bcurid b_id_map lisp
    set tags [.bayes.f.c gettags current]
    set node 0
    foreach tag $tags {
	if {[string first node $tag] == 1} {
	    set node [string range $tag 1 end]
	}
    }
    if {$node != 0} { 
	set node_name [string range [$node showname] 2 end]
	lisp_flush
	lisp_blat "(send-bayes-node '$node_name)"
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
	    } else {
		$w.frame.text insert end "$line\n"
		incr lines
		if {[string length $line] > $maxwidth} {set maxwidth [string length $line]}
	    }
	}
	$w.frame.text configure -height $lines -width $maxwidth
	pack $w.frame.text -side left -in $w.frame
    } 
}

# Creates a window with the markov chain underlying the parent link of
# the Bayes node, if one exists.
proc show_mc {} {
    global bcurid b_id_map lisp
    if {$bcurid != "none" && [info exists b_id_map($bcurid)] == 1} {
	set node_name [string range $b_id_map($bcurid) 1 end]
	lisp_flush
	lisp_blat "(send-mc '$node_name)"
	set has_mc [gets $lisp]
	if {$has_mc == 1} {
	    drawGenericGraph .mc "Markov chain for link"\
		    "(weaver::draw-markov-chain '$node_name)" {} {}
	}
    }
}

proc drawJoinTree {} {
  drawGenericGraph .jensen "Jensen join tree for bayes net"\
    "(bayes::draw-join-tree (third user::*plan-net*))" {} show_jtn
}

proc show_jtn {} {}

# Annotate each node in the Bayes net with its index in the Markov net
proc showMarkovNodeIndices {} {
    global idmap nodeid
    puts "Showing"
    lisp_flush
    foreach node [.bayes.f.c find all] {
	if {[info exists idmap($node)] == 1} {
	    set name [string range $nodeid($idmap($node)) 1 end]
	    set index [lisp_command \
		    "(ideal::markov-node-index (ideal::node-pi-msg \
		    (ideal::find-node '$name (second user::*plan-net*))))"]
	    set bbox [.bayes.f.c bbox $node]
	    .bayes.f.c create text [lindex $bbox 0] [lindex $bbox 1]\
		    -text $index -anchor e -tags MarkovIndex
	}   
    }
}


