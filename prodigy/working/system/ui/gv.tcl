#
# This code replaces dot.tcl using the graph drawing primitives in tkdot
# rather than calling dot as an external function. The idea is to provide
# a more flexible and more interactive system.
#
# Jim, August 96
#

# In dot.tcl, the lisp command resulted in a dag file being written
# that was read in and interpreted. Here the command should lead to a
# new graph being defined in graphviz. drawGViz allocates the new
# graph and interprets lines gotten from lisp as creating new
# nodes. When it completes, the graph is rendered.

# wingraph is an array that maps windows to graphs, so you can manipulate 
# them later.

proc drawGVDigraph { w wtitle lisp_string buts click_command } {
    drawGViz $w $wtitle $lisp_string digraphstrict $buts $click_command
}

proc drawGViz { w wtitle lisp_string graphtype buts click_command } {
    global lisp wingraph

    # initialise the graph
    set graph [dotnew $graphtype]
    set wingraph($w) $graph

    # Issue the command and read in the graph
    lisp_blat $lisp_string
    set line [gets $lisp]
    while {$line != "0"} {
	eval "$graph $line"
	set line [gets $lisp]
    }

    # set up the canvas
    drawGenericGraphWin $w $wtitle $buts

    # Draw the graph in the canvas
    set c $w.f.c
    $graph layout
    eval [$graph render]

    bind $w.f.c <Button-1> $click_command
}
