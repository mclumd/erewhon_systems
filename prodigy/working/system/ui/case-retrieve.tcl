
#=========================
#    JASON L REISMAN 
#    15-589
# 
# Significantly modified by Michael Cox
#
#=========================


set goal_num 2
set thresh 0.6
set original_g_num $goal_num
set original_thresh $thresh


# Procedure selectMatchParams is called when the user selects either automatic 
# or manual case retrieval from the Analogy-specific buttons along the 
# bottom of the UI. Its side-effect is to set the global match parameters 
# goal_num and thresh which is passed to Lisp when executing the function 
# auto-use-cases. Its return value is either OK or Cancel, depending on whether
# or not the user aborts the procedure. 
#
# [cox 15jul97] goal_num no longer to be a user set parameter. Instead take 
# from the number of goals in the current problem. Commented out code for Goal
# Number Frame below.
#
proc selectMatchParams {} {
    global analogy_domain_needs_loading
    global goal_num thresh
    # Unfortunately because the accessing of these variabels is done in the 
    # command clause of the botton statement below, they cannot be seen locally.
    global original_g_num original_thresh 
    global return_val

    #Goal number set to the number of goals in the current problem.
    set goal_num \
	    [lisp_command \
	    "(length (get-lits-no-and (p4::problem-goal (current-problem))))"]
    set original_g_num $goal_num
    set original_thresh $thresh

    set winfont  -adobe-times-medium-r-normal--*-140-*

    if {$analogy_domain_needs_loading == 1} {
	mkErrorDialog .error {"Please select a problem with the LOAD button."}
    } else {

	#Auto Retrieve Window
	toplevel .arw
	wm title .arw " Match Parameters "
	wm iconname .arw "Match Args"

	#Goal Number frame
#	frame .arw.gn -relief raised -bd 1 
#	pack  .arw.gn -side top -fill x
#	label .arw.gn.label -text "Goal Number for Problem:" -font $winfont
#	entry .arw.gn.entry -width 5 -textvariable goal_num -font $winfont \
#		-relief sunken
#	pack  .arw.gn.label -side left
#	pack  .arw.gn.entry -side left

	#Match Threshold frame
	frame .arw.mt -relief raised -bd 1 
	pack  .arw.mt -side top -fill x
	label .arw.mt.label -text "Match Threshold \[0-1.0\]:" -font $winfont
	entry .arw.mt.entry -width 5 -textvariable thresh -font $winfont \
		-relief sunken
	pack  .arw.mt.label .arw.mt.entry -side left
	bind  .arw.mt.entry <Return> {focus .arw.mt.entry}

	frame .arw.bot -relief raised -bd 1 
	pack  .arw.bot -side top -fill both

	focus .arw.mt.entry
#	bind  .arw.gn.entry <Return> {focus .arw.gn.entry}

	button .arw.bot.ok -text OK -relief raised -bd 2 -font $winfont \
		-command {
	    set return_val OK
	    destroy .arw 
	}
	button .arw.bot.cancel -text Cancel -relief raised -bd 2 -font $winfont \
		-command {
	    #Restore values.
	    set goal_num $original_g_num
	    set thresh $original_thresh
	    set return_val Cancel
	    destroy .arw
	}  
	pack  .arw.bot.ok .arw.bot.cancel -side left  -pady 10 -padx 10
    }
}


# Called when user selects "Auto Case Retrieval" from lower row of buttons on
# the User Interface.
#
proc autoRetrieveCases {} {
    global goal_num thresh
    global return_val

    selectMatchParams
    tkwait variable return_val
    if {[string compare $return_val OK] == 0} {
	lisp_send "(auto-use-cases '$goal_num '$thresh)"
	lisp_receive
	LoadCases
    }
}


