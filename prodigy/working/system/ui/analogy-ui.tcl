
# History:
#  4mar97 Added mergeStrats procedure [cox]
#
# 17apr97 Disabled replay when the user closes case windows.
#
# 23apr97 Reconciled the code with Jim's UI version that uses the latest 
#         Tcl/Tk [cox]
#
# 11sep97 Added getSerialOrder procedure and associated globals. RestartCases
#         now passes the serial_order to Prodigy/Analogy's init-guiding 
#         function. Procedure mergeStrats now calls getSerialOrder when user 
#         chooses that merge mode. [cox]
#
# 5jun98 Created proc DisplayCases and replaced code within LoadCases to call
#        it instead of directly performing the code that is within
#        DisplayCases.  Therefore other procedures (e.g., the overloaded proc
#        runStart within file overload.tcl) can reuse the same code.  Also
#        modified proc EnterCaseElt to allow horizontal expansion of case
#        display, as well as proc ReceiveCase to allow larger resizing of case
#        vertically.
    


#Remove if with prod-ui
#set ui_home /afs/cs/project/prodigy/version4.0/working/system/ui
#source $ui_home/tolisp.tcl
#source /afs/cs/user/ledival/prodigy/ui/simu.tcl
#start_up_connection
#set boldfont  -adobe-times-medium-r-normal--*-140-*
#set basefont  -adobe-times-medium-r-normal--*-140-*
#set obliquefont  -adobe-times-medium-i-normal--*-140-*
#**********

set TabCase ""
set PointerCase ""
set w 0
set k 1
set cur_win 0

proc ReceiveCase { } {
    global lisp TabCase PointerCase w k cur_win 
    global win maxwidth

    set line [gets $lisp]
    set TabCase [linsert $TabCase [llength $TabCase] $line]
    set PointerCase [linsert $PointerCase [llength $PointerCase] 0]
    set cur_win $w
    incr w    
    update idletasks

    set k 1
    set win .w$cur_win
    set maxwidth 0

    toplevel $win
    wm minsize $win 50 50
    #Added to allow increased sizes for large cases. [cox 12jun98]
    wm maxsize $win 1137 2000
    wm title $win [lindex $TabCase $cur_win]

    if {$cur_win > 0} {
        set previous [wm geometry .w[expr $cur_win -1]]
        scan $previous "%dx%d+%d+%d" wid h x y
        incr x 5
        wm geometry $win +[expr $x + $wid + 122]+$y
        } else {
        wm geometry $win +300+55
    }

    message $win.prompt -font -adobe-times-medium-i-normal--*-140* -aspect 800 \
	    -text "Case:  [lindex $TabCase $cur_win]"
    pack $win.prompt

    frame $win.but -bd 1 
    pack  $win.but -expand 1 -fill x

    button $win.but.close -text Close  -width 12 -command {
            CloseAll
            }
    pack $win.but.close -expand 1 -fill x

}

# Added disabling of replay because the system cannot display the step markers 
# without a window with a case in it. [cox 17arp97]
#
proc CloseAll { } {
    global TabCase PointerCase
    global w k cur_win
    global active_buttons planning_mode

    for {set i 0} {$i < [llength $TabCase]} {incr i} {
         destroy .w$i
    }
    set TabCase ""
    set PointerCase ""
    set w 0
    set k 1
    set cur_win 0
    if {[string compare $planning_mode analogy] == 0} {
	$active_buttons(run) configure -state disabled
	$active_buttons(multistep) configure -state disabled
    }
}

#Changed to allow horizontal expansion of case display. [cox 5jun98]
proc EnterCaseElt {line} {
    global win k cur_win maxwidth

    set win .w$cur_win

#    if {[string length $line] > $maxwidth} {
#	set maxwidth [string length $line]
#    }

    frame $win.$k 
    pack  $win.$k -expand true -fill x

    label $win.$k.name -text $line -relief raised -width 35
    pack  $win.$k.name -side left -expand true -fill x
                 
    label $win.$k.mark -text "" -width 5
    pack  $win.$k.mark -side left
    incr k
}

proc CleanCase { } {
    
    global TabCase lisp PointerCase

    set case_name [gets $lisp]
    set pos [lsearch -exact $TabCase $case_name]
    
    set PointerCase [lreplace $PointerCase $pos $pos 0]
    set j 1
    for {set finish 0} {$finish == 0} {} {
         if {[winfo exists .w$pos.$j.mark] == 1} {
             destroy .w$pos.$j.mark
             label .w$pos.$j.mark -text "" -width 5
             pack  .w$pos.$j.mark -side left
         } else {
                 set finish 1
         }
         incr j
    }
    
}


