# Procedure mkDebug establishes the debug window. The debug window monitors the
# current value of the global variable debug_msg. The programmer can then 
# change this value to display messages. Using calls to monitorVar, the 
# programmer can also have other variables displayed in the debug window. 
# The programmer can manually add monitor variables by calling the procedure
# monitorVar in a script, or a frame in the debug window allows him to 
# automatically add new variabled at run time. 
#
# Another frame in the debug window allows the user to write lisp commands to 
# the lisp stream and subsequently to read the result from lisp into the 
# debug_msg variable (thus it will be displayed at the top of the debug window).
#
# Another frame has an entry widget that lets the user issue tcl commands. 
# Anything returned by the command will be displayed by setting the debug_msg var.
#
# Finally, a button at the bottom of the window allows the programmer to remove
# the debugging window.
#
proc mkDebug {dw} {
    global debug_msg lisp active_buttons debug_window

    #Debug Window
    toplevel $dw
    wm title $dw " Debug Window "
    wm iconname $dw "Debugger"

    frame $dw.cf -relief raised -bd 1 
    pack  $dw.cf -side top -fill x
    message $dw.cf.msg -justify center -aspect 250 -textvariable debug_msg
    pack $dw.cf.msg

#####
# Lisp Frame
#####
    frame $dw.lisp -relief raised -bd 1 
    pack  $dw.lisp -side top -fill both

    label $dw.lisp.label -text "Lisp Command:" 
    set lcommand ""
    entry $dw.lisp.entry -width 30 -textvariable lcommand -relief sunken
    pack  $dw.lisp.label -side left
    pack  $dw.lisp.entry -side left
    focus $dw.lisp.entry
    bind  $dw.lisp.entry <Return> "focus $dw.lisp.entry"

    button $dw.lisp.readlisp -text "Read LISP Stream" -relief raised -bd 2 \
	    -command "gets $lisp debug_msg"
    pack  $dw.lisp.readlisp -side top -pady 10 -padx 10
    button $dw.lisp.writelisp -text "Write LISP Stream" -relief raised -bd 2 \
	    -command {
	lisp_blat [eval concat $lcommand]
    }
    pack  $dw.lisp.writelisp -side top -pady 10 -padx 10


#####
# Tcl Frame
#####
    frame $dw.tcl -relief raised -bd 1 
    pack  $dw.tcl -side top -fill both

    label $dw.tcl.label -text "Tcl Command:" 
    set tcommand ""
    entry $dw.tcl.entry -width 30 -textvariable tcommand -relief sunken
    pack  $dw.tcl.label -side left
    pack  $dw.tcl.entry -side left
    bind  $dw.tcl.entry <Return> "focus $dw.tcl.entry"

    button $dw.tcl.writetcl -text "Issue Tcl Command" -relief raised -bd 2 \
	    -command {
	set debug_msg [eval $tcommand]
    }
    pack  $dw.tcl.writetcl -side top -pady 10 -padx 10


#####
# Add Var Frame
#####
    frame $dw.var -relief raised -bd 1 
    pack  $dw.var -side top -fill both

    label $dw.var.label -text "Tcl Variable:" 
    set new_var ""
    entry $dw.var.entry -width 30 -textvariable new_var -relief sunken
    pack  $dw.var.label -side left
    pack  $dw.var.entry -side left
    bind  $dw.var.entry <Return> "focus $dw.var.entry"

    button $dw.var.addvar -text "Monitor Variable" -relief raised -bd 2 \
	    -command {
	monitorVar $new_var
    }
    pack  $dw.var.addvar -side right -pady 10 -padx 10


#####
# Bottom Frame
#####
    frame $dw.bot -relief raised -bd 1 
    pack  $dw.bot -side top -fill both

    button $dw.bot.cancel -text "Remove Window" -relief raised -bd 2 \
	    -command {
	$active_buttons(debug) configure -state normal
	destroy $debug_window
    }
    pack  $dw.bot.cancel -side left -pady 10 -padx 10

    button $dw.bot.flush -text "Flush Socket" -relief raised -bd 2 \
	    -command flush_socket
    pack  $dw.bot.flush -side right -pady 10 -padx 10
}

# Procedure monitorVar is used to display the value of a global variable in the
# debug window. The variable's current value is updated anytime it changes.
#
proc monitorVar {var_name} {
    global debug_window var_counter 

    incr var_counter
    label $debug_window.cf.label$var_counter -text "$var_name: " 
    message $debug_window.cf.msg$var_counter -textvariable $var_name
    pack $debug_window.cf.label$var_counter $debug_window.cf.msg$var_counter \
	    -side left  -pady 10 -padx 10
}



