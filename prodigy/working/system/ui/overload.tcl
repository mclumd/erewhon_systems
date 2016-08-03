# History:
#
# 27oct97 Wrote flush_socket so that the ui can clear extra input sitting in
#         the lisp socket that was generated during the ForMAT-Prodigy TIE demo.
#

# Install the Prodigy/Analogy -- ForMAT TIE Demo (MI-CBP -> JADE) 
# if possible.
#
if {[lispVar *load-prodigy-front-end*] != "NIL"} {
    $mainWindow.mbar.rm.menu add command -label "JADE - CBMIP" \
	    -command "setupForMATdemo $mainWindow" -font $basefont
    $mainWindow.mbar.view.menu add command -label "View JADE info" \
	    -command viewJadeInfo \
            -font $basefont
    $mainWindow.mbar.view.menu add command -label "View JADE Script2" \
	    -command "exec netscape http://206.154.213.242:8080/ifd/scenario.html &" -font $basefont
    lisp_send "(setf FE::*ForMAT-loaded* nil)"
    lisp_receive
    }

# Overwrites the usual values (from ui-start.tcl) which are bayes, analogy and
# abstraction. NOTE that bayes.tcl does the same overload when only analogy and
# abstraction exist on the lists.

set special_commands {bayes analogy abstraction jade}
set special_commands_label {"Bayes" "Analogy" "Abstraction" "JADE - CBMIP"}

set labels(jade) {"Flush Socket" "Jade Info"}

set commands(jade) {flush_socket viewJadeInfo}
set infotext(jade) {"Flush the Socket after a Run" "View Jade Information from Netscape"}


proc viewJadeInfo {} {
    exec netscape http://www.cs.cmu.edu/afs/cs/project/prodigy/Web/Mixed-init/Jade/jade.html &
}


#============================================================================
proc setupForMATdemo {w} {
    global problem_name no_solution active_buttons

    setupDefaultRun $w
    set problem_name "None"
    set no_solution 1
    $active_buttons(run) configure -state normal
    lisp_send "(FE::load-analogy-if-needed)"
    lisp_receive
    lisp_send "(setf FE::*ForMAT-loaded* t)"
    lisp_receive
    lisp_send "(setf *talk-case-p* nil)"
    lisp_receive
    lisp_send "(setf *verbose* nil)"
    lisp_receive
    lisp_send "(setf *world-path* (concatenate 'string *system-directory* \"analogy/domains\")))"
    lisp_receive
    #Added [15jun98 cox]
    doSetUp jade
}


