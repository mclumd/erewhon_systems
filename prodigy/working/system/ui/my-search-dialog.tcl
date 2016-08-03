# Enhanced node display window, done by Jim, May 97.
# This opens a window in which the user can click on any structure
# to recursively open a window to explore it.

proc search_node_dialog {global_var dw title text default OK_but arguments} {
    global $global_var
    global lisp
    global button
    global basefont
    global slotForm objectForm node_name globCounter


    set frame [lisp_object_dialog $global_var $dw $title $text \
		   $OK_but "set $global_var 0"]
    # Create a row of buttons at the bottom of the dialog
    set i 1
    foreach but $arguments {
	button $frame.button$i -text $but -command "set $global_var $i"
	if {$i == $default} {
	    frame $frame.default -relief sunken -bd 1 
	    raise $frame.button$i
	    pack $frame.default -side left -expand 1 -padx 3m -pady 2m
	    pack $frame.button$i -in $dw.bot.default -side left -padx 2m\
		-pady 2m -ipadx 2m -ipady 1m
	} else {
	    pack $frame.button$i -side left -expand 1 -padx 3m\
		-pady 3m -ipadx 2m -ipady 1m
	}
	incr i
    }
    
    button $frame.button$i -text "Show Plist" -command "set $global_var $i"
    pack $frame.button$i -side left -expand 1 -padx 3m\
	-pady 3m -ipadx 2m -ipady 1m
    
    # Set up a binding for <Return>, if there's a default, set a grab
    # and claim the focus too.
    if {$default >=0} {
	bind $dw <Return> "$dw.bot.button$default flash;\
	set $global_var $default"
    }
    tkwait visibility $dw
    set oldFocus [focus]
    #  grab set $dw
    #focus $dw
    bind $dw <Enter> {focus %W}
    
    #Wait for the user to respond, then restore the focus and return the 
    #index of the selected button.
    set flag 0
    while {$flag == 0} {
	tkwait variable $global_var

	if {[set $global_var] == $i} {
	    set accessor "p4::nexus-plist ( $objectForm($global_var) ) "
	    lisp_blat "(compute-expression-4-tcl ( $accessor ))"
	    gets $lisp line
	    # dialog .plist "Property List for Node $node_name" $line "" 0 OK
	    # Replace with something that can be navigated.
	    set data [lreplace $line 0 0 $accessor]
	    lisp_object_dialog tempvar$globCounter .lispobj$globCounter\
		"Property List for Node $node_name" $data "Ok" \
		"destroy .lispobj$globCounter"
	} else {
	    set flag 1
	}   }
    destroy $dw    
    focus $oldFocus
    return [set $global_var]
}

proc lisp_object_dialog {global_var dw title text OK_but OK_command} {
    global $global_var
    global lisp
    global button
    global basefont
    global slotForm objectForm
    
    # Create the top level window and divide it into top and bottom parts.
    
    catch "destroy $dw"
    
    toplevel $dw -class Dialog
    wm title $dw $title
    wm iconname $dw Dialog
    wm geometry $dw +375+375
    frame $dw.top 
    canvas $dw.top.c -relief raised -bd 1 -scrollregion "0 0 375 375"\
	-yscrollcommand "$dw.top.vscroll set"
    scrollbar $dw.top.vscroll -relief sunken -command "$dw.top.c yview"
    pack $dw.top.vscroll -side right -fill y
    pack $dw.top.c -expand yes -fill both
    pack $dw.top -side top -fill both
    frame $dw.bot -relief raised -bd 1 
    pack $dw.bot -side bottom -fill both
    
    # Fill the top part with the messages.
    
    set i 0
    set y 10
    set margin 20
    set c $dw.top.c
    set objectForm($global_var) [lindex $text 0]
    foreach item [lrange $text 1 end] {
	incr i
	#message $dw.top.msg$i -width 3i -text $item -font $basefont
	#pack $dw.top.msg$i -side top -expand 1 -fill both \
	    \#-padx 3m -pady 5
	if {$i == 1} {
	    set last [$c create text 200 $y -text $item -font $basefont \
			  -anchor n -width 3i -tags "text$i title"]
	} else {
	    $c create text 10 $y -text [lindex $item 1] -font $basefont \
		-anchor nw -tags "slot text$i slot$i"
	    set last [$c create text 30 [expr $y + $margin] \
			  -text [lrange $item 2 end] -font $basefont \
			  -anchor nw -width 3i -tags "val text$i val$i"]
	    set slotForm(${global_var},$last) [lindex $item 0]
	}
	set bb [$c bbox $last]
	set y [expr [lindex $bb 3] + $margin]
    }
    if {$y < 600} {
	$c configure -height $y
    } else {
	$c configure -height 600
    }
    $c configure -scrollregion "0 0 375 $y"
    set node_name [lindex [lindex $text 1] 1]
    $c bind val <Any-Enter> "enterVal $c"
    $c bind val <Any-Leave> "leaveVal $c"
    $c bind val <Button>    "valButton $c $global_var"
    
    button $dw.bot.button0 -text $OK_but -command $OK_command
    frame $dw.bot.default -relief sunken -bd 1 
    raise $dw.bot.button0
    pack $dw.bot.default -side left -expand 1 -padx 3m -pady 2m
    pack $dw.bot.button0 -in $dw.bot.default -side left -padx 2m\
	-pady 2m -ipadx 2m -ipady 1m
    
    # Return the bottom frame so a calling procedure can add more buttons.
    return $dw.bot
}

proc enterVal {canvas} {
    global currentValId
    set currentValId [$canvas find withtag current]
    $canvas itemconfigure $currentValId -fill red
}

proc leaveVal {canvas} {
    global currentValId 
    $canvas itemconfigure $currentValId -fill black
    set currentValId -1
}

set globCounter 0

proc valButton {canvas global_var} {
    global currentValId objectForm slotForm lisp globCounter
    
    lisp_blat "(setf *tcl-item* ( $objectForm($global_var) ))"
    gets $lisp
    lisp_blat "(compute-expression-4-tcl ( setf *last-item* ( $slotForm(${global_var},$currentValId) )))"
    gets $lisp line
    if {$line == ":ERROR"} {
    } elseif {$line == " UNKNOWN-ITEM-TYPE"} {
    } else {
	# Build up the accessor for this object from its slot descriptor
	# (and ignore the accessor passed by lisp) (brackets are added later)
	set accessor "let ((*tcl-item* ( $objectForm($global_var) ))) ( $slotForm(${global_var},$currentValId) )"
	set new [lreplace $line 0 0 $accessor]
	# Need a nice way to generate unique variable names.
	lisp_object_dialog tempvar$globCounter .lispobj$globCounter \
	    "Lisp Object" $new "Ok" "destroy .lispobj$globCounter"
	incr globCounter
    }
}