# Called when user selects "Manual Case Retrieval" from lower row of buttons on
# the User Interface.
#
proc retrieveCases pwind {
    global goal_num thresh
    global xgeometry ygeometry
    global analogy_domain_needs_loading
    global world_path domain_name
    global selected
    global return_val
    global Wd
    global mw

    set selected {}

    if {$analogy_domain_needs_loading == 1} {
	mkErrorDialog .error {"Please select a problem with the LOAD button."}
    } else {
	# selectMatchParams sets the match parameters goal_num and thresh. 
	# It also sets the value of return_val to either OK or Cancel.
	selectMatchParams
	tkwait variable return_val
	if {[string compare $return_val Cancel] == 0} {
	    return
	}

    #========================
    # CASE FRAME DEFINITION
    #========================
    #main window
    set mw .mw1 
    catch { destroy $mw }
    toplevel $mw
    checkGeometry $pwind
    wm geometry $mw "+[expr $xgeometry+25]+[expr $ygeometry+75]"
    wm title $mw " Manual Case Retrieval "
    wm iconname $mw "Manual Retrieve"

    #frame $mw
    #label $mw.wd -fg white -bg midnightblue -text $world-path -textvariable Wd
    if {$domain_name == "None"} {
	set Wd $world_path
    } else {set Wd $world_path$domain_name}
    label $mw.wd -textvariable Wd

    # THE LISTBOX THAT CONTAINS ALL THE DOMAIN DIRECTORIES / CASES (IN THE CASE FRAME)

    listbox $mw.files -relief raised -borderwidth 2 -bg ivory \
	    -yscrollcommand "$mw.scroll set"
    scrollbar $mw.scroll -command "$mw.files yview"


    #===========================
    # SELECTED FRAME DEFINITION
    #===========================

    frame $mw.t 
    #label $mw.t.label -fg white -bg midnightblue -text "Selected Cases"
    label $mw.t.label -text "Selected Cases"
    listbox $mw.t.selected -relief raised -borderwidth 2 -bg ivory \
	    -yscrollcommand "$mw.t.scroll set"
    scrollbar $mw.t.scroll -command "$mw.t.selected yview"


    # SPACER IS A SEPARATOR BETWEEN THE FRAMES
    frame $mw.spacer 
    #label $mw.spacer.name -bg gray30
    label $mw.spacer.name 

    #===========================
    #          BUTTONS
    #===========================

    button $mw.open -text "View Selected" -command {
	if {[file isdirectory [selection get]] == 0} {
	    textview $Wd/[selection get]
	}
    }


# put the UI-connection right here

global my_args
set my_args  ""

button $mw.bye -text "Load Selected Cases" -command {
    set my_args  ""
#    lisp_flush
    foreach i $selected {
	set my_args  "$my_args \'$i"
    }
    lisp_send "(use-cases $goal_num $thresh $my_args)" 
    lisp_receive
}

button $mw.t.remove -text "Remove Case" -command {
    set delthis [lsearch $selected [selection get]]
    set selected [lreplace $selected $delthis $delthis]
    $mw.t.selected delete 0 end
    foreach i $selected {
	$mw.t.selected insert end $i
    }
}

button $mw.select -text "Select Case" -command {
    set selected [linsert $selected [llength $selected] [selection get]]
    $mw.t.selected delete 0 end
    foreach i $selected {
	$mw.t.selected insert end $i
    }
}

#button $mw.t.savecase -text "Save Case" -command {
#   lisp_flush
#   lisp_send "(princ (quote XYZ))"
#}

button $mw.t.done -text "Done" -command {
    LoadCases
    destroy $mw
}

button $mw.t.cancel -text "Cancel" -command {
    destroy $mw
}


#=============================
# BINDINGS
#=============================

# DOUBLE CLICKING A DIRECTORY IN THE CASE FRAME WILL RESULT IN OPENING THAT DIRECTORY
# DOUBLE CLICKING A FILE IN THE CASE FRAME WILL RESULT IN SELECTING THAT FILE

bind $mw.files <Double-Button-1> {
    if {[file isdirectory [selection get]] ==1} {
	my_update [selection get]
	set Wd [pwd]
    } else {
	set selected [linsert $selected [llength $selected] [selection get]]
	$mw.t.selected delete 0 end
	foreach i $selected {
	    $mw.t.selected insert end $i
	}
    }
}

# CLICKING WITH BUTTON 3 IN THE CASE FRAME WILL SELECT THAT CASE

bind $mw.files <Button-3> {
    set selected [linsert $selected [llength $selected] [selection get]]
    $mw.t.selected delete 0 end
    foreach i $selected {
	$mw.t.selected insert end $i
    }
}

# DOUBLE CLICKING IN THE SELECTION FRAME WILL RESULT ON VIEWING THAT CASE FILE

bind $mw.t.selected <Double-Button-1> {
    if { [file exists [selection get]] == 1 } {
	textview [selection get]
    }
}

# CLICKING WITH BUTTON 3 IN THE SELECTION FRAME WILL RESULT IN REMOVING THAT SELECTION

bind $mw.t.selected <Button-3> {
    set delthis [lsearch $selected [selection get]]
    set selected [lreplace $selected $delthis $delthis]
    $mw.t.selected delete 0 end
    foreach i $selected {
	$mw.t.selected insert end $i
    }
}


#======================
# PACK IT UP
#======================

pack $mw.t -side right -fill y
pack $mw.t.label -fill x -side top
pack $mw.t.scroll  -side right -fill y
pack $mw.t.selected -side top -fill x
pack $mw.t.remove -fill x
#pack $mw.t.savecase -fill x
pack $mw.t.done -fill x
pack $mw.t.cancel -fill x

pack $mw.spacer -side right -fill y
pack $mw.spacer.name -fill y

#pack $mw -side left
pack $mw.wd -side top -fill x
pack $mw.files -fill x
pack $mw.scroll -side right -fill y
pack $mw.open -fill x
pack $mw.select -fill x 
pack $mw.bye -side bottom -fill x

#GET IT GOING
if {$domain_name == "None"} {
    startup $world_path
} else {
    my_update $world_path$domain_name
    set Wd [pwd]
} 
foreach i $selected {
    $mw.t.selected insert end $i
}
}
}

