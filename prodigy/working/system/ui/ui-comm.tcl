#
# ui-comm.tcl, Jim Blythe, 1995
# This file contains tcl code to hook up the Prodigy Ui to lisp
# The Ui window stuff can currently be found in $ui_home/ui.tcl
#

# History:
#
# 22jan97 global variable multstep_win_open added [cox]
#
#   jan97 implemented multistep command [cox]
#
# 23apr97 Reconciled the code with Jim's UI version that uses the latest 
#         Tcl/Tk. This was only adding two new files to be sourced (gv.tcl and 
#         temporal.tcl) and replacing "puts $lisp X" with "lisp_blat X".  [cox]
#
#  3sep97 Small fix in runLoop [cox]
# 
# 17oct97 Fixed the routines that delete application nodes with respect to
#         multiniode deletes (i.e., application nodes with inference
#         rules. Before, the # double deletes would delete an extra application
#         mark in the goal tree # display. See the code that Handles delete
#         requests in procedure runLoop. [cox]



# Must come before ui.tcl
source $ui_home\\bayes.tcl

#Alpine specific code
source $ui_home\\abstraction.tcl

# UI window procedures
source $ui_home\\ui.tcl

# Tcl code for performing manual and automatic case retrieval
source $ui_home\\case-retrieve.tcl

# Load the code to do the communications
source $ui_home\\tolisp.tcl

# The code to call dag and dot and display graphs drawn with them
# Each of these files is a different version - not all are necessary
source $ui_home\\dot.tcl
source $ui_home\\gv.tcl
source $ui_home\\temporal.tcl

# Code for a menu function
source $ui_home\\menu.tcl

# Code for debug window routine. Is called by quick button on UI main.
source $ui_home\\debug.tcl

# The code for handling button functions in the goal tree display canvas.
# Overrides the definition in file ui.tcl
source $ui_home\\scrollbutton.tcl

#Utilities
source $ui_home\\utils.tcl

# The rest of the code that invokes Prodigy/Analogy functions
source $ui_home\\analogy-ui.tcl

#source $ui_home/quality-ui.tcl

#============================================================================
# Some globals
#============================================================================

# True (1) if the multistep window is currently open. It is opened when the 
# multistep button is chosen, and closed when the cancel button on the 
# multistep window is chosen. We need this flag so other commands do not 
# re-enable the multistep command. Otherwise, the user can open the window
# twice, thus generating a tcl error. 
#
set multstep_win_open 0

# Whether the lisp process is currently stepping through a run
set stepping 0

# Whether the run loop is in progress (stops stepping and running being 
# called more than once and causing strange results)
set in_run 0

# Make the connection. Might want to separate this stage sometimes
# for testing
start_up_connection

# Once the connection is open, try to establish if there is a domain and/or
# a problem, and if so make the appropriate menu options work.

