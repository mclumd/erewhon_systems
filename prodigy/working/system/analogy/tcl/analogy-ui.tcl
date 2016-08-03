#!/afs/cs/project/theo-7/tcl-tk/bin/dpwish -f

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

    wm title $win Case:

    if {$cur_win > 0} {
        set previous [wm geometry .w[expr $cur_win -1]]
        scan $previous "%dx%d+%d+%d" wid h x y
        incr x 5
        wm geometry $win +[expr $x + $wid]+$y
        } else {
        wm geometry $win +300+55
    }

    message $win.prompt -font -adobe-times-medium-i-normal--*-140* -aspect 800 \
	    -text [lindex $TabCase $cur_win]
    pack $win.prompt

    frame $win.but -bd 1
    pack  $win.but -expand 1 -fill x

    button $win.but.close -text Close  -width 12 -command {
            CloseAll
            }
    pack $win.but.close -expand 1 -fill x

}

proc CloseAll { } {
    global TabCase Pointercase
    global w k cur_win

    for {set i 0} {$i < [llength $TabCase]} {incr i} {
         destroy .w$i
    }
    set cur_win 0
    set TabCase ""
    set PointerCase ""
    set w 0
    set k 1
    set cur_win 0
}

proc EnterCaseElt {line} {
    global win k cur_win maxwidth

    set win .w$cur_win

#    if {[string length $line] > $maxwidth} {
#	set maxwidth [string length $line]
#    }

    frame $win.$k
    pack  $win.$k

    label $win.$k.name -text $line -relief raised -width 35
    pack  $win.$k.name -side left -expand 1 -fill x
                 
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
    
    set case_name [gets $lisp]
    set case_elt [gets $lisp]
    set case_message [gets $lisp]

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
}


proc UpdateFirst { } {
    global lisp TabCase PointerCase
    
    set case_name [gets $lisp]
    set case_elt [gets $lisp]
    set case_message [gets $lisp]

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

proc RestartCases { } {
    global lisp 

    puts $lisp "(progn (user::init-guiding) 0)"
    
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
}

proc LoadCases { } {
    global lisp cur_win maxwidth

    lisp_command "(user::load-cases)"
    puts $lisp "(progn (user::load-cases-tcl) 0)"

    set line [gets $lisp]
    while {$line != " 0"} {
        if {[string compare $line "Load-case"] == 0} {
    	    puts "Received Load-case from Lisp"
	    ReceiveCase
            puts "Writing now in window $cur_win"
    	    update idletasks
        } elseif {[string compare $line "Mark-first"] == 0} {
    	    puts "Marking first node"
    	    UpdateFirst
    	} else {
    	    EnterCaseElt $line
	    puts stdout "Got line $line"
        }
        set line [gets $lisp]
    }
#    .w$cur_win configure -width [expr $maxwidth * 16]
}


#***** Funcoes utilizadas para simulacao    
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





