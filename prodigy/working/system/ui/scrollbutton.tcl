#============================================================================
# History
#

# 29dec96 Michael Cox. The original scrollButton procedure was created by
#         J. Blythe. It was not completed, but rather called lisp function
#         find-node # and so displayed the node in the lisp listener. This file
#         extends the # function to display the node in a separate dialog box
#         of the UI. See also # file x-analogy-support.lisp.
#
# 17jun97 Added viewSearchNode procedure and added it to the View pull-down
#         menu. This procedure allows the user to access directly a search tree
#         node. [cox]


#============================================================================
#
# Procedure scrollButton is called if you click on a node in the goal tree 
# canvas. The procedure displays the current node. It presents the 
# corresponding search tree node and itemizes the following information about  
# the node. All nodes list the type of search tree decision, the node number 
# (name), the main value of the node (e.g., for a goal node, the goal structure
#  as displayed in the default print function of the defstruct call in 
# node.lisp), and the termination reason (if present) in the nodes plist. For 
# each node type, additional information is presented that is specific to that 
# type. On the bottom of the display window, buttons are presented to return 
# (the OK button), a button for the node's parent (if not the root node), a 
# button for each child, and a button to display the node's plist in a separate 
# window. 
#
# Note that multiple nodes can be selected and displayed concurrently, but only
# the last node selected will (at the present time) have active buttons. Attempts 
# to select buttons from previous windows result in control of the last selected 
# node instead.
#
#
# Input parameters: 
#   w is the goal tree canvas (and not used by the procedure)
#   b is the button number pressed by the user.
#   manual_number is an optional argument that may be used when calling manually
#     (e.g., from the debug window to examine an arbitrary search tree node.
#
#   See file ui.tcl. The binding is as follows:
#     $f.c bind node <Button>  "scrollButton $f.c %b"
#   
#
# Local variables:
#   node_name - name of the current node in the search tree being examined by 
#     the user.
#   node_expression - the value of node_name as represented in PRODIGY.
#   parent_name - name of the parent of the node_name
#   children_list - list of the names of the children of node_name
#   choice - selection made by the user; either parent, children, plist or OK
#   line - buffer used to read input from lisp
#   no_parent - 1 if current_node has no parent, 0 otherwise
#   no_children - 1 if current_node has no children, 0 otherwise
#
# Prodigy function format-4-tcl takes as input a node name (a number), and 
# returns a list composed of three items. These three items (in order) are
# assigned to the local variables node_expression, parent_name, and 
# children_list described above.
#
#
proc scrollButton {w b {manual_number 0}} {
    global world_path domain_name domain_file
    global currentNode nodes lisp node_name
    if {$manual_number != 0} {
	set node_name $manual_number
    } else {
	set node_name $nodes($currentNode,prodigyID)
    }
    #If user clicks second button
    if {$b == 2} {
	lisp_blat "(binding-node-name-4-tcl $node_name)"
	gets $lisp line
	if {[string compare "NIL" [set line [string trim $line]]] == 0} {
	    mkErrorDialog .error {"Not an operator"} 
	} else {
	    set parsed_op [parse_op $line \
		          "$world_path$domain_name\\$domain_file"]
	    dialog .g$node_name "Operator Definition" \
		    [split_lines $parsed_op] "" 0 Ok
	}
	return 
    }
    lisp_blat "(format-4-tcl $node_name)"
    gets $lisp line
    initVars line \
	     node_expression parent_name children_list no_parent no_children
    if {$no_parent} {
	if {$no_children} {
	    #Case of no parent and no children
	    set choice [dialog .d$node_name           \
		        "Search Tree Node $node_name" \
		        $node_expression "" 0 Ok]
	} else {
	    #Case of children, but no parent
	    set choice [search_node_dialog g_$node_name .d$node_name \
		        "Search Tree Node $node_name"   \
		        $node_expression 0 Ok [make_list $children_list] ]
	    if {$choice != 0} {
		incr choice
	    }
	}
    } else {
	if {$no_children} {
	    #Case of parent, but no children
	    set choice [search_node_dialog g_$node_name .d$node_name \
		        "Search Tree Node $node_name"   \
			$node_expression 0 Ok           \
			[list [list "Parent" $parent_name]] ]
	} else {
	    #Case of parent plus children
	    set choice [search_node_dialog g_$node_name .d$node_name     \
	                "Search Tree Node $node_name"       \
			$node_expression 0 Ok               \
			[linsert [make_list $children_list] \
			         0 [list "Parent" $parent_name]] ]
    }   }
    while {$choice != 0} {
	if {$choice == 1} {
	    set node_name $parent_name
	    lisp_blat "(format-4-tcl $node_name)"
	    gets $lisp line
	    set node_expression [lindex $line 0]
	    set parent_name [string trim [lindex $line 1]]
	    set children_list [string trim [lindex $line 2]]
	    set no_parent [expr [string compare $parent_name "NIL"] == 0]
	    set no_children 0
	    if {$no_parent} {
		set choice [search_node_dialog g_$node_name .d$node_name \
			    "Search Tree Node $node_name"   \
			    $node_expression 0 Ok [make_list $children_list] ]
		if {$choice != 0} {
		    incr choice
		}
	    } else {
		set choice [search_node_dialog g_$node_name .d$node_name     \
		            "Search Tree Node $node_name"       \
		            $node_expression 0 Ok               \
			    [linsert [make_list $children_list] \
			             0 [list "Parent" $parent_name]] ]
	    } 
	} else {
	    # $choice > 1
	    set node_name [nth [expr $choice - 1] $children_list]
	    lisp_blat "(format-4-tcl $node_name)"
	    gets $lisp line
	    set no_parent 0
	    set node_expression [lindex $line 0]
	    set parent_name [string trim [lindex $line 1]]
	    set children_list [string trim [lindex $line 2]]
	    set no_children [expr [string compare $children_list "NIL"] == 0]
	    if {$no_children} {
		set choice [search_node_dialog g_$node_name .d$node_name \
			    "Search Tree Node $node_name"   \
			    $node_expression 0 Ok           \
			    [list [list "Parent" $parent_name]] ]
	    } else {
		set choice [search_node_dialog g_$node_name .d$node_name \
			    "Search Tree Node $node_name"   \
			    $node_expression 0 Ok           \
			    [linsert [make_list $children_list] 0 \
			    [list "Parent" $parent_name]] ]
}   }   }   }