proc UpdateCaseElement { } {
    global lisp TabCase PointerCase
    global debug_msg in_update prodigyIDnums canvasGoalTree applmark
    
    incr in_update 
    set case_name [gets $lisp]
    set case_elt [gets $lisp]
    set case_message [gets $lisp]
    set temp [string trim $case_message]
    if {([string compare $temp "**"] != 0) && ([string length $temp] != 0)} {
#	set case_message [expr [lindex [$canvasGoalTree bbox $prodigyIDnums($temp)] 1]-5]
	set case_message [expr [llength $applmark]+1]
	set debug_msg [concat [list "case_name $case_name" "case_elt $case_elt" \
	    "case_message $case_message"  "TabCase $TabCase" "PointerCase $PointerCase" \
	    "ApplMark "] $applmark]
	mkErrorDialog .looperror "Pause"
    }
    set debug_msg [list "case_name $case_name" "case_elt $case_elt" \
	    "case_message $case_message"  "TabCase $TabCase" "PointerCase $PointerCase"]

    set pos [lsearch -exact $TabCase $case_name]
    set cur_pointer_pos [lindex $PointerCase $pos]
    set PointerCase [lreplace $PointerCase $pos $pos $case_elt]

    if {$cur_pointer_pos != 0} {
        destroy .w$pos.$cur_pointer_pos.mark
        label .w$pos.$cur_pointer_pos.mark -text $case_message -width 5
        pack  .w$pos.$cur_pointer_pos.mark
    }

    destroy .w$pos.$case_elt.mark
    label .w$pos.$case_elt.mark -text "<==" -width 5
    pack  .w$pos.$case_elt.mark

    runLoop
    incr in_update -1
}


proc UpdateFirst { } {
    global lisp TabCase PointerCase
    global debug_msg
    
    set case_name [gets $lisp]
    set case_elt [gets $lisp]
    set case_message [gets $lisp]
    set debug_msg [list "case_name $case_name" "case_elt $case_elt" \
      "case_message $case_message"  "TabCase $TabCase" "PointerCase $PointerCase"]

    set pos [lsearch -exact $TabCase $case_name]
    set cur_pointer_pos [lindex $PointerCase $pos]
    set PointerCase [lreplace $PointerCase $pos $pos $case_elt]

    if {$cur_pointer_pos != 0} {
        destroy .w$pos.$cur_pointer_pos.mark
        label .w$pos.$cur_pointer_pos.mark -text $case_message -width 5
        pack  .w$pos.$cur_pointer_pos.mark
    }

    destroy .w$pos.$case_elt.mark
    label .w$pos.$case_elt.mark -text "<==" -width 5
    pack  .w$pos.$case_elt.mark

}

proc UpdateText { } {
    global lisp TabCase PointerCase
    
    set case_name [gets $lisp]
    set case_elt [gets $lisp]
    set case_text [gets $lisp]

    set pos [lsearch -exact $TabCase $case_name]

    destroy .w$pos.$case_elt.names
    label .w$pos.$case_elt.name -text $case_text -relief raised -width 20
    pack  .w$pos.$case_elt.name -side left

    destroy .w$pos.$case_elt.mark
    label .w$pos.$case_elt.mark -text "" -width 5
    pack  .w$pos.$case_elt.mark -side left

}

# Below was called RestartCases
# At the current time, this procedure is not called by any other function and 
# it is not available to the user via a widget.
#
proc ReplayCases { } {
    global lisp problem_name
# Added set-for-replay and runCommand [cox 18dec96]
    if { ($problem_name == "None") } {
	mkErrorDialog .error {"Please select a problem with the LOAD button."}
    } else {
    lisp_blat "(progn (user::set-for-replay)(user::init-guiding) 0)"
    runCommand
    }
}


# Called by runCommand if planning_mode = analogy
#
proc RestartCases { } {
    global lisp serial_order
    global debug_msg

    lisp_blat "(progn (user::init-guiding '$serial_order) 0)"
    set line [gets $lisp]
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
    }
    set debug_msg "Line = $line in RestartCases"
}