#============================
#          PROCS
#============================

# EACH TIME YOU GO BACK A DIRECTORY YOU WILL WIND UP AT STARTUP
# STARTUP RETURNS TO THE STARTUP DIRECTORY AND LISTS ALL DIRECTORIES THERE
proc startup path {
    global mw

    cd $path
    $mw.files delete 0 end
    foreach i [lsort [glob *]] {
	if {[file isdirectory $i] == 1} {
	    $mw.files insert end $i/
	} else {
	    $mw.files insert end $i
	}
    }
}

# UPDATES THE LISTBOX TO THE CASES OF THE SELECTED DOMAIN DIRECTORY
proc my_update cdd {
    global mw
    if {[string compare $cdd "../"] == 0} {
	startup "../../../.."
    } else {
	cd $cdd/probs/cases/headers
	$mw.files delete 0 end
	$mw.files insert end "../"
	foreach i [lsort [glob *]] {
	    if {[file isdirectory $i] == 1} {
		$mw.files insert end $i/
	    } else {
		$mw.files insert end $i
	    }
	}
    }
}

# PROCESS THAT ALLOWS THE USER TO VIEW THE CONTENTS OF A CASE FILE
proc textview filename {
    toplevel .textview
    label .textview.name -fg white -bg midnightblue -text $filename
    text .textview.text -relief raised -bd 2 -yscrollcommand ".textview.scroll set"
    scrollbar .textview.scroll -command ".textview.text yview"
    
    pack .textview.name -side top -fill x
    pack .textview.scroll -side right -fill y
    pack .textview.text -side top
    
    set f [open $filename]
    while {![eof $f]} {
	.textview.text insert end [read $f 1]
    }
    close $f
    
    button .textview.killtext -text Done -command "destroy .textview"
    pack .textview.killtext -fill x
}