#============================================================================
# Procedure initVars initializes the local variable of procedure scrollButton
# by extracting the first, second, and third items of the list $line and then 
# assigning these items to the variables node_expression, parent_name, and
# children_list respectively. The two flags no_parent and no_children are then 
# set to 0 (false) if their values are not equal to the string "NIL".
#
proc initVars {lineName node_expressionName parent_nameName children_listName 
               no_parentName no_childrenName} {
    upvar $lineName line
    upvar $node_expressionName node_expression
    upvar $parent_nameName parent_name 
    upvar $children_listName children_list 
    upvar $no_parentName no_parent 
    upvar $no_childrenName no_children
    set node_expression [lindex $line 0]
    set parent_name [string trim [lindex $line 1]]
    set children_list [string trim [lindex $line 2]]
    set no_parent [expr [string compare $parent_name "NIL"] == 0]
    set no_children [expr [string compare $children_list "NIL"] == 0]
}



#============================================================================
# The argument children_list is a list of numbers (node names). This procedure 
# creates a list of tuple lists of the form "Child node_num".
#
proc make_list {children_list} {
    set result_list ""
    foreach num $children_list {
	lappend result_list [list "Child" $num]
    }
    set result_list
}
	


#============================================================================
# Modeled after dialog proc from ui.tcl. The difference is that the text is 
# processed as list generating a message widget for each list item and the 
# last argument is a list of arguments to be placed into buttons rather than 
# the special symbol args (which allows arbitrary numbers of final arguments).
# Also, the OK button is explicit and no bitmap is included. 
#
proc search_node_dialog {global_var dw title text default OK_but arguments} {
    global $global_var
    global lisp
    global button
    global basefont

    # Create the top level window and divide it into top and bottom parts.

    toplevel $dw -class Dialog
    wm title $dw $title
    wm iconname $dw Dialog
    wm geometry $dw +375+375
    frame $dw.top -relief raised -bd 1 
    pack $dw.top -side top -fill both
    frame $dw.bot -relief raised -bd 1 
    pack $dw.bot -side bottom -fill both
    
    # Fill the top part with the messages.
    
    set i 0
    foreach item $text {
	incr i
	message $dw.top.msg$i -width 3i -text $item -font $basefont
	pack $dw.top.msg$i -side top -expand 1 -fill both \
		-padx 3m -pady 5
    }
    set node_name [lindex [lindex $text 1] 2]

    #message $dw.top.msg -width 3i -text $text -font $basefont

    button $dw.bot.button0 -text $OK_but -command "set $global_var 0"
    frame $dw.bot.default -relief sunken -bd 1 
    raise $dw.bot.button0
    pack $dw.bot.default -side left -expand 1 -padx 3m -pady 2m
    pack $dw.bot.button0 -in $dw.bot.default -side left -padx 2m\
	    -pady 2m -ipadx 2m -ipady 1m
     
     # Create a row of buttons at the bottom of the dialog
     set i 1
     foreach but $arguments {
        button $dw.bot.button$i -text $but -command "set $global_var $i"
        if {$i == $default} {
            frame $dw.bot.default -relief sunken -bd 1 
            raise $dw.bot.button$i
            pack $dw.bot.default -side left -expand 1 -padx 3m -pady 2m
            pack $dw.bot.button$i -in $dw.bot.default -side left -padx 2m\
 					-pady 2m -ipadx 2m -ipady 1m
        } else {
                pack $dw.bot.button$i -side left -expand 1 -padx 3m\
					-pady 3m -ipadx 2m -ipady 1m
        }
        incr i
      }

      button $dw.bot.button$i -text "Show Plist" -command "set $global_var $i"
      pack $dw.bot.button$i -side left -expand 1 -padx 3m\
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
      
      #Wait for the user to respond, then restore the focus and return the index
      #of the selected button.
      set flag 0
      while {$flag == 0} {
	  tkwait variable $global_var
	  if {[set $global_var] == $i} {
	      lisp_blat "(p4::nexus-plist (find-node $node_name))"
	      gets $lisp line
	      dialog .plist "Property List for Node $node_name" $line "" 0 OK
	  } else {
	      set flag 1
      }   }
      destroy $dw    
      focus $oldFocus
      return [set $global_var]
}



