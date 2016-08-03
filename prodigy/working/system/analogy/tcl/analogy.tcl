#!/afs/cs/project/theo-7/tcl-tk/bin/dpwish -f

#******** Manuela, este conjunto de instrucoes so' e' utilizado para simulacao e deve ser retirado
#         quando for colocado no prod-ui
set ui_home /afs/cs/project/prodigy/version4.0/working/system/ui
source $ui_home/tolisp.tcl
source /afs/cs/user/ledival/prodigy/ui/simu.tcl
start_up_connection
set boldfont  -adobe-times-medium-r-normal--*-140-*
set basefont  -adobe-times-medium-r-normal--*-140-*
set obliquefont  -adobe-times-medium-i-normal--*-140-*

#**********


set TabCase ""
set PointerCase ""
set w 0
set k 1

proc ReceiveCase {} {
    global lisp TabCase PointerCase w k cur_win 
    global win

    set line [gets $lisp]
    set TabCase [linsert $TabCase [llength $TabCase] $line]
    set PointerCase [linsert $PointerCase [llength $PointerCase] 0]
    set cur_win $w
    incr w    
    update idletasks

    set k 1
    set win .w$cur_win

    toplevel $win
    wm minsize $win 50 50

    wm title $win Case:

    if {$cur_win > 0} {
        set previous [wm geometry .w[expr $cur_win -1]]
        scan $previous "%dx%d+%d+%d" wid h x y
        incr x 5
        wm geometry $win +[expr $x + $wid]+$y
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

proc CloseAll {} {
    global TabCase

    for {set i 0} {$i < [llength $TabCase]} {incr i} {
         destroy .w$i
    }
}

proc EnterCaseElt {line} {
    global win k cur_win

    set win .w$cur_win

    frame $win.$k
    pack  $win.$k

    label $win.$k.name -text $line -relief raised -width 35 
    pack  $win.$k.name -side left -expand 1 -fill x
                 
    label $win.$k.mark -text "" -width 5
    pack  $win.$k.mark -side left
    incr k
}

proc CleanCase {} {
    
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
        label .w$pos.$cur_pointer_pos.mark -text "**" -width 5
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

    destroy .w$pos.$case_elt.name
    label .w$pos.$case_elt.name -text $case_text -relief raised -width 20
    pack  .w$pos.$case_elt.name -side left

    destroy .w$pos.$case_elt.mark
    label .w$pos.$case_elt.mark -text "" -width 5
    pack  .w$pos.$case_elt.mark -side left

}

proc ProcessCases {} {
    global lisp cur_win
    puts "...waiting for lisp...."

    set line [gets $lisp]
    while {$line != "DONE"} {
        if {[string compare $line "Load-case"] == 0} {
    	    puts "Received Load-case from Lisp"
	    ReceiveCase
            puts "Writing now in window $cur_win"
    	    update idletasks
        } else {
    	    EnterCaseElt $line
	    puts stdout "Got line $line"
        }
    set line [gets $lisp]
    }
}

wm withdraw .
ProcessCases

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





