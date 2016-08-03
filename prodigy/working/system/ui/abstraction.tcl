# This file contains the code to interface the UI with the Alpine code.
#
# Note that Eugene's version of Prodigy will automatically create abstractions
# if the :use-abs-type flag is set. Be careful then about assumption below. 
# Come back to finish and make consistent. 

#Still need to work out how abstraction will be displayed in UI.
#
proc showAbstractionHierarchy {} {
    lisp_command "(show-abstraction)"
}

proc makeAbstractionHierarchy {} {
    global prodigyvar
    global hierarchy_type

    switch $prodigyvar(abstractiontype) {
	independent {
	    lisp_command "(gen-problem-independent)"
	    set hierarchy_type independent
	}
	dependent {
	    lisp_command "(gen-problem-dependent)"
	    set hierarchy_type dependent
	}
	nil {
	    mkErrorDialog .error "No Abstraction Type Selected"
	}
    }
    lisp_command "()"
}

proc clearAbstractionHierarchy {} {
    global hierarchy_type

    switch $hierarchy_type {
	independent {
	    lisp_command "(clear-problem-independent)"
	}
	dependent {
	    lisp_command "(clear-problem-dependent)"
	}
	none {
	    mkErrorDialog .error "No Abstraction Hierarchy Exists"
	}
    }
    set hierarchy_type none
}


#============================================================================
proc setAbstractionType {w notop} {
    set buttons {"No Abstraction"
	"Problem Independent" "Problem Dependent"}
    set varvals {"nil" "independent" "dependent"}
    mkRadioListBox $w "Abstraction Type" abstractiontype $buttons $varvals $notop
}

#============================================================================
proc setAbstractionLevel {w notop} {
    set buttons {"True ( hierarchical goal preference)"
	"False"}
    set varvals {"t" "nil"}
    mkRadioListBox $w "Abstraction Level" abstractionlevel $buttons $varvals $notop
}


# The default display is no display with no text. The procedure removes the
# display in this case and if the planning_mode ois not abstraction. This
# occurs when changing from abstraction to any other. See changePlanningMode in
# file ui-start.tcl.
#
proc displayAbsType {{msg ""} {no_display 1}} {
    global abs_line 
    global planning_mode
    
    if {[string compare $planning_mode "abstraction"] == 0} {
	if {$no_display == 1} {
	    $abs_line configure -relief flat -text ""
	} else {
	    $abs_line configure -relief sunken -text "Abstraction Type: $msg "
	}   
    } else {
	$abs_line configure -relief flat -text ""
    }
}