# Given a line of text, recursively count the parens so that one is added 
# for each left paren whereas one is subtracted for each right paren
#
proc parse_line {line} {
    #puts $line
    set found_left [regexp {([^(]*)[(](.*)} $line  match first second]
    set found_right [regexp {([^)]*)[)](.*)} $line  match one two]
    if {$found_left == 1} {
	if {$found_right == 1} {
	    if {[string length $second] > [string length $two]} {
		#puts 1
		return [expr 1 + [parse_line $second]]
	    } else {
		#puts -1
		return [expr [parse_line $two] - 1]
	    }
	} else {
	    #puts 1
	    return [expr 1 + [parse_line $second]]
	}
    } else {
	if {$found_right == 1} {
	    #puts -1
	    return [expr [parse_line $two] - 1]
	} else {
	    #puts 0
	    return 0
	}
    }
}



# Return the definition from file f_name for operator op_name 
# (Added ability to find inference rules too - Jim, July 97)
proc parse_op {op_name f_name} {
    if [catch {open $f_name} f_id] {
	return "Cannot open $f_name"
    }
    set name [string toupper $op_name]
    set found 0
    #while not found and not eof
    while {[expr $found == 0] && [expr [gets $f_id line] >= 0]} {
	if {[regexp -nocase {([^(]*)[(]operator(.*)} \
				  $line  match leading matched_name] == 1 ||
	    [regexp -nocase {([^(]*)[(]inference-rule(.*)} \
				  $line  match leading matched_name] == 1} {
	    set matched_name [string trim $matched_name]
	    #if condition below t then operator name on next line.
	    if {[string length $matched_name] == 0} {
		set temp $line
		#Assume the file does not suddenly end.
		gets $f_id line
		#Hopefully no one puts a comment line before the operator name
		scan $line "%s" matched_name
		set line [concat $temp $line]
	    }
	    if {[string compare [string toupper $matched_name] $name] == 0} {
		set found 1
	    }
	}
    }
    if {$found == 1} {
	set op_def [list $line]
	set paren_count [parse_line $op_def]
	while {$paren_count != 0} {
	    gets $f_id line
	    set paren_count [expr [parse_line $line] + $paren_count]
	    lappend op_def $line
	}
    } else {
	set op_def "{No op found in file} $f_name"
    }
    close $f_id
    return $op_def
}


# Split each element of input list by inserting newlines.
#
proc split_lines {list} {
    set nl \n
    set result {}
    foreach element $list {
	set result $result$nl$element
	#set result [concat $result $element "\<newline>"]
    }
    return $result
}


# Now that this is written, I discover that the lindex procedure would have been 
# easier to use directly. 
#
proc nth {num strg} {
    set result ""
    if {$num < 1} {return ""}
    if {$num == 1} {
	scan $strg %s result
	return $result
    } else {
	scan $strg %s result
	nth [expr $num - 1] \
	    [string range  \
	            $strg  \
	            [expr [string first $result $strg] \
		          + [string length $result]]   \
		    [expr [string length $strg] - 1]]
    }
}

#View an arbitrary search node in the search tree.
#
proc viewSearchNode {} {
    global mainWindow search_node_number return_val

    getNodeNumber
    tkwait variable return_val
    if {[string compare $return_val OK] == 0} {
	set result [lisp_command "(in-search-tree $search_node_number)"]
	if {[string compare $result T] == 0} {
	    scrollButton $mainWindow 1 $search_node_number
	} else {
	    mkErrorDialog .error "Number not in $result"
    }   }   
}


# Procedure getNodeNumber returns the value of either Cancel or OK, depending
# on whether or not the user aborts the procedure. . The node number itself is
# passed by side effect on the global variable search_node_number
#
proc getNodeNumber {} {
    global search_node_number return_val

    set winfont  -adobe-times-medium-r-normal--*-140-*

    #Node Number Window
    toplevel .nnw
    wm title .nnw " Number Query "
    wm iconname .nnw "Num Query"

    #Number frame
    frame .nnw.nf -relief raised -bd 1 
    pack  .nnw.nf -side top -fill x
    label .nnw.nf.label -text "Node Number to Display:" -font $winfont
    entry .nnw.nf.entry -width 5 -textvariable search_node_number \
	    -font $winfont -relief sunken
    pack  .nnw.nf.label -side left
    pack  .nnw.nf.entry -side left

    frame .nnw.bot -relief raised -bd 1 
    pack  .nnw.bot -side top -fill both

    focus .nnw.nf.entry
    bind  .nnw.nf.entry <Return> {focus .nnw.nf.entry}

    button .nnw.bot.ok -text OK -relief raised -bd 2 -font $winfont \
	    -command {
	set return_val OK
	destroy .nnw 
    }
    button .nnw.bot.cancel -text Cancel -relief raised -bd 2 -font $winfont \
	    -command {
	#Restore values.
	set goal_num $original_g_num
	set thresh $original_thresh
	set return_val Cancel
	destroy .nnw
    }  
    pack  .nnw.bot.ok .nnw.bot.cancel -side left  -pady 10 -padx 10
}


# This line overrides the node display function [Jim, May 97]
source $ui_home\\my-search-dialog.tcl