# Called by autoRetrieveCases in file case-retrieval and in proc retrieveCases
# (the latter procedure sets up a control window, and LoadCases is called when the
# user selects the "Done" button.)
#
proc LoadCases { } {
    global cur_win maxwidth
    global active_buttons

    # Regular load-cases is now done by function auto-load-cases (called by
    # proc autoRetrieveCases) and by function use-cases (called by the user
    # selecting the "Load Selected Cases" button in the manual case retrieval
    # control window. [cox]
#    lisp_command "(user::load-cases)"
#    gets $lisp
#    gets $lisp

    #Close past case-display windows that may be open. [cox 7jul97]
    CloseAll

    # The next call causes all cases in *case-cache* to be loaded as follows:
    # Initialize the case, send to tcl the string "Load-case", send case name, 
    # send each case node, the string "Mark-first", send the case name again,  
    # send the integer 1, and finally send string "  ".
    lisp_blat "(progn (user::load-cases-tcl) 0)"

    # Made into proc call rather than code within LoadCases so other routines
    # can reuse. [cox 5jun98]
    DisplayCases

#    .w$cur_win configure -width [expr $maxwidth * 16]
    $active_buttons(run) configure -state normal
    $active_buttons(multistep) configure -state normal
}


proc DisplayCases { } {
    global lisp cur_win 
    global debug_msg

    puts "Start DisplayCases"
    set line [gets $lisp]
    set debug_msg $line
#    puts $debug_msg
    while {[string compare $line "hi"] == 0} {
	update 
	set line [gets $lisp]
     }
    while {$line != " 0"} {
        if {[string compare $line "Load-case"] == 0} {
    	    puts "Received Load-case from Lisp"
	    ReceiveCase
            puts "Writing now in window $cur_win"
    	    update idletasks
        } elseif {[string compare $line "Mark-first"] == 0} {
    	    puts "Marking first node"
    	    UpdateFirst
    	} elseif {[string compare $line "DisplayCases"] == 0} {
    	    puts "Extra DisplayCases string"
    	} elseif {[string compare $line " NIL"] == 0} {
	    puts "NIL found"
    	} else {
#	    puts stdout "Got line $line"
    	    EnterCaseElt $line
        }
        set line [gets $lisp]
	set debug_msg $line
#	puts $debug_msg
    }
}

#
# Procedure mergeStrats presents a dialog box to the user from which the user
# chooses a desired merge strategy. The code then calls lisp to perform the 
# assignment. [cox 4mar97] 
#
proc mergeStrats { } {
    set selection [dialog .mstrats "Case Merge Strategies" \
	           "Select from the following case merging strategies:" "" 0 \
                   Cancel Saba Saba-cr "Eager Apply" \
		   Serial Smart Sequential User Random]
    if {$selection == 4} {
	getSerialOrder
	lisp_command "(select-merge $selection)"
    } else {
	if {$selection == 5} {
	mkErrorDialog .smart_error \
	{"To use Smart, set *set-of-interacting-goals* manually in Lisp. List \
 of all the groups of interacting goals for a problem for example : \
(((at hammer locb) (at apollo locb)) ((at robot locb) (at apollo \
locb))) for a problem in the rocket domain in which a hammer and a \
rocket have to be moved from loca to locb. The groups can be written in \
any order, but the goals in a group have to be ordered: the first goal \
has to be achieved before the second, third, etc ; the second one \
before the third, etc ; and so on. NOTE : in the current \
implementation, only pairs of goals are considered"}
    }
    lisp_command "(select-merge $selection)"
}   }


#Probably should put these initializations in ui-start.tcl. [cox]
set serial_order "()"
set previous_order $serial_order

# Have user choose a serial order (like init-guiding does when not using the UI).
# 
proc getSerialOrder { } {
    global serial_order previous_order

    set myfont  -adobe-times-medium-r-normal--*-140-*
    set previous_order $serial_order

    toplevel .so
    wm title .so " Serial Order "

    frame .so.cd -relief raised -bd 1 
    pack  .so.cd -side top -fill x
    label .so.cd.label1 -text "Enter cases in the order to follow:" \
	    -font $myfont
    label .so.cd.label2 -text "e.g. (0 1 2), (1 0 2), (random)" -font $myfont
    entry .so.cd.entry -width 40 -textvariable serial_order -font $myfont \
	    -relief sunken
    pack  .so.cd.label1 -side top
    pack  .so.cd.label2 -side top
    pack  .so.cd.entry -side bottom

    frame .so.bot -relief raised -bd 1 
    pack  .so.bot -side top -fill both
    
    focus .so.cd.entry

    button .so.bot.ok -text OK -relief raised -bd 2 -font $myfont \
	    -command {
	destroy .so 
    }
    button .so.bot.cancel -text Cancel -relief raised -bd 2 -font $myfont \
	    -command {set serial_order $previous_order 
    destroy .so}
    pack  .so.bot.ok .so.bot.cancel -side left  -pady 10 -padx 10
}



