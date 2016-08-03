# This file overloads the runLoop procedure so that it handles monitors.





#Added clause in runLoop to handle sentinels
proc runLoop {} {
    global run_ended no_more_input
    global multstep_win_open planning_mode
    global canvasGoalTree
    global no_solution mainWindow
    global stepping canvasGoalTree canvasAppliedOps lisp basefont\
	    active_buttons active_menus in_run lisp_waiting prodigyIDnums
    global OperatorTextColour InferenceTextColour AppTextColour
    
    update idletasks
    set run_suspended 0
    set run_ended 0
    set in_run 1
    set line [gets $lisp]

    #Activate postscript dumps of either canvas from file menu.
    $mainWindow.mbar.file.menu entryconfigure 3 -state normal
    $mainWindow.mbar.file.menu entryconfigure 4 -state normal

    #Deactivate nodes in goal tree canvas so user cannot choke interface 
    #during planning. [cox 15jan97]
    $canvasGoalTree bind node <Any-Enter> {}
    $canvasGoalTree bind text <Any-Enter> {}
    $canvasGoalTree bind node <Any-Leave> {}
    $canvasGoalTree bind text <Any-Leave> {}
    $canvasGoalTree bind node <Button>  {}
    $canvasGoalTree bind text <Button>  {}

    #Activate view current state function in View pull-down menu
    [lindex $active_menus(viewcurrentstate) 0] entryconfigure \
	    [lindex $active_menus(viewcurrentstate) 1] -state normal

#    puts "Entering runloop (line ->$line<-)\n"
#    while {$line == "hi"} {
#	set line [gets $lisp ]
#	puts "Another line (line ->$line<-)\n"
#	update
#    }

    while {$run_suspended == 0  && $line != " :CONT"} {
	if {[string range $line [expr [string length $line] - 1] end] == "E"} {
	    set run_suspended 1
	    set run_ended 1
	}
	# Handle delete requests
	if {[string range $line 0 5] == "delete"} {
	    if {[string range $line 7 7] == "A"} {
		# Added AA signal for second part of multinode deletes. See
		# function delete-from-goal-tree in prod-specific.lisp [17oct97
		# cox]
		if {[string range $line 8 8] == "A"} {
		deleteApplied $canvasGoalTree $canvasAppliedOps \
			[string range $line 9 end] 0
		} else {
		deleteApplied $canvasGoalTree $canvasAppliedOps \
			[string range $line 9 end] 1
		}
	    } else {      
		# Amicably check the thing is there before deleting
		set nodenum [string range $line 7 end]
		if {[lsearch [array names prodigyIDnums] $nodenum] != -1} {
		    deleteNode $canvasGoalTree $nodenum
		}
	    }
	    set line [gets $lisp]
#	    puts "Inside loop (line ->$line<-)\n"
	  # Handle monitors [29oct97 cox]
	} elseif {[string range $line 0 7] == "Sentinel"} {
	    showSentinel $line
	    set line [gets $lisp]
	    #Signal the Data
	} elseif {[string range $line 0 4] == "SData"} {
	    activateSentinel $line 1
	    set line [gets $lisp]
	    #Signal Negative Data
	} elseif {[string range $line 0 5] == "SNData"} {
	    activateSentinel $line 0
	    set line [gets $lisp]
	} elseif {[string compare $line "Start-user-choice"] == 0} {
	    showMenu
	    set run_suspended 1
	} elseif {[string compare $line "Update-case"] == 0} {
	    UpdateCaseElement
	    set run_suspended 1
	} else {
	    #=== Parse the line: name & text & parent & type ux uy lx ly
	    set tab [string first "&" $line]
	    set name [string range $line 0 [expr $tab-2]]
	    set tab2 [expr [string first "&" \
		    [string range $line [expr $tab+1] end]]+$tab+1]
	    set label [string range $line [expr $tab+2] [expr $tab2-2]]
	    set tab3 \
		    [expr [string first "&" \
		                  [string range $line [expr $tab2+1] end]]\
		          +$tab2+1]
	    set par [string range $line [expr $tab2+2] [expr $tab3-2]]
	    set type [string range $line [expr $tab3+2] [expr $tab3+2]]
	    set ux [string range $line [expr $tab3+4] [expr $tab3+8]]
	    set uy [string range $line [expr $tab3+9] [expr $tab3+13]]
	    set lx [string range $line [expr $tab3+14] [expr $tab3+18]]
	    set ly [string range $line [expr $tab3+19] [expr $tab3+23]]
	    if {$par == ""} {
		set par -1
	    }
	    set parent($name) $par
	    #=== Draw the appropriate node
	    if {$type == "A"} {		# Applied op node
	 #drawAppliedOperator $canvasGoalTree $name $par $ux $uy $lx $ly $label
		makeApplied $canvasGoalTree $canvasAppliedOps $name \
		    $par $label 0
	    } elseif {$type == "M"} {	# Applied op node with multiple apps
		makeApplied $canvasGoalTree $canvasAppliedOps $name \
		    $par $label 1
	    } elseif {$type == "X"} {	# Applied op node for an inference rule
		# This is not currently sent by the lisp code.
		set TmpMargin $HeadPlanMargin
		set HeadPlanMargin 40
		set TmpColour $AppTextColour
		set HeadPlanColour $InferenceTextColour
	    } elseif {$type == "G"} {	# Goal node
		drawGoal $canvasGoalTree $name $par $ux $uy $lx $ly $label
	    } elseif {$type == "B"} {	# Bindings node
		drawOperator $canvasGoalTree $name $par $ux $uy $lx $ly $label
	    } elseif {$type == "I"} {	# Bindings node for an inference rule
		# Change the colour for an inference rule.
		set tmpColour $OperatorTextColour
		set OperatorTextColour $InferenceTextColour
		drawOperator $canvasGoalTree $name $par $ux $uy $lx $ly $label
		set OperatorTextColour $tmpColour
	    }
	    update 
	    #=== Decide whether to go on
	    if {$run_suspended == 0} {
		if {$stepping == 0} {
		    lisp_blat ":cont"
		    set line [gets $lisp]
		} else {
		    lisp_blat ":stop"
		    set run_suspended 1
		}
	    }
	}
    }
    #=== Clean up when planning is over
    if {$run_ended == 1} {
	# Do something to show the user we finished a plan
	if {$no_more_input == 0} {
	    $canvasGoalTree create text 150 10 -anchor nw -text [gets $lisp]\
		-font $basefont
	    # If we stepped to the end of a run, reset
	    gets $lisp
	    set no_more_input 1
	}
	set stepping 0
	if {$multstep_win_open == 0} {
	    $active_buttons(run) configure -state normal
	    $active_buttons(multistep) configure -state normal
	}
	$active_buttons(break) configure -state disabled
	$active_buttons(restart) configure -state disabled
	$active_buttons(abort) configure -state disabled
	#Below corresponds to save case entry.
	$mainWindow.mbar.file.menu entryconfigure 2 -state normal
	[lindex $active_menus(viewpartialorder) 0] entryconfigure \
		[lindex $active_menus(viewpartialorder) 1] -state normal
    }
    #Reactivate nodes in goal tree canvas. Need to make this a proc.
    $canvasGoalTree bind node <Any-Enter> \
	    "enterNode $canvasGoalTree $mainWindow.infoframe.value"
    $canvasGoalTree bind text <Any-Enter> \
	    "enterText $canvasGoalTree $mainWindow.infoframe.value"
    $canvasGoalTree bind node <Any-Leave> \
	    "scrollLeave $canvasGoalTree $mainWindow.infoframe.value"
    $canvasGoalTree bind text <Any-Leave> \
	    "textLeave $canvasGoalTree $mainWindow.infoframe.value"
    $canvasGoalTree bind node <Button>  "scrollButton $canvasGoalTree %b"
    $canvasGoalTree bind text <Button>  "scrollButton $canvasGoalTree %b"
    set no_solution 0
    set in_run 0
}