proc SyncDomain {} {
    global active_buttons active_menus world_path domain_name
    global domain_line
    set res [lisp_command "(boundp '*current-problem-space*)"]
    if {$res == "T"} {
	# Some of the menu options
	foreach option "viewsnode viewtypehierarchy viewOperatorGraph" {
	    [lindex $active_menus($option) 0] entryconfigure \
		[lindex $active_menus($option) 1] -state normal
	}
	# Read in the world_path and domain_name
	set res [lisp_command "(boundp '*world-path*)"]
	if {$res == "T"} {
	    set world_path [string trim \
				[lindex [lisp_command "*world-path*"] 0] {\"}]
	    set res [lisp_command "(boundp '*problem-path*)"]
	    if {$res == "T"} {
		set res [string trim \
			     [lindex [lisp_command "*problem-path*"] 0] {\"}]
		set domain_name \
		    [string range $res [string length $world_path]\
			 [expr [string last "\\" $res]-1]]
	    }
	}
	set res [lisp_command "(current-problem)"]
	if {$res != "NIL"} {
	    # The buttons down the side
	    $active_buttons(multistep) configure -state normal
	    $active_buttons(run) configure -state normal
	    # Could try to see if there's a plan and activate partial
	    # order, but not for now. Should also try to read world_path
	    # and domain_name for the domain loader dialog.
	}
    }
    if {$domain_name == ""} {
	set domain_name "None"
    }
    $domain_line configure -text "Domain:$domain_name "
}

	    
SyncDomain

#============================================================================
# PRODIGY VARIABLES
#============================================================================

# Some variables that alter are not dealt with here, because they
# are set as a keyword option to "run".
#
# NOTE that this is really sneaky side-effect (not of my doing) since the
# changes to the actual PRODIGY flags are made by these Lisp calls and this
# procedure is called only because the global array prodigyvar is traced. The
# trace setup is actually made in file ui.tcl. [cox] 
#
proc pvar {name elt op} {
    global planning_mode
#  global prodigyvar
  if {$elt != ""} {
    set name ${name}($elt)
  }
  upvar $name var
  #puts "$name = $var"
  if {$elt == "abstractionlevel"} {
      lisp_send "(pset :use-abs-level $var)"
      lisp_receive
  } elseif {$elt == "abstractiontype"} {
      if {[string compare $var "nil"] == 0} {
	  lisp_send "(pset :use-abs-type $var)"
	  displayAbsType "None" 0
      } else {
	  lisp_send "(pset :use-abs-type '$var)"
	  if {[string compare $var "dependent"] == 0} {
	      displayAbsType "Problem Dependent" 0
	  } else {
	      displayAbsType "Problem Independent" 0
	  }
      }
      lisp_receive
  } elseif {$elt == "excise_loops"} {
      lisp_send "(pset :excise-loops $var)"
      lisp_receive
  } elseif {$elt == "user_control"} {
      lisp_send "(enable-user-control $var)"
      lisp_receive
  } elseif {$elt == "randombehaviour"} {
      lisp_send "(pset :random-behaviour $var)"
      lisp_receive
  } elseif {$elt == "linear"} {
      lisp_send "(pset :linear $var)"
      lisp_receive
  } elseif {$elt == "printalts"} {
      lisp_send "(pset :linear $var)"
      lisp_receive
  } elseif {$elt == "minconspiracy"} {
      lisp_send "(pset :min-conspiracy-number $var)"
      lisp_receive
  }
}


#============================================================================
# LOADING DOMAINS AND PROBLEMS
#============================================================================

# Added code to load a file draw.tcl if it exists in the domain directory.
# This is for domain graphics, but could include arbitrary tcl code. I
# didn't want to call it domain.tcl because it was too close to domain.lisp
# Jim (6/21/95)
#
# Removed the form that set world-path [cox 27jun00]

proc load_domain {} {
    global world_path domain_name domain_file

    #puts "---loading domain $world_path$domain_name/$domain_file"
    lisp_send "(progn (setf p4::*always-remove-p* t) \
                      (print (user::domain '[string trim $domain_name "\\"])))"
    lisp_receive
    if [file isfile $world_path$domain_name\draw.tcl] {
	source $world_path$domain_name\\draw.tcl
    }
}

proc load_problem {} {
    global world_path domain_name domain_file problem_name
    global active_buttons    
    global multstep_win_open
    global analogy_domain_needs_loading planning_mode

    # Get rid of the ".lisp"
    set problem [string range $problem_name \
	    0 [expr [string first ".l" $problem_name] - 1]]
    #puts "---loading problem $world_path$domain_name\probs\$problem_name"
    lisp_send "(print (problem '$problem))"
    lisp_receive

    # Added so that when a domain is loaded in another planning mode (e.g., P4)
    # and then mode is changed to analogical mode, the user can be forced to 
    # reload the domain. See cases2.tcl file.
    if {($planning_mode == "analogy")} {
	set analogy_domain_needs_loading 0
    } else {
	# Do not want to reactivate the "Replay" button unless a case is loaded.
	# See LoadCases procedure in file analogy-ui.tcl.
	if {($multstep_win_open == 0)} {
	    $active_buttons(multistep) configure -state normal
	    $active_buttons(run) configure -state normal
	}
    }
}


#============================================================================
# RUNNING AND THE STEPPER
#============================================================================

proc runCommand {} {
    global stepping active_buttons in_run lisp
    global planning_mode mainWindow active_menus

    if {$in_run == 0} {
	$active_buttons(run) configure -state disabled
	$active_buttons(multistep) configure -state disabled
	$active_buttons(break) configure -state normal
	$active_buttons(restart) configure -state disabled
	#Disable case saves.
	$mainWindow.mbar.file.menu entryconfigure 2 -state disabled

	#Also enable search-tree node view function
	[lindex $active_menus(viewsnode) 0] entryconfigure \
		[lindex $active_menus(viewsnode) 1] -state normal

	if {$stepping == 1} {
	    set stepping 0
	    lisp_send ":abort"
	    #=== silently consume the end-of-run info from the last run
	    # run-ended
	    lisp_receive
	    # receive above is better [cox]	    gets $lisp 
	    # why it ended      
	    gets $lisp    
	} 

	#[cox 25jan97]
	if {[string compare $planning_mode "analogy"] == 0} {
	    RestartCases
	}

	runStart
    }
}

proc runStart {} {
    global prodigyvar canvasGoalTree canvasAppliedOps 
    global applications applmark lisp_waiting
    global no_more_input mainWindow

    lisp_flush

    #Disable case saves.
    $mainWindow.mbar.file.menu entryconfigure 2 -state disabled
    set no_more_input 0
    #=== Figure out the running variables passed at run time.
    set runspec ":output-level $prodigyvar(output_level)\
	    :search-default :$prodigyvar(searchdefault)-first"
    if {$prodigyvar(depth_bound) != 0} {
	set runspec [concat $runspec " :depth-bound $prodigyvar(depth_bound) "]
    } 
    if {$prodigyvar(max_nodes) != 0} {
	set runspec [concat $runspec " :max-nodes $prodigyvar(max_nodes) "]
    } 
    if {$prodigyvar(time_bound) != 0} {
	set runspec [concat $runspec " :time-bound $prodigyvar(time_bound) "]
    }
    $canvasAppliedOps delete all
    set applications []
    set applmark []
    #Removed the setting of *user-guidance* to t below [19sep97 cox]
    lisp_send "(progn (add-drawing-handler)\
	    (print (user::run $runspec))\
	    (remove-drawing-handler)\
	    (opt-send-final))"
    incr lisp_waiting -1
    # We need a function call that also removes the information stored 
    # about the nodes.
    $canvasGoalTree delete all
    drawOperator $canvasGoalTree 4 -1 100 10 150 30 {"Top Goals"}
    runLoop
}

#Need to comment the use of this var [cox]
set no_more_input 0

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
    if {[string compare $line "Clean-case"] == 0} {
	while {$line != " 0"} {
	    if {[string compare $line "Clean-case"] == 0} {
		puts "Received Clean-case from Lisp"
		CleanCase
		update idletasks
	    } elseif {[string compare $line "Mark-first"] == 0} {
		puts "Marking first node"
		UpdateFirst
	    }
	    set line [gets $lisp]
#	    puts "Another line (line ->$line<-)\n"
    }   }
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
	} elseif {[string compare $line "Update-case"] == 0} {
	    UpdateCaseElement
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


proc multistepCommand {} {
    global run_ended loopcount active_buttons
    global multstep_win_open stepping

    # Default step is 1
    set loopcount 1
    set casefont  -adobe-times-medium-r-normal--*-140-*
    set multstep_win_open 1
    $active_buttons(multistep) configure -state disabled
    $active_buttons(run) configure -state disabled

    #Multi Step Window
    toplevel .msw
    wm title .msw " Multistep Count "

    frame .msw.top -relief raised -bd 1 
    pack  .msw.top -side top -fill x
    label .msw.top.label -text "Enter Number of Planning Steps per Loop:" \
	    -font $casefont
    entry .msw.top.entry -width 8 -textvariable loopcount -font $casefont \
	    -relief sunken
    pack  .msw.top.label -side left
    pack  .msw.top.entry -side left
    
    frame .msw.bot -relief raised -bd 1 
    pack  .msw.bot -side top -fill both

    focus .msw.top.entry
    bind  .msw.top.entry <Return> { focus .msw.top.entry }

    button .msw.bot.ok -text "Execute Steps" -relief raised -bd 2 -font $casefont \
	    -command {
        set oldcount $loopcount
        while {$loopcount > 0} {
	    stepCommand
	    if {$run_ended == 1} {
		set loopcount 0
	    } else {
		set loopcount [expr ($loopcount - 1)]
	    }
	}
	set loopcount $oldcount
    }
    button .msw.bot.cancel -text Cancel -relief raised -bd 2 -font $casefont \
	    -command cancelMultistep
    pack  .msw.bot.ok .msw.bot.cancel -side left  -pady 10 -padx 10
}

proc cancelMultistep {} {
    global multstep_win_open
    global active_buttons
    global stepping

    destroy .msw
    set multstep_win_open 0
    $active_buttons(multistep) configure -state normal
    if {$stepping == 0} {
	$active_buttons(run) configure -state normal
    }
}

    
# step command calls run, but with stepping = 1, so we only go through the 
# loop once. Multi-step will either use a count or will send a condition to 
# lisp to maintain.
proc stepCommand {} {
    global stepping lisp active_buttons in_run
  
    if {$in_run == 0} {
	if {$stepping == 1} {
	    lisp_blat ":cont"
	    runLoop
	} else {
	    set stepping 1
	    $active_buttons(restart) configure -state normal
	    $active_buttons(abort) configure -state normal
	    runStart
	}
    }
}

#Added the following so that it can be called from the View pull-down menu
# as well as being called from the abortCommand procedure [cox 4aug97]
# 
proc clearCanvases {} {  
    global mainWindow
    global canvasAppliedOps canvasGoalTree
    global active_menus

    $canvasAppliedOps delete all
    $canvasGoalTree   delete all

    #Since user cleared canvases above, disable ps dumps of both from menu bar.
    $mainWindow.mbar.file.menu entryconfigure 3 -state disabled
    $mainWindow.mbar.file.menu entryconfigure 4 -state disabled

    #Also disable search-tree node view function
    [lindex $active_menus(viewsnode) 0] entryconfigure \
	    [lindex $active_menus(viewsnode) 1] -state disabled
}


proc abortCommand {} {
  global no_solution
  global multstep_win_open
  global lisp stepping active_buttons 
    global debug_msg

  # interrupt the run if it's going on
  set stepping 1
  lisp_send ":abort"

    clearCanvases

  if {$multstep_win_open == 0} {
      $active_buttons(run) configure -state normal
      $active_buttons(multistep) configure -state normal
  }
  $active_buttons(break) configure -state disabled
  $active_buttons(restart) configure -state disabled
  $active_buttons(abort) configure -state disabled

  #=== silently consume the end-of-run info from the last run
  # run-ended
  set debug_msg "-> [gets $lisp] <-"
  # why it ended      
  set debug_msg "-> [gets $lisp] <-"
  set no_solution 1
  set stepping 0
}

proc breakCommand {} {
  global multstep_win_open
  global stepping active_buttons

  if {$multstep_win_open == 0} {
      $active_buttons(multistep) configure -state normal
  }
  $active_buttons(break) configure -state disabled
  $active_buttons(restart) configure -state normal
  $active_buttons(abort) configure -state normal

  set stepping 1
}

proc restartCommand {} {
  global stepping lisp active_buttons in_run

  if {$stepping == 1 && $in_run == 0} {
    $active_buttons(multistep) configure -state disabled
    $active_buttons(break) configure -state normal
    $active_buttons(restart) configure -state disabled

    set stepping 0
    lisp_blat ":cont"
    runLoop
  }
}

#============================================================================
# THE TYPE HIERARCHY
#============================================================================

# Draws the type hierarchy with dag. Since this is a simple tree, the
# layout should perhaps be calculated in lisp, to be more portable

#proc viewTypeHierarchy {} {
#  global domain_name
#  lisp_flush
#  lisp_command "(type-dag \"/tmp/tmp.pic\")"
#  #puts "Building dag.."
#
#  set w .typetree
#  catch {destroy $w}
#  toplevel $w
#  wm title $w "Type hierarchy for $domain_name domain"
#  wm minsize $w 100 100
#  frame $w.f -relief sunken -borderwidth 2
#  frame $w.bf
#  button $w.done -text "Done" -command "destroy $w"
#  pack $w.bf -side top
#  pack $w.done -in $w.bf -side left -pady 5 -padx 10
#  pack $w.f -side top -expand yes -fill both
#
#  canvas $w.f.c -scrollregion "-1i -1i 60i 60i" -background white\
#    -xscroll "$w.f.hs set" -yscroll "$w.f.vs set"
#  scrollbar $w.f.vs -command "$w.f.c yview" -relief sunken
#  scrollbar $w.f.hs -orient horiz -command "$w.f.c xview" -relief sunken
#  pack $w.f.vs -side right -fill y
#  pack $w.f.hs -side bottom -fill x
#  pack $w.f.c -in $w.f -expand yes -fill both
#  display_dag_canv /tmp/tmp.pic $w.f.c
#}

proc viewTypeHierarchy {} {
    global domain_name
    drawGenericGraph .typehier "Type hierarchy for $domain_name domain"\
	    "(type-dag \"\\tmp\\tmp.pic\")" {} do_nothing
}

#============================================================================
# THE PARTIAL ORDER
#============================================================================

# Uses dag and Manuela's and Alicia's code to draw the plan partial order

# No callback is defined yet.
proc do_nothing {} {}

proc viewPartialOrder {} {
    drawGenericGraph .po "Partial order for plan"\
	    "(make-po \"\\tmp\\tmp.dag\\" \"\\tmp\\tmp.pic\")" {} do_nothing
}

proc viewOperatorGraph {} {
    drawGenericGraph .op "Operator-Assertion dependency graph"\
	"(ui-make-op-graph \"\\tmp\\tmp.dag\" \"\\tmp\\tmp.pic\")" {} do_nothing
}
