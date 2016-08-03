
#!/afs/cs/project/theo-7/tcl-tk/bin/dpwish -f

#set ui_home /afs/cs/project/prodigy/version4.0/working/system/ui

# Load the code to do the communications
#source $ui_home/tolisp.tcl

#start_up_connection

# Change to $lisp to read from lisp


# Reads in the prompt and choices, displays the menu and returns the
# result to lisp.
proc showMenu {{w .m1}} {
    global lisp response
    set instream $lisp
    set response no_response
    puts "Allo\n"
    catch {destroy $w}
    toplevel $w
    #dpos $w
    set wtitle [gets $instream]
    wm title $w $wtitle
    wm iconname $w "TCL Menu"
    wm geometry $w +55+55
    message $w.prompt -font -Adobe-times-medium-r-normal--*-180* -aspect 300 \
	    -text [gets $instream]
    
    frame $w.frame -borderwidth 10
    frame $w.frame2
    pack $w.prompt -side top
    pack $w.prompt -side top
    pack $w.frame -side top -fill x -pady 10
    pack $w.frame2 -side bottom -fill x
    set value 0
    for {set readlines 1} {$readlines == 1} {} {
	set line [gets $instream]
        puts "Menu read $line\n"
	if {[string compare $line "User_end"] == 0} {
	    set readlines 0
	} else {
	    radiobutton $w.frame.b$value -text $line \
		    -variable response -value $value
	    pack $w.frame.b$value -side top -pady 2 -anchor w
	    incr value
	}
    }
    puts "building menu\n"
    update idletasks
    button $w.frame2.ok -text OK -command "report $w" -width 12
    pack $w.frame2.ok -side left -expand yes -fill x
    update idletasks
}

proc report {w} {
    global response lisp run_suspended
    puts stdout "Value from report is $response"
    #lisp_send $response
    #runLoop
    puts $lisp $response
    gets $lisp
    set run_suspended 0
    #wm withdraw $w
    #destroy $w
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

wm withdraw .
Waitformenu