#
# Procedure changePlanningMode2 manages changes in planning modes, especially 
# when going to or from Prodigy/Analogy mode.
#
# Global variable planning_mode records the current running mode of Prodigy.
# The variable is used by the runCommand and changePlanningMode2 procedures. 
# The start-up mode of Prodigy is generative planning (p4). The standard 
# variable assignments are one of p4, analogy, abstraction, or bayes. To this
# list, we add here (i.e., the procedure definition overloads the definition 
# defined by file ui-start.tcl earlier) the mode "jade." 
#
proc changePlanningMode2 {new_mode} {
    global planning_mode 
    global active_buttons stepping
    global mainWindow
    global world_path domain_name domain_file
    global multstep_win_open
    global analogy_domain_needs_loading
    global analogy_setup 
    global prodigyvar

    if {($multstep_win_open == 1)} {
	cancelMultistep
    }
    if {[string compare $new_mode $planning_mode] != 0} {
	# If leaving Prodigy/Analogy mode
	if {[string compare $planning_mode "analogy"] == 0} {
	    set domain_name "None"
	    lisp_command "(setf *analogical-replay* nil)"
	    $active_buttons(run) configure -text "Run"
	    $active_buttons(run) configure -state disabled
	    $active_buttons(multistep) configure -state disabled
	    $active_buttons(break) configure -state disabled
	    $active_buttons(restart) configure -state disabled
	    $active_buttons(abort) configure -state disabled
	} elseif {[string compare $planning_mode "jade"] == 0} {
	    # If leaving CBMIP mode
	    lisp_command "(setf *analogical-replay* nil)"
	    $active_buttons(run) configure -state disabled
	    $active_buttons(multistep) configure -state disabled
	    $active_buttons(break) configure -state disabled
	    $active_buttons(restart) configure -state disabled
	    $active_buttons(abort) configure -state disabled
	    lisp_send "(setf FE::*ForMAT-loaded* nil)"
	    lisp_receive
	} elseif {[string compare $planning_mode "abstraction"] == 0} {
	    # If leaving abstraction (Alpine) mode
	    #Disable Alpine-specific control variables
	    $mainWindow.mbar.rv.menu entryconfigure 10 -state disabled
	    $mainWindow.mbar.rv.menu entryconfigure 11 -state disabled
	}
	switch $new_mode {
	    p4 {
	        wm title $mainWindow " Prodigy 4.0 "
	    }
	    abstraction {
	        wm title $mainWindow " Alpine "

		#Enable Alpine-specific control variables
		$mainWindow.mbar.rv.menu entryconfigure 10 -state normal
		$mainWindow.mbar.rv.menu entryconfigure 11 -state normal

		#The following actually has side-effect of displaying 
		#abstraction type in info bar.
		#set prodigyvar(abstractiontype)  $prodigyvar(abstractiontype)
	    }
	    analogy {
		#If not already in analogical planning mode
		if {[string compare $planning_mode analogy] != 0} {
		    if {[string compare $planning_mode jade] != 0} {
			set analogy_domain_needs_loading 1
			set domain_name "None"
		    }
		    wm title $mainWindow " Prodigy/Analogy "
		    if {[string compare [lispVar *analogy-loaded*] NIL] == 0} {
			lisp_command "(load \"$analogy_setup\")"
		    }
		    lisp_command "(setf *analogical-replay* t)"
		    lisp_command "(user::set-for-replay)"
		    lisp_command "(user::set-for-replay-ui)"
		    $active_buttons(run) configure -text "Replay"
		    $active_buttons(run) configure -state disabled
		    $active_buttons(multistep) configure -state disabled
		    $active_buttons(break) configure -state disabled
		    $active_buttons(restart) configure -state disabled
		    $active_buttons(abort) configure -state disabled
	    }   }
	    jade {
	        wm title $mainWindow " Prodigy/CBMIP "
#		set world_path "/afs/cs/project/prodigy-1/mcox/domains/"
		set world_path [string trim \
				[lindex [lisp_command "(setf *world-path* (concatenate 'string *system-directory* \"analogy/domains\"))"] 0] {\"}]
		set domain_name "jade"
		set domain_file "domain.lisp"
	    }
	    bayes {
	        wm title $mainWindow " Weaver "
	    }
	}
	if {[string compare $planning_mode "abstraction"] == 0} {
	    set planning_mode $new_mode
	    #This has to be done because of "trace" side-effect of making 
	    #changes to prodigyvar when leaving abstraction mode. See proc pvar
	    #in file ui-comm.tcl [cox 11ju97]
	    set prodigyvar(abstractiontype)  "nil"
	} else {
	    set planning_mode $new_mode
	}
    }
}



proc runStart {} {
    global prodigyvar canvasGoalTree canvasAppliedOps 
    global applications applmark lisp_waiting
    global no_more_input planning_mode
    global lisp debug_msg

    lisp_flush

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
    # Here is where it runs the front-end function if in jade mode [cox]
    if {[string compare $planning_mode "jade"] == 0} {
	lisp_send "(if (return-val FE::*ForMAT-loaded*)\
		(user::start-prodigy-front-end t ))"
	set line [gets $lisp]
	while {$line != "DisplayCases"} {
	    set debug_msg $line
#	    puts $debug_msg
	    update 
	    set line [gets $lisp]
	}
	puts "Found DisplayCases string"
	CloseAll
	DisplayCases
    } else {
	#Removed the setting of *user-guidance* to t below [19sep97 cox]
	lisp_send "(progn \
      		(if (return-val *use-monitors-p*) \
                    (reset))\
                (add-drawing-handler)\
		(print (user::run $runspec))\
		(remove-drawing-handler)\
		(opt-send-final))"
    }
    incr lisp_waiting -1
    # We need a function call that also removes the information stored 
    # about the nodes.
    $canvasGoalTree delete all
    drawOperator $canvasGoalTree 4 -1 100 10 150 30 {"Top Goals"}
    runLoop
}


#Some code from Clint at BBN to read from the socket even if input has not yet been sent.
#
proc tell_lne {} {
    global lisp wait result
    set result {}
    if [info exists lisp] {
	set wait 1
	fileevent $lisp readable "set wait 0"
	tkwait variable wait
	fileevent $lisp readable ""
	set result [gets $lisp]
    return $result }
}

# Use this procedure call to clear the lisp socket after the ForMAT-Prodigy TIE demo.
# Updated the procedure [cox 12jun98]
#
proc flush_socket {} {
    global lisp

    set input ""
    lisp_blat "(quote JADE)"
    while  {$input != " JADE"} {
	set input [gets $lisp]
    }
    #NIL
#    set input [gets $lisp]
    #The rest are :cont
#    set input [gets $lisp]
#    set input [gets $lisp]
#    set input [gets $lisp]
#    set input [gets $lisp]
#    set input [gets $lisp]
#    set input [gets $lisp]
#    set input [gets $lisp]
#    set input [gets $lisp]
#    set input [gets $lisp]
#    set input [gets $lisp]
#    set input [gets $lisp]
    return $input
}



# Added the following pieces of code to enable/disable rationale-based sensing
# monitors [19mar98 cox]

set prodigyvar(monitors)      "nil"
set monitor_directory "/prodigy/working/system/monitors"


$mainWindow.mbar.rv.menu add command -label "Rationale-based Monitors" -command {
                    catch {destroy .monitors}
                    toplevel .monitors
                    setMonitors .monitors ""
                } -font $basefont

proc setMonitors {w notop} {
    set buttons {"True (use monitors)" "False"}
    set varvals {"t" "nil"}
    mkRadioListBox $w "Sensing Monitors" monitors $buttons $varvals $notop
}



# The following is overloaded from ui-comm.tcl
#============================================================================
# PRODIGY VARIABLES
#============================================================================

# Some variables that alter Prodigy control variables are not dealt with here,
# because they are set as a keyword option to "run".
#
# NOTE that this is really sneaky side-effect (not of my doing) since the
# changes to the actual PRODIGY flags are made by these Lisp calls and this
# procedure is called only because the global array prodigyvar is traced. The
# trace setup is actually made in file ui.tcl. [cox] 
#
proc pvar {name elt op} {
    global planning_mode 
    global monitor_directory
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
  } elseif {$elt == "DisplayCases"} {
      puts "Should this really be here"
  } elseif {$elt == "monitors"} {
      puts $var
      source $monitor_directory/monitor.tcl
      source $monitor_directory/overload.tcl
      lisp_send "(setf *use-monitors-p* $var)"
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


