# Simple menu function 

# Reads in the prompt and choices, displays the menu and returns the
# result to lisp.
proc showMenu {{w .m1}} {
    global lisp response
    set instream $lisp
    set response no_response
    catch {destroy $w}
    toplevel $w
    #dpos $w
    set wtitle [gets $instream]
    wm title $w $wtitle
    wm iconname $w "User Menu"
    wm geometry $w +700+55
    message $w.prompt -font -adobe-times-medium-i-normal--*-140* -aspect 500 \
	    -text [gets $instream]
    
    frame $w.frame -borderwidth 10
    frame $w.frame2
    frame $w.frame3
    frame $w.frame4
    frame $w.frame5
    pack $w.prompt -side top
    pack $w.prompt -side top
    pack $w.frame -side top -fill x -pady 5
    pack $w.frame5 -side bottom -fill x
    pack $w.frame4 -side bottom -fill x
    pack $w.frame3 -side bottom -fill x
    pack $w.frame2 -side bottom -fill x
    set value 0
    for {set readlines 1} {$readlines == 1} {} {
	set line [gets $instream]
        #puts "Menu read $line\n"
	if {[string compare $line "User_end"] == 0} {
	    set readlines 0
	} else {
	    radiobutton $w.frame.b$value -text $line \
		    -variable response -value $value
	    pack $w.frame.b$value -side top -pady 2 -anchor w
	    incr value
	}
    }
    button $w.frame2.ok -text OK -command "report $w" -width 12
    pack $w.frame2.ok -side left -expand yes -fill x

    button $w.frame3.don -text "Don't Know" -width 12 -command "report1 $w"
    pack $w.frame3.don -side left -expand yes -fill x

    button $w.frame4.res -text Resume -width 12 -command "report2 $w"
    pack $w.frame4.res -side left -expand yes -fill x

    button $w.frame5.res -text "Show state" -width 12 -command showState
    pack $w.frame5.res -side left -expand yes -fill x

}

proc report1 {w} {
    global response
    set response -1
    report $w
}

proc report2 {w} {
    global response prodigyvar
    set response -2
    set prodigyvar(user_control) "nil"
    report $w
}

proc report {w} {
    global response lisp
    # Don't return until a variable has been picked.
    if {$response != "no_response"} {
	wm withdraw $w
	destroy $w
	#puts stdout "Value from report is $response"
	# This ":cont" is needed because the menu starts a sub-server
	puts $lisp ":cont"
	puts $lisp $response
	flush $lisp
	update idletasks
	runLoop
    }
}


# Main loop just waits for menu choices
proc Waitformenu {} {
    global instream
    set line [gets $instream]
    if {[string compare $line "Start-user-choice"] == 0} {
	showMenu 
	update idletasks
    } else { 
	puts stdout "Got line $line - ending\n"
	destroy .}
}

# Make a top-level text window for the state.
proc showState {{w .statewin}} {
    global lisp
    catch {destroy $w}
    toplevel $w
    wm title $w "Current State"
    wm geometry $w +900+55
    frame $w.frame -borderwidth 10
    frame $w.buts    
    pack $w.frame -side top -fill x -pady 10
    pack $w.buts -side bottom -fill x
    text $w.frame.text -relief raised -bd 2 \
      -yscrollcommand "$w.frame.scroll set" \
      -font -adobe-helvetica-bold-r-*-*-16-*-*-*-*-*-*-*
    scrollbar $w.frame.scroll -relief sunken -command "$w.frame.text yview"
    # Ask for the data and read it in (need the sub-server for this).
    lisp_flush
    lisp_blat "(progn (dolist (i (p4::give-me-nice-state)) \
                          (send-to-tcl (goal-string i))) 0)"
    set lines 0
    set maxwidth 0
    for {set line [gets $lisp]} {$line != " 0"} {} {
	incr lines
	if {[string length $line] > $maxwidth} {
	    set maxwidth [string length $line]
	}
	$w.frame.text insert end "$line\n"
	set line [gets $lisp]
    }
    # Gotta use the scrollbar at some point:
    if {$lines > 20} {set lines 20}
    $w.frame.text configure -height [expr $lines+2] -width [expr $maxwidth+4]
    pack $w.frame.text -side left -in $w.frame -expand 1 -fill both
    pack $w.frame.scroll -side right -fill y -in $w.frame
    button $w.buts.ok -text OK -command "wm withdraw $w
                                         destroy $w" -width 12
    pack $w.buts.ok -side left -expand yes -fill x
}