# This implements Manuel'a multiple case merge demo with two 1-object cases in
# the rocket that solves the two object problem. One case has some steps 
# skipped.
#
proc performDemo {} {
    global domain_name problem_name

    if {[string compare $domain_name rocket] == 0 \
	    || [string compare $problem_name \
	    prob2objs-2.lisp ] == 0} { 
	lisp_command "(progn \
		(setf *talk-case-p* t \
		*replay-cases* \
		'((\"case-prob1-robot\" \"case-obj2\" ((at obj2 locb)) \
		((<r31> . r1) (<o77> . obj2) (<l15> . locb) (<l20> . loca))) \
		(\"case-prob1-hammer\" \"case-obj1\" ((at obj1 locb)) \
		((<r1> . r1) (<o44> . obj1) (<l54> . locb) (<l1> . <l1>))))) \
		(load-cases))" 
	LoadCases 
    } else { 
	mkErrorDialog .error \
		"First load rocket domain and the prob2objs-2 problem"
    } 
}


#Funcoes utilizadas para simulacao (Functions used for simulation) 
proc RunLoopu { } {
    global lisp 

    set line [gets $lisp]
    while {$line != "DONE"} {
        if {$line == "Update-case"} {
            puts "Received Update-case from Lisp"
            UpdateCaseElement
            update idletasks
        }
        set line [gets $lisp]
    }

}

proc RunLoopc { } {
    global lisp 

    set line [gets $lisp]
    while {$line != "DONE"} {
        if {$line == "Clean-case"} {
            puts "Received Clean-case from Lisp"
            CleanCase
            update idletasks
        }
        set line [gets $lisp]
    }
}

proc RunLoopt { } {
    global lisp 

    set line [gets $lisp]
    while {$line != "DONE"} {
        if {$line == "Update-text"} {
            puts "Received Update-text from Lisp"
            UpdateText
            update idletasks
        }
        set line [gets $lisp]
    }
}

#######################


proc saveCase { } {
    global case_dir case_file lisp
    global problem_name no_solution

    if { ($problem_name == "None") } {
	mkErrorDialog .error {"Please select a problem with the LOAD button."}
    } else {
	if { ($no_solution == 1) } {
	    mkErrorDialog .error {"No executed solution to store."}
	} else {
	    lisp_blat "(get-default-case-name)"
	    set case_file [lindex [gets $lisp] 0]	    
	    lisp_blat "(get-default-case-dir-name)"
	    set case_dir [lindex [gets $lisp] 0]

  set casefont  -adobe-times-medium-r-normal--*-140-*

  toplevel .sw
  wm title .sw " Save Planning Case "

  frame .sw.cf -relief raised -bd 1 
  pack  .sw.cf -side top -fill x
  label .sw.cf.label -text "Case File:" -font $casefont
  entry .sw.cf.entry -width 40 -textvariable case_file -font $casefont -relief sunken
  pack  .sw.cf.label -side left
  pack  .sw.cf.entry -side left

  frame .sw.cd -relief raised -bd 1 
  pack  .sw.cd -side top -fill x
  label .sw.cd.label -text "Case Directory:" -font $casefont
  entry .sw.cd.entry -width 70 -textvariable case_dir -font $casefont -relief sunken
  pack  .sw.cd.label -side left
  pack  .sw.cd.entry -side left

  frame .sw.bot -relief raised -bd 1 
  pack  .sw.bot -side top -fill both

  focus .sw.cf.entry
  bind  .sw.cf.entry <Return> { focus .sw.cd.entry }

  focus .sw.cd.entry
  bind .sw.cd.entry <Return> { focus .sw.cf.entry }

  button .sw.bot.ok -text OK -relief raised -bd 2 -font $casefont \
	  -command {
      lisp_command "(store-case :case-name $case_file :case-dir $case_dir)"
      destroy .sw 
  }
  button .sw.bot.cancel -text Cancel -relief raised -bd 2 -font $casefont \
	  -command {destroy .sw}
  pack  .sw.bot.ok .sw.bot.cancel -side left  -pady 10 -padx 10
}   }
}
