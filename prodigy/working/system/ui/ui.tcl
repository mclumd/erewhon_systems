#============================================================================
# need to still: 
#                have default vals for running variables
#                have "beautify" button
#                have "view abstraction heirarchy" button
#                help
#                button "dump PS from goal tree"
#                set up functions for showing node information
#                    - left: 
#                    - middle: 
#                    - right: all the prodigy info

# Note that ui-start.tcl is assumed to have been loaded!
# All the globals are in there (so they can be changed in the user's
# customization file).

# History
# 3/17/95 Jim added saba and savta functionality to the "saba" and "default" 
#             buttons. 
#
# jan97   Modified procedures drawOperator and drawGoal to better position ovals 
#         and squares around text. [cox]
#
# 25jan97 Added changePlanningMode2 procedure calls to setup routines [cox]
#
#   jan97 Redefined scrollButton procedure. See file scrollbutton.tcl
#
# 23apr97 Reconciled the code with Kim's UI version that uses the latest 
#         Tcl/Tk [cox]
#
# 21May97 Made the node bounding box work from TCL's judgement of the text 
#         size, not lisps. This is much tighter. [Jim]
#
# 30may97 Added setNodeParams procedure that allows the user to adjust the 
#         parameter settings that influence the spacing of nodes in the goal 
#         tree display. 
#
# 16jun97 Finished fixing linear planning functionality. [cox]
#
#  4aug97 Added clearCanvases function to View pull-down menu. [cox]
#
#  5aug97 Fixed saveCanvas procedure. See comments in the code. [cox]
#
# 19aug97 Created procedures separateGoalTreeCanvas and removeGoalTreeCanvas.
#         This essentially moves the goaltree display to a separate and 
#         independent window of its own. [cox]
#
# 19sep97 Modified saveCanvasFile procedure so that it can be used with the 
#         drawGenericGraphWin code from dot.tcl. Also added code to allow user
#         control of planning decisions. [cox]
#



source $ui_home\\dependantfunctions
source $ui_home\\ui-domain.tcl


#============================================================================
proc mkScroll {w} {
    global domain_name
    global problem_name
    global xgeometry
    global ygeometry
    global display_line domain_line problem_line abs_line
    global helptext
    global topfont basefont
    global special_commands special_commands_label labels commands infotext
    global active_buttons active_menus
    global typeHierarchy partialOrder displaypolygons
    global canvasGoalTree
    global canvasAppliedOps
    global wind
    global help_file_oblique_words help_file_bold_words 
    global debug_window 
    global planning_mode
    global stackedCanvases

    set wind $w
    catch {destroy $w}
    toplevel $w
    wm protocol $w WM_TAKE_FOCUS "checkGeometry $w"
    wm title $w " Prodigy 4.0 "
    wm iconname $w "Prodigy UI"
    wm minsize $w 385 350
#    wm geometry $w +$xgeometry+$ygeometry
    wm geometry $w +230+55

    #========================================================================
    # MENU BAR
    #========================================================================
    frame $w.mbar -relief raised -bd 2 
    menubutton $w.mbar.file -text  File               -menu $w.mbar.file.menu \
	    -font $topfont
    menubutton $w.mbar.rm   -text "Planning Mode"     -menu $w.mbar.rm.menu   \
	    -font $topfont
    menubutton $w.mbar.rv   -text "Control Variables" -menu $w.mbar.rv.menu   \
	    -font $topfont
    menubutton $w.mbar.dv   -text "Display Variables" -menu $w.mbar.dv.menu   \
	    -font $topfont
#    menubutton $w.mbar.special -text Special -menu $w.mbar.special.menu       \
#	    -font $topfont
    menubutton $w.mbar.view -text View -menu $w.mbar.view.menu                \
	    -font $topfont
    menubutton $w.mbar.help -text  Help               -menu $w.mbar.help.menu \
	    -font $topfont

    set helptext($w.mbar.file)    "Invoke File Operations or QUIT"
    set helptext($w.mbar.rm)      "Change Planning Mode"
    set helptext($w.mbar.rv)      "Change Planner Parameters"
    set helptext($w.mbar.dv)      "Change Display Variables"
#    set helptext($w.mbar.special) "Choose Special Functions"
    set helptext($w.mbar.view)    "View Aspects of Problem and Solution"
    set helptext($w.mbar.help)    "Get User Assistance"
    bind Menubutton <Any-Enter> "+ setDisplayLine $w.infoframe.value %W"
    bind Menubutton <Any-Leave> "+ resetDisplayLine $w.infoframe.value %W"

    pack $w.mbar.file    -side left  -padx 2
    pack $w.mbar.rm      -side left  -padx 2
    pack $w.mbar.rv      -side left  -padx 2
    pack $w.mbar.dv      -side left  -padx 2
#    pack $w.mbar.special -side left  -padx 2
    pack $w.mbar.view    -side left  -padx 2
    pack $w.mbar.help    -side right -padx 2
    pack $w.mbar         -side top -fill x

    tk_menuBar $w.mbar $w.mbar.file $w.mbar.rm $w.mbar.rv $w.mbar.dv \
#	    $w.mbar.special \
	    $w.mbar.view $w.mbar.help
    focus $w.mbar

    #========================================================================
    # HELP
    menu $w.mbar.help.menu
    $w.mbar.help.menu add command -label "UI Overview" -command  \
	    { displayFile .helpwin3 "Overview" \
	    "$ui_home\\documents\\overview.txt" \
	    $help_file_oblique_words $help_file_bold_words} -font $basefont
    $w.mbar.help.menu add command -label "PRODIGY Manual" -command \
	    { exec gv \
    "[lindex [lindex [lispVar *prodigy-root-directory*] 0] 0]documents\\main.ps" \& } \
	    -font $basefont
    $w.mbar.help.menu add command -label "UI Manual (v 1.0)" -command \
	    { exec gv "$ui_home\\documents\\ui1.0-manual.ps" \& } \
	    -font $basefont
    $w.mbar.help.menu add command -label "UI Manual (v 2.0)" -command \
	    { exec gv "$ui_home\\documents\\ui-tech-rep.ps" \& } \
	    -font $basefont
    $w.mbar.help.menu add command -label "Prodigy 4.0 Guide" -command \
	    { displayFile .helpwin1 "Guide" \
	    "[lindex [lindex [lispVar *prodigy-root-directory*] 0] 0]documents\\guide" \
	    $help_file_oblique_words $help_file_bold_words} -font $basefont
    $w.mbar.help.menu add command -label "Prodigy/Analogy Guide" -command \
	    { displayFile .helpwin15 "Analogy" \
	    "[lindex [lindex [lispVar *prodigy-root-directory*] 0] 0]documents\\analogy.txt" \
	    $help_file_oblique_words $help_file_bold_words} -font $basefont
    $w.mbar.help.menu add command -label "System Load Sequence" -command \
	    { displayFile .helpwin2 "File Load Sequence" \
	    "$ui_home\\documents\\file-load-seq.txt" \
	    $help_file_oblique_words $help_file_bold_words} \
	    -font $basefont
    $w.mbar.help.menu add command -label "Technical Notes on Monitors" -command \
	    { displayFile .helpwin3 "Technical and Implementation Notes on Rationale-Based Monitors" \
	    "[lindex [lindex [lispVar *prodigy-root-directory*] 0] 0]documents\\monitors.txt" \
	    $help_file_oblique_words $help_file_bold_words} \
	    -font $basefont
    $w.mbar.help.menu add command -label "Running the Monitor Demo" -command \
	    { displayFile .helpwin4 "Bridge Problem Example" \
	    "[lindex [lindex [lispVar *prodigy-root-directory*] 0] 0]documents\\bridges-problem.txt" \
	    $help_file_oblique_words $help_file_bold_words} \
	    -font $basefont
    $w.mbar.help.menu add cascade -label "Papers on UI and Monitors"  \
	    -menu $w.mbar.help.menu.papers -font $basefont
    menu $w.mbar.help.menu.papers 
    $w.mbar.help.menu.papers add command -label "Cox & Veloso, 1997" \
	    -command { exec gv "$ui_home\\documents\\cox-veloso-97.ps" \& } \
	    -font $basefont
    $w.mbar.help.menu.papers add command -label "Veloso, Pollack, & Cox, 1998" \
	    -command { exec gv "[lindex [lindex [lispVar *prodigy-root-directory*] 0] 0]documents\\veloso-pollack-cox-98.ps" \& } \
	    -font $basefont
    $w.mbar.help.menu add command -label "Prodigy WWW Home Page" \
	    -command { exec netscape "http://www.cs.cmu.edu/~prodigy" \& } \
	    -font $basefont


    #========================================================================
    # FILE
    menu $w.mbar.file.menu
    $w.mbar.file.menu add command -label "Load Domain and Problem" \
	    -command "fileBox $wind" -font $basefont

    $w.mbar.file.menu add command -label "Store Current Case (Plan)" \
	    -font $basefont \
	    -command {
	if {[string compare [lispVar *analogy-loaded*] NIL] == 0} {
	    lisp_command \
		    "(load \"$analogy_setup\") \
		    (set-for-replay-ui))"
	    if {$planning_mode != "analogy"} {
		lisp_command "(setf *analogical-replay* nil)"
	    }
	}
	saveCase
    } 
    #Disable Case Save function initially
    $w.mbar.file.menu entryconfigure 2 -state disabled

    $w.mbar.file.menu add command -label "Save Goal Tree Canvas to Postscript File" \
	-command "saveCanvasFileBox goalTreeType" \
	-font $basefont -state disabled
    $w.mbar.file.menu add command -label \
	"Save Applied Operator Canvas to Postscript File" \
	-command "saveCanvasFileBox appliedOpType" \
	-font $basefont -state disabled
    $w.mbar.file.menu add separator
    $w.mbar.file.menu add command -label "Quit User Interface" \
	-command { exit_proc} -font $basefont


    #========================================================================
    # PLANNING MODE
    #
    # named mbar.rm because used to be called running mode (rm) rather than 
    # planning mode.
    #
    menu $w.mbar.rm.menu
    $w.mbar.rm.menu add cascade -label "Generative Prodigy 4.0" -font $basefont \
                                        -menu $w.mbar.rm.menu.gen 
    menu $w.mbar.rm.menu.gen
    $w.mbar.rm.menu.gen add command -label "Nonlinear with goal ordering (Default)" \
	    -command "setupDefaultRun $w" -font $basefont
    $w.mbar.rm.menu.gen add command -label "SABA (delayed state changes)" \
	    -command "setupSABARun $w" -font $basefont
    $w.mbar.rm.menu.gen add command -label "Linear" \
	    -command "setupLinearRun $w" -font $basefont
#    $w.mbar.rm.menu.gen add command -label "Linear with Precondition Reordering" \
#	    -command "setupLinearReorderPrecRun $w" -font $basefont

    for {set i 0} {$i < [llength $special_commands]} {incr i} {
      set shortform [lindex $special_commands $i]
      set line      [lindex $special_commands_label $i]
      $w.mbar.rm.menu add command -label "$line" -font $basefont\
                      -command "doSetUp $shortform" \
		      -font $basefont
    }


    #========================================================================
    # CONTROL VARIABLES
    menu $w.mbar.rv.menu
    $w.mbar.rv.menu add command -label "All Variables" \
	    -command { summarizeRunningVariables } -font $basefont
    $w.mbar.rv.menu add separator
    $w.mbar.rv.menu add command -label "Output Level" -command {
                    catch {destroy .output_level}
                    toplevel .output_level
                    setOutputLevel .output_level ""
                } -font $basefont
    $w.mbar.rv.menu add separator
    $w.mbar.rv.menu add command -label "Search Default" -command {
                    catch {destroy .searchdefault}
                    toplevel .searchdefault
                    setSearchDefault .searchdefault ""
                } -font $basefont
    $w.mbar.rv.menu add command -label "Excise Loops" -command {
                    catch {destroy .excise_loops}
                    toplevel .excise_loops
                    setExciseLoops .excise_loops ""
                } -font $basefont
    $w.mbar.rv.menu add command -label "Minimum Conspiracy Number" \
	    -command {
                    catch {destroy .minconspiracy}
                    toplevel .minconspiracy
                    setMinConspiracy .minconspiracy ""
                } -font $basefont
    $w.mbar.rv.menu add command -label "Random Behaviour" \
	    -command {
                    catch {destroy .randombehaviour}
                    toplevel .randombehaviour
                    setRandomBehaviour .randombehaviour ""
                } -font $basefont
    $w.mbar.rv.menu add separator
    $w.mbar.rv.menu add command -label "Use Abstraction Type" \
	    -command {
                    catch {destroy .abstractiontype}
                    toplevel .abstractiontype
                    setAbstractionType .abstractiontype ""
                } -font $basefont
    $w.mbar.rv.menu add command -label "Use Abstraction Level" \
	    -command {
                    catch {destroy .abstractionlevel}
                    toplevel .abstractionlevel
                    setAbstractionLevel .abstractionlevel ""
                } -font $basefont
    $w.mbar.rv.menu add separator
    $w.mbar.rv.menu add command -label "Depth Bound" \
	    -command {
                    setDepthbound
                } -font $basefont
    $w.mbar.rv.menu add command -label "Time Bound" \
	    -command {
                    setTimeBound
                } -font $basefont
    $w.mbar.rv.menu add command -label "Maximum Nodes" \
	    -command {
                    setMaxNodes
                } -font $basefont
    $w.mbar.rv.menu add separator

    #Added for user control of planning decisions [19sep97 cox]
    $w.mbar.rv.menu add command -label "User Control" -command {
                    catch {destroy .user_control}
                    toplevel .user_control
                    setUserControl .user_control ""
                } -font $basefont
    
    $w.mbar.rv.menu entryconfigure 10 -state disabled
    $w.mbar.rv.menu entryconfigure 11 -state disabled

    #========================================================================
    # DISPLAY VARIABLES
    menu $w.mbar.dv.menu
    $w.mbar.dv.menu add cascade -label "Applied Ops Display" -font $basefont    \
                                 -menu $w.mbar.dv.menu.appliedops
    $w.mbar.dv.menu add cascade -label "Type Hierarchy Display" -font $basefont \
                                 -menu $w.mbar.dv.menu.typehierarchy
    $w.mbar.dv.menu add cascade -label "Goal Tree Display" -font $basefont \
                                 -menu $w.mbar.dv.menu.polygons

    menu $w.mbar.dv.menu.typehierarchy
    $w.mbar.dv.menu.typehierarchy add radiobutton -label "Classes Only"       \
                          -font $basefont -variable typeHierarchy -value class
    $w.mbar.dv.menu.typehierarchy add radiobutton -font $basefont             \
                           -label "Classes and Instantiations"                \
                           -variable typeHierarchy -value instantiated

    menu $w.mbar.dv.menu.appliedops
    $w.mbar.dv.menu.appliedops add radiobutton -label "Total Order"           \
                           -font $basefont -variable partialOrder -value false
    $w.mbar.dv.menu.appliedops add radiobutton -label "Partial Order"         \
                           -font $basefont -variable partialOrder -value true

    menu $w.mbar.dv.menu.polygons
    $w.mbar.dv.menu.polygons add radiobutton -label "Display Polygons"        \
                       -font $basefont -variable displaypolygons -value true
    $w.mbar.dv.menu.polygons add radiobutton -label "Don't Display Polygons"  \
                       -font $basefont -variable displaypolygons -value false
    $w.mbar.dv.menu add command -label "Goal Tree Sizing" \
	    -command { setNodeParams } -font $basefont

    $w.mbar.dv.menu add command -label "Print Alternatives" \
	    -command {
                    catch {destroy .printalts}
                    toplevel .printalts
                    setPrintAlternatives .printalts ""
                } -font $basefont

    #========================================================================
    # SPECIAL FUNCTIONS
    #    see all the "setup*" functions. these should be the same
#    menu $w.mbar.special.menu
#    for {set i 0} {$i < [llength $special_commands]} {incr i} {
#      set shortform [lindex $special_commands $i]
#      set line      [lindex $special_commands_label $i]
#      $w.mbar.special.menu add cascade -label "$line" -font $basefont \
#                                        -menu $w.mbar.special.menu.$shortform 
#    }
#
#    for {set i 0} {$i < [llength $special_commands]} {incr i} {
#      set shortform [lindex $special_commands $i]
#      set line      [lindex $special_commands_label $i]
#
#      menu $w.mbar.special.menu.$shortform
#      for {set j 0} {$j < [llength $labels($shortform)]} {incr j} {
#          set label   [lindex $labels($shortform) $j]
#          set command [lindex $commands($shortform) $j]
#
#          $w.mbar.special.menu.$shortform add command -label "$label" \
#                                 -command "eval $command" -font $basefont
#      }
#    }

    #========================================================================
    # VIEW
    menu $w.mbar.view.menu

    # Made this smaller and easier to maintain with a list that is
    # used to set everything up. Each element is a three-element list
    # {command string name} I don't know why name is different from
    # command, but the rest of the code assumes this. - Jim, May 97

    set viewCommandList {
	{viewPartialOrder "View Partial Order" viewpartialorder}
	{viewTypeHierarchy "View Type Hierarchy" viewtypehierarchy}
	{viewOperatorGraph "View Operator Graph" viewOperatorGraph}
	{"viewProblemFile noload" "View Problem" viewproblem}
	{"viewDomainFile noload" "View Domain" viewdomain}
	{showState "View Current State" viewcurrentstate}
	{viewSearchNode "View Search Node" viewsnode}
	{clearCanvases "Clear Windows" clearCanvases}
	{"separateGoalTreeCanvas .gtc" "Separate Goal Display" \
		separateGTCanvas}
    }


    set viewMenuIndex 0
    foreach triple $viewCommandList {
	incr viewMenuIndex
	$w.mbar.view.menu add command -label [lindex $triple 1]\
	    -command [lindex $triple 0] -font $basefont
	set active_menus([lindex $triple 2]) "$w.mbar.view.menu $viewMenuIndex"
	$w.mbar.view.menu entryconfigure $viewMenuIndex -state disabled
    }
    #Enable last 2 entries (Clear Windows and Separate Display)
    $w.mbar.view.menu entryconfigure $viewMenuIndex -state normal
    $w.mbar.view.menu entryconfigure \
	    [expr $viewMenuIndex - 1] -state normal

#Need to add corresponding Button Info
#"View the partial order derived from the plan."
#"View the type hierarchy of the current domain (& problem)."
#"View the current problem."
#"View the current domain."
#"View the current state."



    #========================================================================
    # DISPLAY LINE
    #========================================================================

    frame $w.infoframe -relief raised -bd 2 
    pack $w.infoframe -side bottom -fill both

    label $w.infoframe.domain -text "" -anchor w -relief sunken -bd 1 -font $basefont
    pack  $w.infoframe.domain -side left -padx 2
    $w.infoframe.domain configure -text "Domain:$domain_name "
    set domain_line $w.infoframe.domain

    label $w.infoframe.problem -text "" -anchor w -relief sunken -bd 1 -font $basefont
    pack  $w.infoframe.problem -side left -padx 3
    $w.infoframe.problem configure -text "Problem:$problem_name "
    set problem_line $w.infoframe.problem

    #Added [cox 11jul97]. Upon startup it is not displayed because the default planning
    #mode is P4.0 rather than Alpine.
    label $w.infoframe.abstype -text "" -anchor w -relief flat -bd 1 -font $basefont
    pack  $w.infoframe.abstype -side left -padx 3
    $w.infoframe.abstype configure -text ""
    set abs_line $w.infoframe.abstype

    label $w.infoframe.value -text "" -anchor w -font $basefont
    pack  $w.infoframe.value -side right -padx 3
    $w.infoframe.value configure -text "Information Line"
    set display_line $w.infoframe.value

    #========================================================================
    # FUNCTION DEPENDANT BUTTONS
    #========================================================================
    frame $w.functionButtons -relief raised -bd 2 
    pack $w.functionButtons -side bottom -fill both

    #========================================================================
    # QUICK COMMAND BUTTONS
    #========================================================================

    frame $w.buttonframe -relief raised -bd 2 
    pack $w.buttonframe -side left -fill both

    set but_labels {"Run" "Step" "Break" "Continue" "Abort" }
    set but_commands {runCommand multistepCommand breakCommand restartCommand abortCommand}
    set but_infotext {"Run from Top" "Step One or More" "Pause Run" \
	    "Continue Planning from Current Point" "Abort This Run; Clear Canvasses"}
    set active_buttons(run) $w.buttonframe.but0
#    set active_buttons(step) $w.buttonframe.but1
    set active_buttons(multistep) $w.buttonframe.but1
    set active_buttons(break) $w.buttonframe.but2
    set active_buttons(restart) $w.buttonframe.but3
    set active_buttons(abort) $w.buttonframe.but4


    addButtons $w $w.buttonframe $but_labels $but_commands $but_infotext top
    $active_buttons(run) configure -state disabled
    $active_buttons(multistep) configure -state disabled
    $active_buttons(break) configure -state disabled
    $active_buttons(restart) configure -state disabled
    $active_buttons(abort) configure -state disabled


                       
    set but_labels { "Quit UI" "Define Domain" "Debug Window" "Load"}

    set active_buttons(quit) $w.buttonframe.but10
    set active_buttons(definedomain) $w.buttonframe.but11
    set active_buttons(debug) $w.buttonframe.but12
    set active_buttons(load) $w.buttonframe.but13


    set but_commands {  
	               exit_proc 
		       "DefineDomain $wind" 
                       {
                        mkDebug $debug_window
                        $active_buttons(debug) configure -state disabled
		       }
		       "fileBox $wind" 
    }

    set but_infotext { "Quit the User Interface Program" 
                       "Create or Edit a Domain Definition"
                       "Start a Debugging Window"
                       "Load the Domain and Problems"
                     }


    addButtons $w $w.buttonframe $but_labels $but_commands $but_infotext bottom 10

     $active_buttons(quit) configure -state normal



    #========================================================================
    # CANVAS
    #========================================================================
    frame $w.canvas -relief raised -bd 2 
    pack  $w.canvas -side top -expand yes -fill both
    frame $w.canvas.goaltree  
    if {$stackedCanvases == 1} {
	pack  $w.canvas.goaltree -side top -expand yes -fill both
    } else {
	pack  $w.canvas.goaltree -side left -expand yes -fill both
    }
    frame $w.canvas.appop  
    if {$stackedCanvases == 1} {
	pack  $w.canvas.appop -side bottom -fill x
#	pack  $w.canvas.appop -side bottom -expand yes -fill both
    } else {
	pack  $w.canvas.appop -side right -fill y
#	pack  $w.canvas.appop -side right -expand yes -fill both
    }

    set c $w.canvas.goaltree
    drawGoalTree $c $w.infoframe.value 
    set c $w.canvas.appop
    drawAppliedOps $c $w.infoframe.value 

}

#============================================================================

#============================================================================
# CANVAS
#============================================================================
proc selectCanvasFile {canvasfilename} {
  global canvas_file_name
  global canvas_buttons
  $canvas_buttons(ok)       configure -state normal
}
#============================================================================
proc rescanCanvas {} {
  global numCanvases canvas_directory canvas_file_name
  set numCanvases [rescan .cfb.sb.box.lb $canvas_directory $numCanvases *.ps]
  incr numCanvases [addFiles .cfb.sb.box.lb $canvas_directory *\\]
  .cfb.sb.box.lb insert 0 "$canvas_file_name"
  incr numCanvases
}

#============================================================================
# Removed the first parameter (c) that called a direct path to the canvas.
# Instead now use the second parameter and the variables that point to the
# canvasses (canvasGoalTree canvasAppliedOps canvasGeneric). The variable
# canvas_type can be either goalTreeType, appliedOpType, or genericType to
# signify which canvas is being written to postscript file.  [cox 15aug97
# 19sep97] 
#
proc saveCanvasFileBox {canvas_type} {
  global xdialoggeometry ydialoggeometry
  global canvasGoalTree canvasAppliedOps canvasGeneric
  global world_path domain_name problem_name
  global basefont boldfont
  global numCanvases
  global canvas_buttons
  global canvas_file_name
  global canvas_directory
  global colourModel

  if { ($domain_name == "None") ||
       ($problem_name == "None") } {
    return
  }

  if { [string trimright $world_path "\\"] == $world_path } {
    set world_path "$world_path\\"
  }
  set canvas_file_name \
      [string range $problem_name 0 [expr [string last "." $problem_name]-1]]

  if {($canvas_directory == "")} {
    set canvas_directory "$world_path$domain_name\\probs"
  }

# unfortunately this function doesn't seem to recognize "creatable"...
#   if it did, then I'd set canvas_dir to $world_path$domain_name/probs
#   if the user has write access...
# puts [file writable "$world_path$domain_name/probs/$canvas_file_name"]


  #===== finally, draw the window
  catch {destroy .cfb}
  toplevel .cfb
  wm geometry .cfb +$xdialoggeometry+$ydialoggeometry

  switch -exact -- $canvas_type {
      goalTreeType {
	  set canvas_file_name "goaltree-$canvas_file_name.ps"
	  wm title .cfb "Save Canvas Goal Tree"
      }
      appliedOpType {
	  set canvas_file_name "plan-$canvas_file_name.ps"
	  wm title .cfb "Save Canvas Applied Ops"
      }
      genericType {
	  set canvas_file_name "generic-$canvas_file_name.ps"
	  wm title .cfb "Generic Save Canvas"
      }
  }

  #===== domain name
  label .cfb.curr_path -text "World Path: $world_path" -font $basefont
  label .cfb.curr_dom -text "Domain: $domain_name" -font $basefont
  label .cfb.curr_prob -text "Problem: $domain_name\\probs\\$problem_name" -font $basefont
  pack  .cfb.curr_path -side top
  pack  .cfb.curr_dom -side top
  pack  .cfb.curr_prob -side top

  #===== directory
  frame .cfb.dir 
  pack  .cfb.dir -side top -pady 5
  label .cfb.dir.l -text "Directory: " -font $basefont
  entry .cfb.dir.e -width 50 -textvariable canvas_directory -font $basefont -relief sunken -bd 2
  pack .cfb.dir.l -side left
  pack .cfb.dir.e -side left 
  
  bind .cfb.dir.e <Return> { rescanCanvas }
  bind .cfb.dir.e <Tab> { focus .cfb.eb.e }

  #===== selection box
  frame .cfb.sb 
  pack  .cfb.sb -side top -padx 3
  frame .cfb.sb.box 
  pack  .cfb.sb.box -side top
  mkScrollSelectionBox .cfb.sb.box
  set numCanvases 0
  rescanCanvas 
  bind .cfb.sb.box.lb <Double-Button-1> {
    set selected [selection get]
    if {[file isdirectory $selected]} {
      set canvas_directory [string trimright $canvas_directory "/"]
      set canvas_directory "$canvas_directory\\$selected"
      rescanCanvas
    } else {
      selectCanvasFile $selected
    }
  }


  #===== selection entry box
  frame .cfb.eb 
  pack  .cfb.eb -side top -pady 10
  label .cfb.eb.l -text "PS file: " -font $basefont
  entry .cfb.eb.e -width 30 -textvariable canvas_file_name -font $basefont -relief sunken -bd 2
  pack  .cfb.eb.l -side left
  pack  .cfb.eb.e -side left
  bind  .cfb.eb.e <Return> {selectCanvasFile $canvas_file_name}
  bind  .cfb.eb.e <Tab> {focus .cfb.dir.e}

  #===== colour model
  frame .cfb.colour 
  pack  .cfb.colour -side top -padx 10

  radiobutton .cfb.colour.colour -text "Colour" -variable colourModel -value color -anchor sw
  radiobutton .cfb.colour.gray -text "Gray scale" -variable colourModel -value gray -anchor sw
  radiobutton .cfb.colour.mono -text "B & W" -variable colourModel -value monochrome -anchor sw
  pack .cfb.colour.colour .cfb.colour.gray .cfb.colour.mono -side left -fill x


  #===== buttons
  frame .cfb.buts 
  pack  .cfb.buts -side bottom -pady 10

  set but_labels {"Rescan" "Save" "Cancel"}
  set but_commands " \" rescanCanvas \"
                     \" saveCanvas [switch -exact -- $canvas_type {\
			     goalTreeType {set canvasGoalTree} \
			     appliedOpType {set canvasAppliedOps} \
			     genericType {set canvasGeneric}}] \"
                     \" destroy .cfb\" "
  set but_infotext { "" "" "" }
  addButtons .cfb .cfb.buts $but_labels $but_commands $but_infotext left
  set canvas_buttons(rescan)   .cfb.buts.but0
  set canvas_buttons(ok)       .cfb.buts.but1
  set canvas_buttons(cancel)   .cfb.buts.but2

# $canvas_buttons(ok)       configure -state disabled
}

#============================================================================
# Completely rewrote because previously the procedure created a file without a
# PS-Adobe-2.0 identifier and the file that was created had no permissions. 
# This condition is because of the way the canvas postscript -file option 
# works. Instead, we now open the file directly and with specific permissions,
# and then write the resulting postscript manually. [cox 5aug97]
#
proc saveCanvas {c} {
    global canvas_directory canvas_file_name
    global colourModel

  set canvas_directory [string trimright $canvas_directory "/"]
  puts $colourModel

    if [catch {open "$canvas_directory\\$canvas_file_name" w 0644} fileId ] {
	mkErrorDialog .error \
		"Cannot open $canvas_directory\\$canvas_file_name: $fileId"
    } else {
	puts $fileId "\%!PS-Adobe-2.0"
	puts $fileId [$c postscript -colormode $colourModel]
	close $fileId
	puts "---saving $c in $canvas_directory\\$canvas_file_name"
    }
    destroy .cfb
}

#============================================================================
proc drawAppliedOps {f info} {
    global canvasAppliedOpWidth canvasAppliedOpHeight AppliedOpBackground

    canvas $f.c -scrollregion "0 0 $canvasAppliedOpWidth $canvasAppliedOpHeight"\
            -xscrollcommand "$f.hscroll set" \
 	    -yscrollcommand "$f.vscroll set" \
            -bg $AppliedOpBackground
    scrollbar $f.vscroll  -relief sunken -command "$f.c yview"
    scrollbar $f.hscroll -orient horiz -relief sunken -command "$f.c xview"
    pack $f.vscroll -side right -fill y
    pack $f.hscroll -side bottom -fill x
    pack $f.c -expand yes -fill both
    $f.c bind text <Any-Enter> "enterAppText $f.c $info"
    $f.c bind text <Any-Leave> "leaveAppText $f.c $info"
    $f.c bind text <Button> "buttonAppText $f.c $info"
    bind $f.c <B2-Motion> "$f.c scan dragto %x %y"
    bind $f <Any-Enter> "$info configure -text \"Plan (Applied Operators) Display\""
    bind $f <Any-Leave> "$info configure -text {}"
}

proc enterAppText {c info} {
    $c itemconfigure [$c find withtag current] -fill red
    $info configure -text "Mouse-Button: Decision Node"    
}

proc leaveAppText {c info} {
    $c itemconfigure [$c find withtag current] -fill black
    $info configure -text "Plan (Applied Operators) Display"
}

# This procedure and global "globCounter" are currently defined in 
# my-search-dialog.tcl. The text items in the applied op canvas all 
# have a tag of the form "node<n>" where <n> is the number of the prodigy 
# node.
proc buttonAppText {c info} {
    global lisp globCounter nodes

    set tags [$c gettags [$c find withtag current]]
    set nodenum [string range [lindex $tags [lsearch $tags node*]] 4 end]
    lisp_blat "(compute-expression-4-tcl (find-node $nodenum))"
    gets $lisp line
    lisp_object_dialog tempvar$globCounter .lispobj$globCounter \
	"Applied op node" [lreplace $line 0 0 "find-node $nodenum"] \
	"Ok" "destroy .lispobj$globCounter"
    incr globCounter
}

#==========================================================================
proc resetCanvasGoalTree {c x y } {
    global canvasGoalTree canvasGoalTreeWidth canvasGoalTreeHeight
    if {$x > $canvasGoalTreeWidth} {
	set canvasGoalTreeWidth [expr $x+500]
	$canvasGoalTree configure -scrollregion "0 0 $canvasGoalTreeWidth $canvasGoalTreeHeight"
    }
    if {$y > $canvasGoalTreeHeight} {
	set canvasGoalTreeHeight [expr $y+500]
	$canvasGoalTree configure -scrollregion "0 0 $canvasGoalTreeWidth $canvasGoalTreeHeight"
    }
}

#==========================================================================
proc placeText {c x y text font tags nodenum colour} {
    global viewsize
    global nodes canvastext 
    set linegap [expr $viewsize/10]
    foreach line $text {
	set id [$c create text $x $y -text "$line" -anchor n -font $font -tags "text $tags" -fill $colour]
	set nodes($nodenum,text) "$id $nodes($nodenum,text)"
	set canvastext($id,node) "$nodenum"
	#puts "nodes($nodenum,text)"
	#puts "canvastext($id,node)"
	incr y $linegap
    }
}
#=====
proc setData {canvasID prodID parentID} {
    global nodes prodigyIDnums
    set nodes($canvasID,text)      ""
    set nodes($canvasID,linesup)   ""
    set nodes($canvasID,linesdown) ""
    set nodes($canvasID,prodigyID) $prodID
    set nodes($canvasID,parentID)  $parentID
    set prodigyIDnums($prodID)     $canvasID
    
    #   puts "nodes($canvasID,text)       $nodes($canvasID,text)"
    #   puts "nodes($canvasID,prodigyID)  $nodes($canvasID,prodigyID)"
    #   puts "nodes($canvasID,parentID)   $nodes($canvasID,parentID)"
    #   puts "prodigyIDnums($prodID)    $prodigyIDnums($prodID)"
}

#==========================================================================
#deletes node and all lines going up. down lines should have been deleted
#when child was deleted
proc deleteNode {c prodID} {
    global nodes prodigyIDnums canvastext
    
    set id $prodigyIDnums($prodID)
    #   foreach elt [array names nodes] {
    #     if { [string match "$id,*" "$elt"] == 1 } {
    #       puts "  $elt: $nodes($elt)"
    #     }
    #   }
    
    $c delete $id
    unset prodigyIDnums($prodID)
    foreach line $nodes($id,linesup) {
	$c delete $line
    }
    foreach line $nodes($id,text) {
	$c delete $line
	unset canvastext($line,node)
    }
    unset nodes($id,parentID)
    unset nodes($id,linesup)
    unset nodes($id,linesdown)
    unset nodes($id,prodigyID)
    unset nodes($id,text)
}

#==========================================================================
proc drawLine {c id1 id2} {
    global nodes
    set c1 [$c coords $id1]
    set c2 [$c coords $id2]
    
    set x1 [expr ([lindex $c1 0] + [lindex $c1 2]) / 2.0]
    set y1 [expr ([lindex $c1 1] + [lindex $c1 3]) / 2.0]
    set x2 [expr ([lindex $c2 0] + [lindex $c2 2]) / 2.0]
    set y2 [expr ([lindex $c2 1] + [lindex $c2 3]) / 2.0]
    
    set id [$c create line $x1 $y1 $x2 $y2 -fill black -tags line]
    $c lower $id
    
    set nodes($id1,linesup)   "$id $nodes($id1,linesup)"
    set nodes($id2,linesdown) "$id $nodes($id1,linesdown)"
}
#==========================================================================
proc drawAppliedOperator {c idnum parentidnum x1 y1 x2 y2 text} {
    global prodigyIDnums
    global appliedopfont
    global displaypolygons
    if {$displaypolygons == "true"} {
	set id [$c create oval $x1 $y1   $x2 $y2 -outline black -fill white -tags "node appliedop" ]
    } else {
	set bg [lindex [$c config -bg] 4]
	set id [$c create oval $x1 $y1   $x2 $y2 -outline $bg -fill $bg -tags "node appliedop" ]
    }
    
    resetCanvasGoalTree $c $x1 $y1
    resetCanvasGoalTree $c $x2 $y2
    setData $id $idnum $parentidnum
    if {$parentidnum >= 0} {
	drawLine $c $id $prodigyIDnums($parentidnum)
    }
    placeText $c [expr ($x1+$x2)/2.0] $y1 "$text" $appliedopfont appliedoptext $id black
}

#==========================================================================
proc drawOperator {c idnum parentidnum x1 y1 x2 y2 text} {
    global prodigyIDnums
    global operatorfont
    global displaypolygons
    global OperatorTextColour
    if {$displaypolygons == "true"} {
	set id [$c create oval $x1 $y1 $x2 $y2 -outline black -fill white -tags "node appliedop" ]
    } else {
	set bg [lindex [$c config -bg] 4]
	set id [$c create oval $x1 $y1 $x2 $y2 -outline $bg -fill $bg -tags "operator node"]
    }
    
    resetCanvasGoalTree $c $x1 $y1
    resetCanvasGoalTree $c $x2 $y2
    setData $id $idnum $parentidnum
    #Incremented y coord by 7 to give room at top of oval drawing so text fits [cox]
    placeText $c [expr ($x1+$x2)/2.0] [expr ($y1+7)] "$text" $operatorfont \
	"operatortext ot$idnum" $id $OperatorTextColour

    set bbox [$c bbox ot$idnum]
    $c coords $id \
	[lindex $bbox 0] [lindex $bbox 1] [lindex $bbox 2] [lindex $bbox 3]

    if {$parentidnum >= 0} {
	drawLine $c $id $prodigyIDnums($parentidnum)
    }
}

#==========================================================================
proc drawGoal {c idnum parentidnum x1 y1 x2 y2 text} {
    global prodigyIDnums
    global goalfont
    global displaypolygons
    global GoalTextColour

    if {$displaypolygons == "true"} {
	set id [$c create rectangle 0 0 1 1 -outline black -fill white -tags "node appliedop" ]
    } else {
	set bg [lindex [$c config -bg] 4]
	set id [$c create rectangle 0 0 1 1 -outline $bg -fill $bg -tags "node goal"]
    }
    
    resetCanvasGoalTree $c $x1 $y1
    resetCanvasGoalTree $c $x2 $y2
    setData $id $idnum $parentidnum

    #Incremented y coord by 2 to give room at top [cox 19jan97]
    placeText $c [expr ($x1+$x2)/2.0] [expr ($y1+2)] "$text" $goalfont \
	"goaltext gt$idnum" $id  $GoalTextColour
    # Get a better bounding box [Jim 21May97]
    set bbox [$c bbox gt$idnum]
    $c coords $id \
	[lindex $bbox 0] [lindex $bbox 1] [lindex $bbox 2] [lindex $bbox 3]

    if {$parentidnum >= 0} {
	drawLine $c $id $prodigyIDnums($parentidnum)
    }
}

#============================================================================
proc drawGoalTree {f info} {
    global canvasGoalTreeWidth canvasGoalTreeHeight GoalTreeBackground

    set scalefactor 1
    
    canvas $f.c -scrollregion "0 0 $canvasGoalTreeWidth $canvasGoalTreeHeight" \
            -xscrollcommand "$f.hscroll set" -yscrollcommand "$f.vscroll set" \
            -bg $GoalTreeBackground
    scrollbar $f.vscroll -relief sunken -command "$f.c yview"
    scrollbar $f.hscroll -orient horiz -relief sunken -command "$f.c xview"
    pack $f.vscroll -side right -fill y
    pack $f.hscroll -side bottom -fill x
    pack $f.c -expand yes -fill both
    
    #   for {set i 10} {$i < 500} {incr i 30} {
    #     drawOperator $f.c $i $i [expr $i+10] [expr $i+10] "$i"
    #   }

#    set parentID -1
#    set prodID 0
#    drawGoal $f.c $prodID $parentID 25 25 100 60 {"goal g1 g2" "g3 g4"}
#    set parentID $prodID
#    incr prodID 
#    drawOperator $f.c $prodID $parentID 25 100 100 135 {"operator" "op1 op2"}
#    set parentID $prodID
#    incr prodID 
#    drawAppliedOperator $f.c $prodID $parentID 25 175 100 210 {"appliedop" "aop1 aop2 aop3"}
    
    #   $f.c bind all <Any-Enter> "scrollEnter $f.c"
    # <ButtonPress-1>
    # <ButtonRelease-1>

    $f.c bind node <Any-Enter> "enterNode $f.c $info"
    $f.c bind text <Any-Enter> "enterText $f.c $info"
    $f.c bind node <Any-Leave> "scrollLeave $f.c $info"
    $f.c bind text <Any-Leave> "textLeave $f.c $info"
    $f.c bind node <Button>  "scrollButton $f.c %b"
    $f.c bind text <Button>  "scrollButton $f.c %b"
    bind $f.c <2> "$f.c scan mark %x %y"
    bind $f.c <B2-Motion> "$f.c scan dragto %x %y"
    bind $f <Any-Enter> "$info configure -text \"Goal Tree Display\""
    bind $f <Any-Leave> "$info configure -text {}"
}

# Add a number to the node in the goal tree and add the line in the
# appliedop canvas. Widen the canvas if necessary.
# AppOpID is the Prodigy node id for the applied op node, 
# ProdID is the node id for the corresponding binding node.
# multi is 1 if there are other inference rules applied at this node.
proc makeApplied {gc ac AppOpID ProdID text multi} {
    global applications applheight applymargin basefont applmark 
    global canvasAppliedOpWidth canvasAppliedOpHeight prodigyIDnums
    global AppGoalColour AppTextColour HeadPlanMargin apps
    set id $prodigyIDnums($ProdID)
    set bbox [$gc bbox $id]
    if {$AppOpID != 1} {    # Node 1 just applies to eager inference rules
	lappend applmark \
	    [$gc create text [expr [lindex $bbox 2]+5] [expr [lindex $bbox 1]-5]\
		 -text [expr [llength $applmark]+1] -fill $AppGoalColour]
    }
    lappend applications \
	    [$ac create text 20 [expr $applymargin + $applheight * [llength $applications]]\
		 -text "[llength $applmark]: $text" -font $basefont -anchor w \
	    -fill $AppTextColour -tags "text node$AppOpID"]
    expandWidthIfNeeded $ac [lindex $applications end]
    if {$multi == 1} {
	lappend applications \
	    [$ac create text 40 [expr $applymargin + $applheight * [llength $applications]]\
		 -text "(and other inference rules)" -font $basefont \
		 -anchor w -fill $AppTextColour -tags "text node$AppOpID"]
    }
    # Expand applied op canvas width and height if necessary.
    expandWidthIfNeeded $ac [lindex $applications end]
    set desiredHeight \
	[expr [lindex [$ac bbox [lindex $applications end]] 3] + 20]
    if {$desiredHeight > $canvasAppliedOpHeight} {
	set canvasAppliedOpHeight $desiredHeight
	$ac configure -scrollregion \
	    "0 0 $canvasAppliedOpWidth $canvasAppliedOpHeight"
    }
}

proc expandWidthIfNeeded {ac item} {
    global canvasAppliedOpWidth canvasAppliedOpHeight
    set desiredWidth [expr [lindex [$ac bbox $item] 2] + 20]
    if {$desiredWidth > $canvasAppliedOpWidth} {
	set canvasAppliedOpWidth $desiredWidth
	$ac configure -scrollregion \
	    "0 0 $canvasAppliedOpWidth $canvasAppliedOpHeight"
    }
}

#Never uses ProdID argument.
proc deleteApplied {gc ac ProdID deleteMarkToo} {
    global applmark applications
    set lastapp [lindex $applications [expr [llength $applications]-1]]
    set applications \
	    [lrange $applications 0 [expr [llength $applications]-2]]
    $ac delete $lastapp
    if {$deleteMarkToo == 1} {
	set lastappmark [lindex $applmark [expr [llength $applmark]-1]]
	set applmark [lrange $applmark 0 [expr [llength $applmark]-2]]
	$gc delete $lastappmark
    }
}

#============================================================================
# Note that this function is redefined in scrollbutton.tcl [cox]
#
#proc scrollButton {w b} {
#    global currentNode nodes
#    if {$b==2} {return}
#    #puts "($b)  Current node ($currentNode): $nodes($currentNode,prodigyID)"
#    lisp_send "(print (find-node $nodes($currentNode,prodigyID) ))"
#    lisp_receive
#}

#============================================================================
proc scrollEnter {canvas} {
    set id [$canvas find withtag current]
    puts "$id  [$canvas gettags current]"
}
#=====
proc enterText {canvas info} {
    global canvastext
    global currentNode OutlineColor
    
    $info configure -text "Mouse-L: Decision Node;  Mouse-M: Operator Definition"    
    set id [$canvas find withtag current]
    # puts "   Entered text $id; tags: [$canvas gettags current]"
    # puts "                   node: $canvastext($id,node)"
    $canvas itemconfigure $canvastext($id,node) -outline $OutlineColor
    set currentNode $canvastext($id,node)
}
#=====
proc enterNode {canvas info} {
    #    global canvasGoalTree
    global node 
    global currentNode OutlineColor

    $info configure -text "Mouse-L: Decision Node;  Mouse-M: Operator Definition"    
    set id [$canvas find withtag current]
    $canvas itemconfigure $id -outline $OutlineColor

    # puts "  Entered node $id; tags: [$canvas gettags current]"
    # puts "             prodigyID: $nodes($id,prodigyID)"
    # puts "                  text: $nodes($id,text)"
    set currentNode $id
}
#============================================================================
proc scrollLeave {canvas info} {
    global currentNode 
    global displaypolygons

    $info configure -text "Goal Tree Display"    
    set id [$canvas find withtag current]
    if {$displaypolygons == "true"} {
	$canvas itemconfigure $id -outline black 
    } else {
	$canvas itemconfigure $id -outline White
    }
    set currentNode ""
}
#============================================================================

proc textLeave {canvas info} {
    global canvastext
    global currentNode 
    global displaypolygons

    $info configure -text "Goal Tree Display"    
    set id [$canvas find withtag current]
    if {$displaypolygons == "true"} {
	$canvas itemconfigure $canvastext($id,node) -outline black 
    } else {
	$canvas itemconfigure $canvastext($id,node) -outline White
    }
    set currentNode ""
}


#============================================================================
global prodigyvar typeHierarchy partialOrder
trace variable prodigyvar     w     pvar
trace variable typeHierarchy  w     pvar
trace variable partialOrder   w     pvar

# pvar is defined in ui-comm.tcl instead [cox]
#proc pvar {name elt op} {
#    if {$elt != ""} {
#	set name ${name}($elt)
#    }
#    upvar $name var
#    puts "$name = $var"
#}
#============================================================================
proc mkDefaultButton {w text command} {
    global boldfont

    frame $w.default -relief sunken -bd 1 
    pack  $w.default -padx 1 -pady 1 -side left
    button $w.ok -text $text -command "$command" -font $boldfont
    pack   $w.ok -in $w.default -ipadx 2 -ipady 2 -padx 2 -pady 2
}

#============================================================================
proc loadFile {widget file} {
    $widget delete 1.0 end
    set f [open $file]
    while {![eof $f]} {
	$widget insert end [read $f 1000]
    }
    close $f
}

#============================================================================
# I have no idea how this works. It came from the Tcl book (I've made the
# match case-independent to be better with lisp).
proc forAllMatches {w pattern script} {
    scan [$w index end] %d numLines
    for {set i 1} {$i < $numLines} {incr i} {
	$w mark set last $i.0
	while {[regexp -nocase -indices $pattern\
		[$w get last "last lineend"] indices]} {
	    $w mark set first\
		    "last + [lindex $indices 0] chars"
	    $w mark set last "last +1 chars \
		    + [lindex $indices 1] chars"
	    uplevel $script
	}
    }
}

proc buttonPressProc {buttonpath} {
    if {[string compare "normal" [$buttonpath configure -state]]== 0} {
	$buttonpath configure -relief sunken
    }
}

proc buttonReleaseProc {buttonpath} {
    $buttonpath configure -relief raised
}

proc buttonEnterProc {buttonpath infoline infotext} {
    $buttonpath configure -background #fff4d4
    $infoline configure -text $infotext
}

proc buttonLeaveProc {buttonpath infoline} {
    $buttonpath configure -background #ffe4c4
    $infoline configure -text {}
}

#============================================================================
proc addButtons {w butframe labels commands infotexts side {start 0}} {
    global basefont

    set buttons ""

    set numlabels [llength $labels]
    if { ($numlabels != [llength $commands] ) ||
    ($numlabels != [llength $infotexts]) } {
	puts "addButtons arg lists not same length"
	exit
    }

    for {set i 0} {$i < $numlabels} {incr i} {
	set name [expr $i+$start]
	set label [lindex $labels $i]
	set command [lindex $commands $i]
	set infotext [lindex $infotexts $i]
	set buttons "[button $butframe.but$name -text $label -relief raised\
                -bd 2  -command $command  -font $basefont] $buttons"
#	if {$infotext!=""} {
#	    bind $butframe.but$name <Enter> "buttonEnterProc $butframe.but$name\
#		    $w.infoframe.value \"$infotext\""
#	    bind $butframe.but$name <Leave> "buttonLeaveProc $butframe.but$name\
#		    $w.infoframe.value"
#	}
#	bind $butframe.but$name   <1> "buttonPressProc $butframe.but$name"
#	bind $butframe.but$name   <1> "+ $command"
#	bind $butframe.but$name   <ButtonRelease-1> "buttonReleaseProc \
#		$butframe.but$name"
	if {($side == "left") || ($side == "right") } {
	    pack $butframe.but$name -ipadx 1 -ipady 1 -padx 5 -pady 1 -fill x -side $side
	} else {
	    pack $butframe.but$name -ipadx 1 -ipady 1 -pady 1 -fill x -side $side
	}
	if {$infotext!=""} {
	    bind $butframe.but$name <Enter> "$w.infoframe.value  configure -text \
		    \"$infotext\""
	    bind $butframe.but$name <Leave> "$w.infoframe.value  configure -text \
		    \" \""
	}
#	bind $butframe.but$name   <ButtonRelease-1> "$command"
    }
#    bind Button <Any-Enter> "$w.infoframe.value configure -text \"This is a test\""
    return $buttons
}

#============================================================================
proc setDisplayLine {label widget} {
    global helptext
    $label configure -text $helptext($widget)
}

proc resetDisplayLine {label widget} {
    $label configure -text {}
}

#============================================================================
proc checkDialogGeometry {window} {
    global xdialoggeometry
    global ydialoggeometry
    
    set geom [wm geometry $window]
    scan $geom "%dx%d+%d+%d" w h x y
    set xdialoggeometry $x
    set ydialoggeometry $y
}

#============================================================================
proc checkGeometry {window} {
    global xgeometry
    global ygeometry
    
    set geom [wm geometry $window]
    scan $geom "%dx%d+%d+%d" w h x y
    set xgeometry $x
    set ygeometry $y
}

#llxx========================================================================
#==== I changed the name to use a new version of mkErrorDialog
proc mkErrorDialog_old {w text} {
    global xdialoggeometry ydialoggeometry
    global basefont boldfont
    
    catch {destroy $w}
    toplevel $w
    wm title $w "Error"
    wm geometry $w +$xdialoggeometry+$ydialoggeometry
    
    set i 0
    foreach line $text {
	label $w.line$i -text $line
	pack  $w.line$i -side top
	incr i
    }
    button $w.ok -text "OK" -font $boldfont -command "destroy $w"
    pack $w.ok -side bottom -padx 2m -pady 2m -ipadx 2m -ipady 1m
    wm protocol $w WM_TAKE_FOCUS "checkDialogGeometry $w"
    
    tkwait visibility $w
    grab $w
    tkwait window $w
}

#llxx========================================================================
# This is the new version of mkErrorDialog - it uses the dialog procedure 
# defined below.
#
proc mkErrorDialog {w text} {
    dialog $w "Error" "$text" "error" "0" "Ok"
}

#============================================================================
proc mkDialogBox {w title} {
    global xdialoggeometry ydialoggeometry
    global basefont boldfont
    
    catch {destroy $w}
    toplevel $w
    wm title $w $title
    wm geometry $w +$xdialoggeometry+$ydialoggeometry
    
    frame $w.top 
    pack $w.top -side top -pady 5
    frame $w.bottom 
    pack $w.bottom -side bottom -fill x
    frame $w.bottom.default -relief sunken -bd 1 
    pack $w.bottom.default -side left -expand 1 -padx 2m -pady 2m
    
    button $w.ok -text "OK" -font $boldfont -command "destroy $w"
    button $w.cancel -text "Cancel" -command "destroy $w" -font $basefont
    pack $w.ok -side left -in $w.bottom.default -padx 2m -pady 2m -ipadx 2m -ipady 1m
    pack $w.cancel -side left -in $w.bottom -pady 4 -expand 1
    wm protocol $w WM_TAKE_FOCUS "checkDialogGeometry $w"
}
#============================================================================
proc mkDialogBoxDescr {w args} {
    frame  $w.top.a 
    frame  $w.top.b 
    pack  $w.top.a -in $w.top -side top
    pack  $w.top.b -in $w.top -side top -pady 3m
    
    set i 0
    foreach descr $args {
	label $w.descr$i -text $descr
	pack  $w.descr$i -side top  -in $w.top.a
	incr i
    }
}

#============================================================================
proc makeOneEntry {w label var {wid 10}} {
    global basefont
    upvar #0 $var realvar
    label $w.label -text $label  -font $basefont
    entry $w.entry -width $wid -relief sunken -bd 2 -textvariable $var -font $basefont
    pack  $w.label -side left  -padx 2m
    pack  $w.entry -side left -padx 2m
    focus $w.entry
}
 
#lldd========================================================================
# DEFINE DOMAIN : Luiz
#============================================================================

proc DefineDomain {pwind} {
 
  global xgeometry ygeometry
  global basefont obliquefont boldfont
  global world_path domain_name domain_file
  global common_world_paths pathnum_dd
  global numDomains numDomainFiles
  global message
  global file_buttons

  global old_domain_file

  if { [string trimright $world_path "/"] == $world_path } {
    set world_path "$world_path\\"
  }
 
  set old_domain_file $domain_file

  set message "Type domain name in Domain Path entry or select it from list."
  set domain_file "domain.bld"
  catch {destroy .dd}
  toplevel .dd 
  # Commented out to allow user to place window as desired.
  #  checkGeometry $pwind
  #  wm geometry .dd +[expr $xgeometry+25]+[expr $ygeometry+25]
  wm title .dd " Domain Definition "
  wm iconname .dd "Definition"

  frame .dd.up -relief raised -bd 1 
  pack  .dd.up -side top -fill both
  frame .dd.up.world_path -bd 1 
  pack  .dd.up.world_path -side top
  frame .dd.up.cwp -bd 1 
  pack  .dd.up.cwp -side top -pady 4

  #===== world path

  label .dd.up.world_path.label -text "Domain Path:" -font $boldfont 
  entry .dd.up.world_path.entry -width 50 -textvariable world_path\
			 -font $basefont -relief sunken 
  pack  .dd.up.world_path.label -side left
  pack  .dd.up.world_path.entry -side left -fill x

  focus .dd.up.world_path.entry

  bind .dd.up.world_path.entry <Return>  {
   
    if { [file isdirectory $world_path] == 0 } {
        set domain_name [file tail $world_path]
        set option [dialog .d {Directory Creation} "The domain \"$domain_name\"\
		    doesn't exist. Would you like to create it?"\
		    questhead 0 {Create} {Cancel}]
        if { $option == 0} {
             #prever erro na criacao de Diretorio ou arquivo
	     exec mkdir $world_path
             set fileid [open $world_path\\domain.lisp a+]
             puts $fileid "File to store domain specification"
             close $fileid 
	     exec mkdir $world_path\\probs
	     set fileid_pro [open $world_path\\probs\\p1.lisp a+]
             puts $fileid_pro "File to store problem specification"
             close $fileid_pro 
             set world_path [file dirname $world_path]
             set message "The \"$domain_name\" domain was created. Click in Build Domain\
                          to define it."
             set numDomains [rescan .dd.mid.sb.dom_select.top.lb $world_path\
               	             $numDomains *\\] 
             if { [string trimright $world_path "\\"] == $world_path } {
                  set world_path "$world_path\\"
             }
             set world_path [string trimright $world_path $domain_name]
             set len [.dd.mid.sb.dom_select.top.lb size]
             set list ""
             for {set i 0} {$i < $len} {incr i} {
                  set list [linsert $list [llength $list] [.dd.mid.sb.dom_select.top.lb get $i]]
             }
            
             set pos [lsearch -exact $list "$domain_name\\"]
             .dd.mid.sb.dom_select.top.lb select from $pos
             if {$pos >= 10 } {
                 set top_pos [expr $pos  -5]
             } else {
                     set top_pos 0
             }
            .dd.mid.sb.dom_select.top.lb yview $top_pos         

         } else {
	       	 set message "The creation of domain  \"$domain_name\"  was canceled"
                 .dd.mid.sb.dom_select.top.lb delete 0 $numDomains
         }
    } else {
             set domain_name [file tail $world_path]
             set world_path [string trimright $world_path $domain_name]
             set len [.dd.mid.sb.dom_select.top.lb size]
             set list ""
             for {set i 0} {$i < $len} {incr i} {
                  set list [linsert $list [llength $list] [.dd.mid.sb.dom_select.top.lb get $i]]
             }
                   
             set pos [lsearch -exact $list "$domain_name\"]
             if {$pos >= 10 } {
                 set top_pos [expr $pos  -5]
             } else {
                     set top_pos 0
             }
             .dd.mid.sb.dom_select.top.lb select from $pos
             .dd.mid.sb.dom_select.top.lb yview $top_pos
             set message "You can view or update \"$domain_name\" domain. Choose button and click\
                          on it."
    }
  
  }

  #===== common world paths
  set i 0
  foreach path $common_world_paths {
    radiobutton .dd.up.cwp.r$i -text "$path" -font $basefont -variable pathnum_dd -value $i -anchor sw
    pack .dd.up.cwp.r$i -fill x
    incr i
  }
  trace variable pathnum_dd w setWorldPath_dd
  
 
  #===== selection boxes
  frame .dd.mid -relief raised -bd 1 
  pack  .dd.mid -side top -fill both
  frame .dd.mid.sb 
  pack  .dd.mid.sb -side top
    #===== domain selection box
    frame .dd.mid.sb.dom_select 
    pack  .dd.mid.sb.dom_select -side left
    frame .dd.mid.sb.dom_select.top 
    pack  .dd.mid.sb.dom_select.top -side top
    label .dd.mid.sb.dom_select.top.label -text "Domain" -font $boldfont -relief sunken
    pack  .dd.mid.sb.dom_select.top.label -side top -fill x
    mkScrollSelectionBox .dd.mid.sb.dom_select.top
    set numDomains [addFiles .dd.mid.sb.dom_select.top.lb $world_path *\\]
    bind .dd.mid.sb.dom_select.top.lb <Double-Button-1> {
          set domain_name [selection get]
          set message "You can view or update \"$domain_name\" domain. Choose button and\
                       click on it."
    }
#    bind .dd.mid.sb.dom_select.top.lb <Button-1> {
#          set domain_name [selection get]
#          set message "You can view or update \"$domain_name\" domain. Choose button and\
                       click on it."
#    }
  #===== buttons
  frame .dd.bot -bd 1 
  pack  .dd.bot -side top -fill both
  frame .dd.bot.buttons 
  pack  .dd.bot.buttons -side top -fill x

#  set pathnum_dd 1

  button .dd.bot.buttons.delete -text "Delete Domain" -bd 2 \
	  -font $basefont \
	  -command {
      if {[selection own] != ".dd.mid.sb.dom_select.top.lb"} {
	  set message "Select the domain which will be deleted."
      } else {
	  if {[file writable $world_path] == 0} {
	      set message "Sorry! Couldn't delete \"$world_path\"."
	      return
	  } else {
	      DeleteDomain [selection get] .dd.mid.sb.dom_select.top.lb}}}
        
  button .dd.bot.buttons.close -text Close -relief raised -bd 2 \
	  -font $basefont \
	  -command {
      set domain_file $old_domain_file
      destroy .dd
  }

  button .dd.bot.buttons.viewdomain -text "View Domain" -relief raised -bd 2 \
	  -font $basefont \
	  -command {
      if {[selection own] != ".dd.mid.sb.dom_select.top.lb" || [selection own] == "" } {
	  set message "First, select the domain whick you want to view."
      } else {
	  set domain_name [selection get]
	  grab release .dd
	  #view domain.lisp file
	  set domain_file $old_domain_file
	  viewDomainFile
	  set old_domain_file $domain_file
  }   }

  button .dd.bot.buttons.buildomain -text "Build Domain" -relief raised -bd 2 \
	  -font $basefont \
	  -command {
      if {[selection own] != ".dd.mid.sb.dom_select.top.lb"} {
	  set message "Select the domain which will be builted."
      } else {
	  set domain_name [selection get]
	  set path "$world_path$domain_name"
	  if {[file writable $path] == 0} {
	      dialog .d {Error} "Couldn't open \"$path\" for \
		      writing. Check your rights in current directory." error 0 Ok
	      return
	  } else {
	      BuildDomain [selection get] .dd}}}

  pack .dd.bot.buttons.viewdomain .dd.bot.buttons.buildomain -side left -expand 1 -fill x
  pack .dd.bot.buttons.delete .dd.bot.buttons.close -side left -expand 1 -fill x

   #===== Display messages to user

#  label .dd.bot.displaymsg -text "\"$message\"" -font $obliquefont
  label .dd.bot.displaymsgvalue -textvariable message -font $obliquefont\
		 -relief sunken 
#  pack  .dd.bot.displaymsg 
  pack  .dd.bot.displaymsgvalue -side bottom -fill x 
 
#  bind .dd.bot.buttons.viewdomain <Any-Enter> {set message "View the selected domain" }
#  bind .dd.bot.buttons.buildomain <Any-Enter> {set message "Build the selected domain" }
#  bind .dd.bot.buttons.delete     <Any-Enter> {set message "Delete the selected domain" }
#  bind .dd.bot.buttons.close      <Any-Enter> {set message "Close window and return to \
                                                previous one" }

  tkwait visibility .dd
  
}

#llddxx======================================================================
# DELETE DOMAIN   
#============================================================================
proc DeleteDomain {domain window} {
   global world_path numDomains
   global message

   set numdir [llength $domain]
   set domain_aux $domain
   set delete_all 0
   foreach args $domain {
        set args [string trimright $args "/"] 
        set dirname "$world_path$args"
        if { $delete_all == 0 } {
             set option [dialog .d {Confirm Domain Deletion} "The selectioned domains\
             \"$domain_aux\" will be deleted. Are you sure to remove them from the path?"\
             questhead 0 {Yes for all} {Yes} {Cancel}]
        }
        if {$option == 0} { 
            set delete_all 1
            exec rm -r $dirname
            set message "All selected domains \"$domain\" were deleted."
        }
        if {$option == 1} {
            exec rm -r $dirname
            set domain_aux [lreplace $domain_aux 0 0]
            set message "The domain \"$args\" was deleted."
        }
        if {$option == 2} {
            set message "The Delete command was canceled."
            return
        }
   }
   set message "The domain \"$domain\" was deleted."
   set numDomains [rescan $window $world_path $numDomains *\\]

}

proc status_dom_struc {name element op} {
   global save
   set save 0
}

#llsdsx======================================================================
# SAVE DOM_STRUC
#============================================================================

proc SaveDomStruc {} {

   global file_name_tmp file_name
   global dom_struc itype_struc
   global save

   if {[file isfile $file_name_tmp] != 0} {
       exec rm $file_name_tmp
   }
   set fileid [open $file_name_tmp a+]
   set i 0
   set last [expr [llength $dom_struc] -1]       
   foreach args $dom_struc {
         foreach args_int $args {
             if {$i >= 3} {
                 if {$i == $last} {
                     puts $fileid $args_int
                 } else {
                          foreach argi $args_int { 
                               puts $fileid $argi
                          }
                 }
             } else {
                     puts $fileid $args_int
             }
         }
   incr i
   }

   puts $fileid "INFINITE_TYPE:"
   foreach args $itype_struc {
       puts $fileid $args
   }
#This variable controls the status of changes of the dom_struc. 1 = save ; 0 = not save
   set save 1
   close $fileid
   exec cp $file_name_tmp $file_name
}
  
#llbdxx======================================================================
# BUILD DOMAIN   
#============================================================================
proc BuildDomain { domain pwind} {
  
   global world_path domain_name olddomain_name
   global boldfont basefont obliquefont
   global xgeometry ygeometry
   global dom_struc pred_struc itype_struc

   global file_name space_name save
   global file_name_tmp
   global user_msg
  
   set olddomain_name $domain_name

# The structure below will be updated during the Domain Definiton. The reserved slots
# are:
# dom_struc { {Problem_space: } {ptype_of: } {pinstance_of: } { {operator: }\
#             {params: } {preconds_var: } {preconds_pred: } {effects_var:} {effects_del: }\
#             {effects_add:} } 
#           }
# The pred_struc is hooked at the end of dom_struc, but itype_struc is maintained alone. This
# is not good but it works.
   
   set dom_struc {{Problem_space:} {ptype_of:} {pinstance_of:}}
   set pred_struc ""   
   set itype_struc ""
   set user_msg "User Message Area"
   set update_file_lisp 0
  
   if {[llength $domain] != 1} {
       set user_msg "Multiple Selection - Ignore other elements of list"
       set domain_name [string trimright [lindex $domain 0] "\\"]
   } else {
           set domain_name [string trimright $domain "\\"]
   }
   set file_name "$world_path$domain_name\\domain.bld"
   set file_name_tmp "$world_path$domain_name\\domain.tmp"
 
   if {[winfo exists .bdomain] == 1} {
       set xybdomain [wm geometry .bdomain]
       destroy .bdomain
   }

   toplevel .bdomain
   checkGeometry $pwind
   wm geometry .bdomain "+[expr $xgeometry+25]+[expr $ygeometry+25]"
   wm title .bdomain "BUILD OR UPDATE DOMAIN : \"$domain_name\""


   frame .bdomain.up -bd 1 -relief raised 
   pack  .bdomain.up -side top -fill both
   frame .bdomain.mid -bd 1 -relief raised 
   pack  .bdomain.mid -side top -fill both
   frame .bdomain.bot -bd 1 -relief raised 
   pack  .bdomain.bot -side top -fill both 
   
   label .bdomain.up.label -text "Problem Space Name: " -font $boldfont
   entry .bdomain.up.entry -width 20 -textvariable space_name -font $basefont\
	 -relief sunken
   pack .bdomain.up.label .bdomain.up.entry -side left


   frame .bdomain.mid.buttvert 
   pack  .bdomain.mid.buttvert -side top

   button .bdomain.mid.buttvert.0 -text "Infinite Type" -relief raised -bd 2 \
	   -font $basefont  \
	   -command {InfiniteType .bdomain} 

   button .bdomain.mid.buttvert.1 -text "Type Hierarchy" -relief raised -bd 2 \
	   -font $basefont \
	   -command {TypeHierarchy .bdomain} 

   button .bdomain.mid.buttvert.2 -text "Domain Instances" -relief raised -bd 2 \
	   -font $basefont \
	   -command { 
       if {[lindex [lindex $dom_struc 1] 1] == ""} {
	   dialog .d {Warning} "Sorry! You can't define instances before defining object\
		   types." warning 0 Ok
       } else {InstanceType .bdomain}
   }   
   button .bdomain.mid.buttvert.3 -text "Predicates" -relief raised -bd 2 \
	   -font $basefont \
	   -command {DefinePredicates .bdomain}

#DefinePredicates procedure is in the ui1.tcl file
          
   button .bdomain.mid.buttvert.4 -text "Operators" -relief raised -bd 2 \
	   -font $basefont \
	   -command {DefineOperators .bdomain}

   button .bdomain.mid.buttvert.5 -text "Inference Rules" -relief raised -bd 2 \
	   -font $basefont \
           -command {set user_msg "not implemented yet"}
 
   button .bdomain.mid.buttvert.6 -text "Control Rules" -relief raised -bd 2 \
	   -font $basefont \
           -command {set user_msg "not implemented yet"}

   pack .bdomain.mid.buttvert.0 -side top -expand 1 -pady 1 -fill x  
   pack .bdomain.mid.buttvert.1 -side top -expand 1 -pady 1 -fill x
   pack .bdomain.mid.buttvert.2 -side top -expand 1 -pady 1 -fill x
   pack .bdomain.mid.buttvert.3 -side top -expand 1 -pady 1 -fill x
   pack .bdomain.mid.buttvert.4 -side top -expand 1 -pady 1 -fill x
   pack .bdomain.mid.buttvert.5 -side top -expand 1 -pady 1 -fill x
   pack .bdomain.mid.buttvert.6 -side top -expand 1 -pady 1 -fill x
   button .bdomain.bot.gen -text "Generate File" -relief raised -bd 2 \
	   -font $basefont \
	   -command {        
       GenerateDomainLisp
       set update_file_lisp 1
   }
   set save 1
   button .bdomain.bot.save -text "Save" -relief raised -bd 2 \
	   -font $basefont \
	   -command {        
       SaveDomStruc
       set user_msg "The domain \"$domain_name\" was saved"
   }
   set save 1
   button .bdomain.bot.close -text "Close" -relief raised -bd 2 \
	   -font $basefont \
	   -command { 
       if {$save == 0} {
	   set option [dialog .d {Save Domain} {The domain has been modified since your last\
		   savings. Do you like to save last changes ?} questhead 0 {Yes} {No}]
	   if {$option == 0} {
	       SaveDomStruc
	       if {$update_file_lisp == 0} {
		   set option [dialog .d {Domain Generation} "Would you like to generate\
			   \"domain.lisp\" file ?" questhead 0 Yes No]
		   if {$option == 0} {
		       GenerateDomainLisp
		   }
	       }
	   }
       }
       if {[file isfile $file_name_tmp] != 0} {  
	   exec cp $file_name_tmp $file_name
	   exec rm $file_name_tmp
       }
       set domain_name $olddomain_name
       destroy .bdomain
       set space_name ""
   }

   pack .bdomain.up.label .bdomain.up.entry -side left
   pack .bdomain.bot.gen  -side left -expand 1 -fill x
   pack .bdomain.bot.save  -side left -expand 1 -fill x
   pack .bdomain.bot.close  -side left -expand 1 -fill x

   label .bdomain.msg -textvariable user_msg -font $obliquefont -relief raised
   pack  .bdomain.msg -side top -fill x
 
#Begin of the procedures actions
   

   if {[file isfile $file_name] == 0} {
       set user_msg "This is a new domain."
       .bdomain.mid.buttvert.0 configure -state disabled
       .bdomain.mid.buttvert.1 configure -state disabled
       .bdomain.mid.buttvert.2 configure -state disabled
       .bdomain.mid.buttvert.3 configure -state disabled
       .bdomain.mid.buttvert.4 configure -state disabled
       .bdomain.mid.buttvert.5 configure -state disabled
       .bdomain.mid.buttvert.6 configure -state disabled
       .bdomain.bot.save configure -state disabled
       set fileid [open $file_name_tmp a+]
       close $fileid
       set dom_struc [linsert $dom_struc [llength $dom_struc] "predicates:"]
       set save 1      

   } else {
           exec cp $file_name $file_name_tmp
           set fileid [open $file_name r]
	   set user_msg "This is an old domain. You can do changes"
           ReadFileLine $fileid
           if {$pred_struc == ""} {
               set dom_struc [linsert $dom_struc [llength $dom_struc] "predicates:"]
           } else {
                   set dom_struc [linsert $dom_struc [llength $dom_struc] "predicates: $pred_struc"]
           }
           close $fileid
           set space_name [lindex [lindex $dom_struc 0] 1]
           set save 1
           trace variable dom_struc w status_dom_struc    
   } 

   bind .bdomain.up.entry <Return> {
       if {$space_name == ""} {
           set user_msg "Please! Enter a valid Problem space name."
           return
       }

       set dom_struc [lreplace $dom_struc 0 0 "Problem_space: $space_name"]
       .bdomain.mid.buttvert.0 configure -state normal
       .bdomain.mid.buttvert.1 configure -state normal
       .bdomain.mid.buttvert.2 configure -state normal
       .bdomain.mid.buttvert.3 configure -state normal
       .bdomain.mid.buttvert.4 configure -state normal
       .bdomain.mid.buttvert.5 configure -state normal
       .bdomain.mid.buttvert.6 configure -state normal
       .bdomain.bot.save configure -state normal 
       set user_msg "Ok! This input was good"
   }

   tkwait visibility .bdomain
   
}

proc TestIfToken {filep} {

   global line_read

   set End_of_File [gets $filep line_read]

   if {($line_read == "pinstance_of:") || ($line_read == "operator:") || ($line_read == "params:") ||\
       ($line_read == "preconds_var:") || ($line_read == "preconds_pred:") || ($line_read == "effects_var:") ||\
       ($line_read == "effects_del:") || ($line_read == "effects_add:") || ($line_read == "predicates:") ||\
      ($line_read == "INFINITE_TYPE:") || ($End_of_File == -1)} {
       return 0
   } else {
            return 1
   }
}

#llrfxx======================================================================
# Read File and update dom_struc
#============================================================================

proc ReadFileLine {filep} {

   global dom_struc pred_struc itype_struc line_read

   set line_read 0
   set first_time 1
   while {$line_read >= 0} {
          if {$first_time == 1} {
              gets $filep line_read
              set first_time 0
          }
          switch $line_read {
                 Problem_space: {
                                  gets $filep line_read
                                  set list1 [linsert [lindex $dom_struc 0] 1 $line_read]
                                  set list2 [lreplace $dom_struc 0 0 $list1]
                                  set dom_struc $list2
                                  gets $filep line_read
                                }
                 ptype_of:      {
                                  while {[TestIfToken $filep] != 0} {
                                    set list1 [linsert [lindex $dom_struc 1] 1 $line_read]
                                    set list2 [lreplace $dom_struc 1 1 $list1]
                                    set dom_struc $list2
                                  } 
                                }
                 pinstance_of:  {
                                  while {[TestIfToken $filep] != 0} {
                                    set list1 [linsert [lindex $dom_struc 2] 1 $line_read]
                                    set list2 [lreplace $dom_struc 2 2 $list1]
                                    set dom_struc $list2 
                                  }
                                }
                 operator:      {
                                 set oper_struc_a { {operator:} {params:} {preconds_var:} {preconds_pred:}\
                                                  {effects_var:} {effects_del:} {effects_add:} }

                                 set dom_struc [linsert $dom_struc [llength $dom_struc] $oper_struc_a]
                                 while {[TestIfToken $filep] != 0} {
                                        InsertData 10 
                                 }
                                }
                 params:        {
                                 while {[TestIfToken $filep] != 0} {
                                        InsertData 11
                                 }
                                }
                 preconds_var:  {
                                 while {[TestIfToken $filep] != 0} {
                                        InsertData 12
                                 }
                                }
                 preconds_pred: {
                                 while {[TestIfToken $filep] != 0} {
                                        InsertData 13
                                 }
                                }
                 effects_var:   {
                                 while {[TestIfToken $filep] != 0} {
                                        InsertData 14
                                 }
                                }
                 effects_del:   {                            
                                 while {[TestIfToken $filep] != 0} {
                                        InsertData 15
                                 }
                                }
                 effects_add:   {
                                 while {[TestIfToken $filep] != 0} {
                                        InsertData 16
                                 }
                                }
                 predicates:    {
                                 while {[TestIfToken $filep] != 0} {
                                 set pred_struc [linsert $pred_struc [llength $pred_struc] $line_read]
                                 }
                                }
                 INFINITE_TYPE: {
                                 while {[TestIfToken $filep] != 0} {
                                 set itype_struc [linsert $itype_struc [llength $itype_struc] $line_read]
                                 }
                                }
                 default {}
         }
    }
}                 

proc InsertData {position} {
   global dom_struc line_read

   set last [expr [llength $dom_struc]-1]
   set npos [expr $position-10]
   set list1 [lindex $dom_struc $last] 
   set list11 [lindex $list1 $npos]
   set list2 [linsert $list11 [llength $list11]  $line_read]
   set list1 [lreplace $list1 $npos $npos $list2]
   set dom_struc [lreplace $dom_struc $last $last $list1]
}
#llthxx======================================================================
# InfiniteType
#============================================================================

proc InfiniteType {pwind} {

   global world_path domain_name
   global boldfont basefont obliquefont
   global xgeometry ygeometry
   
   global itype_struc

# This procedure updates the "infinite_type" structure:

   toplevel .it
   checkGeometry $pwind
   wm geometry .it "+[expr $xgeometry+25]+[expr $ygeometry+25]"
   wm title .it "INFINITE TYPE DEFINITION : \"$domain_name\""

   frame .it.up -bd 1 -relief raised 
   pack  .it.up -side top -fill both
   frame .it.mid -bd 1 -relief raised 
   pack  .it.mid -side top -fill both
   frame .it.mid.right -bd 1 -relief raised 
   pack  .it.mid.right -side right -fill both
   frame .it.bot -bd 1 -relief raised 
   pack  .it.bot -side top -fill both 
   
   label .it.up.label -text "Name: " -font $boldfont
   entry .it.up.entry -width 20 -textvariable it_name -font $basefont\
	 -relief sunken
   pack .it.up.label .it.up.entry -side left
   
   label .it.up.func -text "Function Name: " -font $boldfont
   entry .it.up.efunc -width 20 -textvariable func_name -font $basefont\
	 -relief sunken
   pack .it.up.func -side left
   pack .it.up.efunc -side left

   label .it.mid.right.label -text "Infinite Type List" -relief raised -font $boldfont
   pack  .it.mid.right.label -side top  -fill x -expand 1

   scrollbar .it.mid.right.scrbar -relief sunken \
	   -command ".it.mid.right.object yview"
   pack      .it.mid.right.scrbar  -side right -fill y

   listbox   .it.mid.right.object -relief raised -borderwidth 2 \
                             -yscrollcommand ".it.mid.right.scrbar set" -font $basefont
   pack      .it.mid.right.object  -side right -fill y

   frame .it.mid.left -relief raised 
   pack  .it.mid.left -side left
   label .it.mid.left.bitmap -bitmap info
   pack  .it.mid.left.bitmap -side top -padx 3m -pady 3m
   message .it.mid.left.msg -width 3i -text "\"To define infinite type, enter the\
            variable name and specify a membership function.\"" -font $basefont
   pack    .it.mid.left.msg -side top 

   button .it.bot.delete -text "Delete" -relief raised -bd 2 \
	   -font $basefont \
	   -command { 
       if {[selection own] != ".it.mid.right.object"} {
	   set it_msg "Incorrect Selection! Select object types from list."
       } else {
	   DeleteInfiniteType [selection get] .it.mid.right.object 
   }   }
   
   button .it.bot.help -text "Help" -relief raised -bd 2 \
	   -font $basefont \
	   -command { 
       set it_msg "Help on-line, reserved for future implementation."
   }  

   button .it.bot.close -text "Close" -relief raised -bd 2 \
	   -font $basefont \
	   -command { 
       destroy .it
   }

   pack .it.bot.help  -side left -expand 1 -fill x
   pack .it.bot.delete  -side left -expand 1 -fill x
   pack .it.bot.close  -side left -expand 1 -fill x

   label .it.msg -textvariable it_msg -width 50 -font $obliquefont -relief raised
   pack  .it.msg -side top -fill x
   pack .it.up.label .it.up.entry -side left
   
#==Update listbox
   foreach args $itype_struc {
      .it.mid.right.object insert end $args
   }
   focus .it.up.entry
   bind .it.up.entry <Return> {
        set obj_rep 0  
        if {$it_name == ""} {
            set it_msg "Enter a valid infinite type name."
        } else {
                if {$itype_struc != ""} {
                   foreach args $itype_struc {
                      if {$it_name == [lindex $args 0]} {
                          dialog .d {Warning - Object Repetion}\
                              "The infinite type \"$it_name\"\
                               already exists in the domain" warning 0 Ok
                          set obj_rep 1
                          break
                      }
                    }
                 }
                if {$obj_rep == 0} { 
                    set it_msg "Ok! This is a valid input."
                   focus .it.up.efunc
                }
         }
     }

   bind .it.up.efunc <Return> {
        set func "#'$func_name"
        .it.mid.right.object insert end "$it_name $func"
        set itype_struc [linsert $itype_struc [llength $itype_struc] "$it_name $func"]
        set func_name ""
        set it_name ""
        focus .it.up.entry
        }

   tkwait visibility .it
   grab set .it
}

                             
#llthxx======================================================================
# Typehierarchy
#============================================================================

proc TypeHierarchy {pwind} {

   global world_path domain_name
   global boldfont basefont obliquefont
   global xgeometry ygeometry
   global dom_struc

   global file_name
   global file_name_tmp
   global user_msg
     
# This procedure update the "ptype_of" slot of the following:
# dom_struc { {Problem_space: }  {ptype_of: } {pinstance_of: } { {operator: }\
#             {params_op: } {params_pre: } {preconds: }} {effects: {params_eff: }\
#             {ADD: } {DEL: }} }
 
   toplevel .dot
   checkGeometry $pwind
   wm geometry .dot "+[expr $xgeometry+25]+[expr $ygeometry+25]"
   wm title .dot "TYPE HIERARCHY DEFINITION : \"$domain_name\""

   frame .dot.up -bd 1 -relief raised 
   pack  .dot.up -side top -fill both
   frame .dot.mid -bd 1 -relief raised 
   pack  .dot.mid -side top -fill both
   frame .dot.mid.right -bd 1 -relief raised 
   pack  .dot.mid.right -side right -fill both
   frame .dot.bot -bd 1 -relief raised 
   pack  .dot.bot -side top -fill both 
   
   label .dot.up.label -text "Top-type: " -font $boldfont
   entry .dot.up.entry -width 20 -textvariable object_name -font $basefont\
	 -relief sunken
   pack .dot.up.label .dot.up.entry -side left

   label .dot.mid.right.label -text "Type Hierarchy List" -relief raised -font $boldfont
   pack  .dot.mid.right.label -side top  -fill x -expand 1

   scrollbar .dot.mid.right.scrbar -relief sunken \
	   -command ".dot.mid.right.object yview"
   pack      .dot.mid.right.scrbar  -side right -fill y

   listbox   .dot.mid.right.object -relief raised -borderwidth 2 \
                             -yscrollcommand ".dot.mid.right.scrbar set" -font $basefont
   pack      .dot.mid.right.object  -side right -fill y

   frame .dot.mid.left -relief raised 
   pack  .dot.mid.left -side left
   label .dot.mid.left.bitmap -bitmap info
   pack  .dot.mid.left.bitmap -side top -padx 3m -pady 3m
   message .dot.mid.left.msg -width 3i -text "\"To define sub-class, select object in Type List and\
           click button-1 twice.\"" -font $basefont
   pack    .dot.mid.left.msg -side top 

   button .dot.bot.delete -text "Delete" -relief raised -bd 2 \
	   -font $basefont \
	   -command { 
       if {[selection own] != ".dot.mid.right.object"} {
	   set obj_msg "Incorrect Selection! Select object types from list."
       } else {
	   DeleteObject [selection get] .dot.mid.right.object 1
   }   }
   
   button .dot.bot.insert -text "Graphic View" -relief raised -bd 2 \
	   -font $basefont \
	   -command { 
       set obj_msg "Not implemented yet"
   }  

   button .dot.bot.close -text "Close" -relief raised -bd 2 \
	   -font $basefont \
	   -command { 
       destroy .dot
   }
  
   pack .dot.bot.delete  -side left -expand 1 -fill x
   pack .dot.bot.insert  -side left -expand 1 -fill x
   pack .dot.bot.close  -side left -expand 1 -fill x

   label .dot.msg -textvariable obj_msg -width 50 -font $obliquefont -relief raised
   pack  .dot.msg -side top -fill x
   pack .dot.up.label .dot.up.entry -side left
   
#==Update listbox
   foreach args [lsort [lreplace [lindex $dom_struc 1] 0 0]] {
      .dot.mid.right.object insert end $args
   }
   focus .dot.up.entry
   bind .dot.up.entry <Return> {
        set final 0         
        set obj_rep 0  
        if {$object_name == ""} {
            set obj_msg "Please! Enter a valid top-type name."
            return
        }
        if {[string match *. $object_name] == 1} {
            set object_name [string trimright $object_name "."]
            set final 1
        } 
        set list1 [lindex $dom_struc 1]
        foreach args $list1 {
           if {$args == "$object_name :top-type"} {
               dialog .d {Warning - Object Repetion} "Sorry! The object \"$object_name\"\
                          already exists in the list" warning 0 Ok
               set obj_rep 1
               break
           } 
        }
        if {$obj_rep == 0} {
            set list2 [linsert $list1 1 "$object_name :top-type"]
            set list3 [lreplace $dom_struc 1 1 $list2]
            set dom_struc $list3
            .dot.mid.right.object insert end "$object_name :top-type"
        }
        set object_name ""
        if {$final == 1} {
            destroy .dot
        }
   }

   bind .dot.mid.right.object <Double-Button-1> {
                SubType [selection get] .dot.mid.right.object
                focus .dot.up.entry}

   tkwait visibility .dot
   grab set .dot
}

#llstxx======================================================================
# SUBTYPE DEFINITION
#============================================================================

proc SubType {ptype subtypewind} {

     global basefont boldfont obliquefont
     global dom-struc 

     global gsubtypewind type gdw subtype_msg oldfocus

     set gsubtypewind $subtypewind
     set type [lindex [lindex $ptype 0] 0]

          # Create the top level window and divide it into top and bottom parts.

     toplevel .dw 
     wm title .dw "SUBTYPE DEFINITION OF : \"$type\""

     wm geometry .dw +345+345
     frame .dw.top -relief raised -bd 1 
     pack  .dw.top -side top -fill both
     frame .dw.bot -relief raised -bd 1 
     pack  .dw.bot -side top -fill both
     frame .dw.b -relief raised -bd 1 
     pack  .dw.b -side bottom -fill both
     set gdw .dw

     # Fill the top part with the bitmap and the message.
  
     message .dw.top.msg -width 3i -text {Enter the subtype name you\
              want to define. To end, add "." in subtype name and type Return\
              or click Close} -font $basefont
     pack .dw.top.msg -side right -expand 1 -fill both -padx 3m -pady 3m
     label .dw.top.bitmap -bitmap info
     pack  .dw.top.bitmap -side left -padx 3m -pady 3m
     
     label .dw.b.msg -textvariable subtype_msg -font $obliquefont -relief raised -width 30
     pack  .dw.b.msg  -side bottom -fill x 
     set subtype_msg "The object type \"$type\" was selected."    
     
     button .dw.bot.close -text Close \
	     -command {destroy $gdw; set subtype_msg ""; focus $oldfocus}
     pack .dw.bot.close -side right 
     label .dw.bot.label -text "Subtype name:" -font $boldfont
     entry .dw.bot.entry -width 20 -textvariable subtype_name -font $basefont\
	 -relief sunken
     pack .dw.bot.label .dw.bot.entry -side left

     bind .dw.bot.entry <Return> {
        set final 0         
        set obj_rep 0  
        
        if {[string match *. $subtype_name] == 1} {
            set subtype_name [string trimright $subtype_name "."]
            set final 1
        } 
        if {$subtype_name == ""} {
            set subtype_msg "Please! Enter a valid object name."
            return
        }
        set list1 [lindex $dom_struc 1]
        foreach args $list1 {
           if {[lindex [lindex $args 0] 0] == $subtype_name} {
               dialog .d {Warning - Object Repetion} "Sorry! The object \"$subtype_name\"\
                          already exists in the list" warning 0 Ok
               set obj_rep 1
               break
           } 
        }
        if {$obj_rep == 0} {
            set list2 [linsert $list1 1 "$subtype_name $type"]
            set list3 [lreplace $dom_struc 1 1 $list2]
            set dom_struc $list3
            $gsubtypewind insert end "$subtype_name $type"
        }
        set subtype_name ""
        if {$final == 1} {
            set subtype_msg ""
            destroy $gdw
        }
    }
     set oldfocus [focus]
     tkwait visibility .dw
     grab set .dw
     focus .dw.bot.entry
}


#llitxx======================================================================
# InstanceType
#============================================================================

proc InstanceType {pwind} {

   global world_path domain_name
   global boldfont basefont obliquefont
   global xgeometry ygeometry
   global dom_struc

   global file_name
   global file_name_tmp
   global user_msg
   global inst_msg
   global inst_obj_type
   
   set inst_msg "First select object type. End entry with \".\""
  
# This procedure update the "pinstance_of" slot of the following:
# dom_struc { {Problem_space: }  {ptype_of: } {pinstance_of: } { {operator: }\
#             {params_op: } {params_pre: } {preconds: }} {effects: {params_eff: }\
#             {ADD: } {DEL: }} }
   
   toplevel .inst
   checkGeometry $pwind
   wm geometry .inst "+[expr $xgeometry+25]+[expr $ygeometry+25]"
   wm title .inst "INSTANCE DEFINITION : \"$domain_name\""


   frame .inst.up -bd 1 -relief raised 
   pack  .inst.up -side top -fill both
   frame .inst.mid -bd 1 -relief raised 
   pack  .inst.mid -side top -fill both
   frame .inst.mid.right -bd 1 -relief raised 
   pack  .inst.mid.right -side right -fill both
   frame .inst.mid.left -bd 1 -relief raised 
   pack  .inst.mid.left -side left -fill both
   frame .inst.bot -bd 1 -relief raised 
   pack  .inst.bot -side top -fill both 
   
   label .inst.up.label -text "Instance name:" -font $boldfont
   pack .inst.up.label -side left



   label .inst.mid.left.label -text "Object Type List" -relief raised -font $boldfont
   pack  .inst.mid.left.label -side top  -fill x -expand 1

   scrollbar .inst.mid.left.scrbar -relief sunken \
	   -command ".inst.mid.left.object yview"
   pack      .inst.mid.left.scrbar  -side right -fill y

   listbox   .inst.mid.left.object -relief raised -borderwidth 2 \
                             -yscrollcommand ".inst.mid.left.scrbar set" -font $basefont
   pack      .inst.mid.left.object  -side left -fill y

# This isn't working yet 
#  bind .inst.mid.left.object <Button-1> { set inst_msg "The object type \"[selection get]\" was selected."}

   button .inst.bot.delete -text "Delete" -relief raised -bd 2 \
	   -font $basefont \
	   -command { 
       if {[selection own] != ".inst.mid.right.object"} {
	   set inst_msg "Incorrect Selection! Select instances will be deleted."
       } else {
	   DeleteObject [selection get] .inst.mid.right.object 2
   }   }

   button .inst.bot.insert -text "Insert" -relief raised -bd 2 \
	   -font $basefont \
	   -command {}  

   button .inst.bot.close -text "Close" -relief raised -bd 2 \
	   -font $basefont \
	   -command { 
       destroy .inst
       set inst_name ""
   }

  
   pack .inst.bot.delete  -side left -expand 1 -fill x
   pack .inst.bot.insert  -side left -expand 1 -fill x
   pack .inst.bot.close  -side left -expand 1 -fill x

   label .inst.msg -textvariable inst_msg -width 50 -font $obliquefont -relief raised
   pack  .inst.msg -side top -fill x

#==Update object listbox
   foreach args [lsort [lreplace [lindex $dom_struc 1] 0 0]] {
      .inst.mid.left.object insert end $args
   }

   pack .inst.up.label  -side left
   bind .inst.mid.left.object <Double-Button-1> {
        InputInstance [selection get] .inst
        }
   tkwait visibility .inst
   grab set .inst
}


#lldoit===================================================================================
# DELETE OBJECTS INFINITE TYPE
#=========================================================================================

proc DeleteInfiniteType {object list_obj} {
   global itype_struc
   set numobj [llength $object]
   set object_aux $object
   set delete_all 0
   foreach args $object {
        if { $delete_all == 0 } {
             set option [dialog .d {Confirm Object Deletion} "The selectioned objects \"$object_aux\"\
             will be deleted. Are you sure to remove them from the list?" questhead 0\
               {Yes for all} {Yes} {Cancel}]
        }
        if {$option == 0} { 
            set delete_all 1
            set el_pos [lsearch $itype_struc $args]
            if {$el_pos == -1} {
                dialog .d {Context error} "The object \"$args\" doesn't exist in list." error 0 Ok
            } else {
                    set itype_struc [lreplace $itype_struc $el_pos $el_pos]
            }
        }
        if {$option == 1} {
            set el_pos [lsearch $itype_struc $args]
            if {$el_pos == -1} {
                dialog .d {Context error} "The object \"$args\" doesn't exist in list." error 0 Ok
                close
            } else {
                    set itype_struc [lreplace $itype_struc $el_pos $el_pos]
            }
        }
        if {$option == 2} {
            return
        }
   }
#==Update object listbox
   $list_obj delete 0 end
   foreach args $itype_struc {
      $list_obj insert end $args
   }
}

#lldoxx===================================================================================
# DELETE OBJECTS - instances ou objects types
#=========================================================================================

proc DeleteObject {object list_obj type} {
   global dom_struc
   set numobj [llength $object]
   set object_aux $object
   set delete_all 0
   foreach args $object {
        if { $delete_all == 0 } {
             set option [dialog .d {Confirm Object Deletion} "The selectioned objects \"$object_aux\"\
             will be deleted. Are you sure to remove them from the list?" questhead 0\
               {Yes for all} {Yes} {Cancel}]
        }
        if {$option == 0} { 
            set delete_all 1
            set list1 [lreplace [lindex $dom_struc $type] 0 0]

#You have to add 1 because I took off the "ptype_of:" title of the list

            set el_pos [expr [lsearch $list1 $args] + 1]
            if {$el_pos == -1} {
                dialog .d {Context error} "The object \"$args\" doesn't exist in list." error 0 Ok
            } else {
                    set list2 [lreplace [lindex $dom_struc $type] $el_pos $el_pos]
                    set dom_struc [lreplace $dom_struc $type $type $list2]
            }
        }
        if {$option == 1} {
            set list1 [lindex $dom_struc $type]
            set el_pos [lsearch $list1 $args]
            if {$el_pos == -1} {
                dialog .d {Context error} "The object \"$args\" doesn't exist in list." error 0 Ok
                close
            } else {
                    set list2 [lreplace [lindex $dom_struc $type] $el_pos $el_pos]
                    set dom_struc [lreplace $dom_struc $type $type $list2]
            }
        }
        if {$option == 2} {
            return
        }
   }
#==Update object listbox
   $list_obj delete 0 end
   foreach args [lsort [lreplace [lindex $dom_struc $type] 0 0]] {
      $list_obj insert end $args
   }
}

#=========================================================================================
# INPUT INSTANCE NAME
#=========================================================================================
proc InputInstance {object wind} {
   global inst_name
   global inst_msg
   global basefont boldfont
   global dom_struc
   global gwind gobject

   set gwind $wind
   set gobject $object


#This "if" was implemented to ignore addtional wrong double click to select object
   if {[winfo exists $wind.up.entry] != 1} { 
       entry $wind.up.entry -width 20 -textvariable inst_name -font $basefont\
    	 -relief sunken
       pack $wind.up.entry -side left
    
       label $wind.mid.right.label -text "Instance List" -relief raised -font $boldfont
       pack  $wind.mid.right.label -side top  -fill x -expand 1
    
       scrollbar $wind.mid.right.scrbar -relief sunken \
	       -command "$wind.mid.right.object yview"
       pack      $wind.mid.right.scrbar  -side right -fill y
    
       listbox   $wind.mid.right.object -relief raised -borderwidth 2 \
                                 -yscrollcommand "$wind.mid.right.scrbar set" -font $basefont
       pack      $wind.mid.right.object  -side right -fill y
   
       set inst_msg "The object type \"[lindex $object 0]\" was selected."

#==Update instance listbox
       foreach args [lsort [lreplace [lindex $dom_struc 2] 0 0]] {
          $wind.mid.right.object insert end $args
       }
   }

    bind $wind.up.entry <Return> {
        if {[selection own] != "$gwind.mid.left.object"} {
              set inst_msg "Incorrect Selection! Select object type in the list."
              return
        } 
        set final 0
        set inst_rep 0 
        set gobject [selection get]
        set gobject [lindex $gobject 0]
        set inst_msg "The object type \"$gobject\" was selected."
        if {$inst_name == ""} {
            set inst_msg "Please! Enter a valid instance name."
        } else {
                          
                if {[string match *. $inst_name] == 1} {
                    set inst_name [string trimright $inst_name "."]
                    set final 1
                } 
                set list1 [lindex $dom_struc 2]
                foreach args $list1 {
                  if {[lindex [lindex $args 0] 0] == $inst_name} {
                       dialog .d {Warning - Instance Repetion} "Sorry! The instance\
                              \"$inst_name\" already exists in the list" warning 0 Ok
                       set inst_rep 1
                       break
                   } 
                }
                if {$inst_rep == 0} {
                    set list2 [linsert $list1 1 "$inst_name : [lindex $gobject 0]"]
                    set list3 [lreplace $dom_struc 2 2 $list2]
                    set dom_struc $list3
                    $gwind.mid.right.object insert end "$inst_name : [lindex $gobject 0]"
                }
                set inst_name ""
                if {$final == 1} {
   
                }
        }
   }
   
}
#llxx==========================================================================
# Version of setWorldPath to DEFINE DOMAIN   
#============================================================================
proc setWorldPath_dd {name elt op} {
    # name = name of changed var
    # elt = element in array of changed var ( {} if not array )
    # op = rwu: read, write, unset

    global pathnum_dd common_world_paths numDomains
    global world_path

    set world_path [lindex $common_world_paths $pathnum_dd]
    if { [file isdirectory $world_path] == 0 } {
	mkErrorDialog .error "The directory \"$world_path\" doesn't exist."
	return
    } 
    set numDomains [rescan .dd.mid.sb.dom_select.top.lb $world_path $numDomains *\\]
}

#llxx==========================================================================
# SelectDomain Version to DEFINE DOMAIN   
#============================================================================

proc selectDomain_dd {domain} {
    global domain_file domain_name problem_name
    global world_path
    global numDomains numDomainFiles numProblems
    global domain_loaded problem_loaded
    global active_buttons file_buttons

    puts "In selectdomain_dd"

    cd $world_path
    if {$domain != ""} {
      set domain_name $domain
      set domain_file "domain.bld"
      $file_buttons(viewproblem) configure -state disabled
      $file_buttons(loadproblem) configure -state disabled
    }
    
    set domain_name [string trimright $domain_name "\\"]
    #From the next line to the next comment replaces the commented out code 
    #below. This was Jim's change as he went into newer Tcl/Tk [cox]
    set f [open "file $domain_name"]
    set ans [read $f]
    close $f
    puts [lindex $ans 1]
    if { [lindex $ans 1] == directory } {
	set numProblems [rescan .dd.mid.sb.prob_select.top.lb   \
		"$world_path$domain_name\\probs" $numProblems *.lisp]
	$file_buttons(viewdomain) configure -state normal
	$file_buttons(builddomain) configure -state normal
	# this needs to go if allowing any domain file name
	if {$domain == ""} {
	    selectDomainFile $domain_file
	    if { [lindex [$file_buttons(viewproblem) configure -state ] 4] == "normal" } {
		$file_buttons(loadproblem) configure -state normal
	    }
	}
    } else {
      mkErrorDialog .error "\"$domain_name is not a valid domain\""
    }
  }

#llxx==========================================================================
# DIALOG WITH USER
#============================================================================
proc dialog {dw title text bitmap default args} {
    global button
    global basefont
    global xdialoggeometry ydialoggeometry

     # Create the top level window and divide it into top and bottom parts.

     toplevel $dw -class Dialog
     wm title $dw $title
     wm iconname $dw Dialog
#     wm geometry $dw +$xdialoggeometry+$ydialoggeometry
     wm geometry $dw +345+345
     frame $dw.top -relief raised -bd 1 
     pack $dw.top -side top -fill both
     frame $dw.bot -relief raised -bd 1 
     pack $dw.bot -side bottom -fill both

     # Fill the top part with the bitmap and the message.

     message $dw.top.msg -width 3i -text $text -font $basefont
     pack $dw.top.msg -side right -expand 1 -fill both -padx 3m -pady 3m
     if {$bitmap != ""} {
         label $dw.top.bitmap -bitmap $bitmap
         pack  $dw.top.bitmap -side left -padx 3m -pady 3m
     }
     
     # Create a row of buttons at the bottom of the dialog
     set i 0
     foreach but $args {
        button $dw.bot.button$i -text $but -command "set button $i"
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

      # Set up a binding for <Return>, if there's a default, set a grab
      # and claim the focus too.
      if {$default >=0} {
          bind $dw <Return> "$dw.bot.button$default flash;\
					set button $default"
      }
      tkwait visibility $dw
      set oldFocus [focus]
    #  grab set $dw
      focus $dw
      
      #Wait for the user to respond, then restore the focus and return the index
      #of the selected button.
      tkwait variable button
      destroy $dw    
      focus $oldFocus
      return $button
}

#============================================================================
# FILE BOX
#============================================================================

#==========================================================================
proc mkScrollSelectionBox {w} {
    global basefont

    listbox   $w.lb -relief raised -borderwidth 2                         \
	    -yscrollcommand "$w.scrbar set" -font $basefont
    scrollbar $w.scrbar -relief sunken -command "$w.lb yview"
    
    pack      $w.lb     -side left -fill both
    pack      $w.scrbar -side left -fill both
} 

#==========================================================================
# glob doesn't seem to work, but since the pattern never changes directory,
# this hack should work. Jim.
proc addFiles {l directory pat } {
    global tcl_version

    cd $directory
    if {$tcl_version <= 7.4 || $tcl_version >= 7.6} {
	set files [lsort [glob -nocomplain $pat]]
    } else {
 	set com [open "|ls -F"]
 	set listing [read $com]
 	close $com
 	set files ""
 	foreach file $listing {
 	    if {[string match $pat $file] == 1} {
 		lappend files $file
 	    }
 	}
 	set files [lsort $files]
    }
    set realfiles ""
    foreach name $files {
 	if { [string trimright $name "~"] == $name } {
              set realfiles "$realfiles $name"
 	}
    }
    set i 0
    foreach name $realfiles {
 	$l insert end $name
 	incr i
    }
    return $i
}

  #==========================================================================
  proc rescan {l directory numentries dirflag} {
    $l delete 0 $numentries
    return [addFiles $l $directory $dirflag]
  }


  #==========================================================================
  proc selectDomain {domain} {
    global domain_file domain_name problem_name
    global world_path
    global numDomains numDomainFiles numProblems
    global domain_loaded problem_loaded
    global active_buttons file_buttons
   
    cd $world_path
    if {$domain != ""} {
      set domain_name $domain
      set domain_file "domain.lisp"
      $file_buttons(viewproblem) configure -state disabled
      $file_buttons(loadproblem) configure -state disabled
    }
    if {$domain_name == "None"} {
      mkErrorDialog .error "\"Please select a domain.\""
      return
    }
    set domain_name [string trimright $domain_name "\\"]

#    set f [open "|file $domain_name"]
    set ans [file type $domain_name]
#    close $f
    if {$ans == "directory" } {
      set numProblems [rescan .fw.mid.sb.prob_select.top.lb   \
                           "$world_path$domain_name\\probs" $numProblems *.lisp]
      $file_buttons(viewdomain) configure -state normal
      $file_buttons(loaddomain) configure -state normal
      # this needs to go if allowing any domain file name
      if {$domain == ""} {
        selectDomainFile $domain_file
        if { [lindex [$file_buttons(viewproblem) configure -state ] 4] == "normal" } {
          $file_buttons(loadproblem) configure -state normal
        }
      }
    } else {
      mkErrorDialog .error "\"$domain_name is not a valid domain\""
    }
  }
  #==========================================================================
  #=Loads the domain=========================================================
proc selectDomainFile {domainfile} {
    global domain_file domain_name problem_name world_path
    global numDomainFiles numProblems
    global domain_loaded problem_loaded
    global domain_line problem_line
    global active_menus file_buttons
    
    cd $world_path$domain_name
    set domain_file $domainfile
#    set f [open "file $domain_file"]
    set ans [file type $domain_file]
#    set ans [read $f]
#    close $ans
    if {$ans == "file" } {
	load_domain
	$domain_line configure -text "Domain:$domain_name "
	.fw.up.current.domain configure -text "Current Domain: $domain_name"
	foreach button "viewtypehierarchy viewdomain viewOperatorGraph" {
	    [lindex $active_menus($button) 0] entryconfigure \
		[lindex $active_menus($button) 1] -state normal
	}

	set domain_loaded 1
	
	# reloading a domain clears problem
	$problem_line configure -text "Problem:None "
	.fw.up.current.problem configure -text "Current Problem: None"
	[lindex $active_menus(viewproblem) 0] entryconfigure \
	    [lindex $active_menus(viewproblem) 1] -state disabled
	set problem_loaded 0
    } else {
	mkErrorDialog .error "\"The domain file `$domain_file' is not valid\" \"in the domain `$world_path$domain_name'.\" \"Please select another one.\""
    }
}

  #==========================================================================
  #=Loads the problem========================================================
  proc selectProblemFile {problem {loadflag ""}} {
    global domain_file domain_name problem_name world_path
    global numDomainFiles numProblems
    global domain_loaded problem_loaded
    global problem_line domain_line
    global active_menus file_buttons



    set temp [lindex [$domain_line configure -text] 4]
    set loaded_domain_name [string range $temp 7 [expr [string length $temp]-2]]

    if {($domain_name == "None")} {
      mkErrorDialog .error {"Please select a domain."}
      return
    }
    cd $world_path$domain_name\\probs
    set problem_name $problem
#    set f [open "file $problem"]
    set ans [file type $problem]
#    set ans [read $f]
#    close $f
    if {$ans != "directory" } {
      $file_buttons(viewproblem) configure -state normal
      if {($domain_loaded == 1) && ($loaded_domain_name == $domain_name)} {
        $file_buttons(loadproblem) configure -state normal
      }
      if {($loadflag != "")} {
        if {($domain_loaded == 1)} {
          # and the domain hasn't changed
          if {$domain_name == $loaded_domain_name} {
            load_problem
            $problem_line configure -text "Problem:$problem_name "
            set problem_loaded 1
            $file_buttons(ok) configure -state normal
            .fw.up.current.problem configure -text "Current Problem: $problem_name"
            [lindex $active_menus(viewproblem) 0] entryconfigure \
		    [lindex $active_menus(viewproblem) 1] -state normal
          } else {
            mkErrorDialog .error "\"This problem does not\" \
                                  \"match the loaded domain.\" "
          }
        } else {
          mkErrorDialog .error "\"Please load the domain first.\""
        }
      }
    } else {
      mkErrorDialog .error "\"The problem file `$problem_name' is not valid\" \"in the domain `$world_path$domain_name'.\" \"Please select another one.\""
    }
  }

  #==========================================================================
  proc viewDomainFile {{noload ""}} {
    global world_path domain_name domain_file domain_line
    global domain_bold_words
    global domain_oblique_words

    set domainViewCoords "+0+0"
    set filename "$world_path$domain_name\\$domain_file"

    if {($domain_name == "None")} {
      mkErrorDialog .error {"Please select a domain."}
      return
    }
    if {($domain_file == "None")} {
      mkErrorDialog .error {"Please select a domain file."}
      return
    }
    cd $world_path$domain_name
#    if {[file isfile $domain_file] == 0} {
#      mkErrorDialog .error "\"The domain file `$domain_file' is not valid\" \"in the domain `$world_path$domain_name'.\" \"Please select another one.\""
#      return
#    }
    if { [winfo exists .domain] == 1 } {
      set domainViewCoords [wm geometry .domain]
      destroy .domain
    }

    if {$noload != ""} {
      set extra_button_labels {"View Functions"}
      set extra_button_commands {"viewFunctionsFile" }
    } else {
      set extra_button_labels {"Load" "View Functions"}
      set extra_button_commands {"selectDomain \"\"" "viewFunctionsFile" }
    }

    displayFile .domain " Domain: $domain_name " $filename \
                   $domain_oblique_words $domain_bold_words $domainViewCoords \
                   $extra_button_labels $extra_button_commands
  }
  #==========================================================================
  proc viewProblemFile {{noload ""}} {
    global world_path domain_name domain_file problem_name
    global problem_bold_words problem_oblique_words
    global domain_line

    set filename "$world_path$domain_name\\probs\\$problem_name"
    set problemViewCoords "+0+400"

    if {($problem_name == "None")} {
      if {($domain_name == "None")} {
        mkErrorDialog .error {"Please select a domain;" "then you can select a problem."}
        return
      }
      mkErrorDialog .error {"Please select a problem file."}
      return
    }
    cd $world_path$domain_name\\probs
#    if {[file isfile $problem_name] == 0} {
#      mkErrorDialog .error "\"The problem file `$problem_name' is not valid\" \"in the domain `$world_path$domain_name'.\" \"Please select another one.\""
#      return
#    }

    if { [winfo exists .problem] == 1 } {
      set problemViewCoords [wm geometry .problem]
      destroy .problem
    }

    set temp [lindex [$domain_line configure -text] 4]
    set loaded_domain_name [string trimleft $temp "Domain:"]

    if {($noload != "") || ($loaded_domain_name != $domain_name) } {
      set extra_button_labels {}
      set extra_button_commands {}
    } else {
      set extra_button_labels {"Load"}
      set extra_button_commands {"selectProblemFile $problem_name load"}
    }

    displayFile .problem " Problem: $problem_name " $filename \
                $problem_oblique_words $problem_bold_words $problemViewCoords \
                $extra_button_labels $extra_button_commands
  }
  #==========================================================================
  proc viewFunctionsFile {} {
    global world_path domain_name domain_file problem_name function_file
    global function_file_bold_words
    global function_file_oblique_words

    set filename "$world_path$domain_name\\$function_file"
    set functionViewCoords "+0+400"

    cd $world_path$domain_name
    if {[file isfile $function_file] == 0} {
      mkErrorDialog .error "\"There is no file $function_file\" \"for the domain `$domain_name'\""
      return
    }

    if { [winfo exists .functions] == 1 } {
      set functionViewCoords [wm geometry .functions]
      destroy .functions
    }

    displayFile .functions " Functions for Domain: $domain_name " $filename \
                $function_file_oblique_words $function_file_bold_words \
                $functionViewCoords 
  }
  #==========================================================================
  proc setWorldPath {name elt op} {
    # name = name of changed var
    # elt = element in array of changed var ( {} if not array )
    # op = rwu: read, write, unset

    global pathnum common_world_paths numDomains numProblems
    global world_path domain_name problem_name domain_file
    global problem_loaded domain_loaded
    global active_buttons active_menus file_buttons

    $file_buttons(loadproblem) configure -state disabled
    $file_buttons(loaddomain)  configure -state disabled
    [lindex $active_menus(viewproblem) 0] entryconfigure \
	    [lindex $active_menus(viewproblem) 1] -state disabled
    [lindex $active_menus(viewdomain) 0] entryconfigure \
	    [lindex $active_menus(viewdomain) 1] -state disabled

    set world_path [lindex $common_world_paths $pathnum]
    set numDomains [rescan .fw.mid.sb.dom_select.top.lb $world_path $numDomains *\\]
    .fw.mid.sb.prob_select.top.lb delete 0 $numProblems
  }
  #==========================================================================
  trace variable world_path w setWorldPathInProdigy
  proc setWorldPathInProdigy {name elt op} {
    global world_path
#    puts "SET-WORLD-PATH: $world_path"
#   lisp_command "(path \"$world_path\")";
  }



# Procedure separateGoalTreeCanvas creates an indeoendent window from which the
# UI displays the goaltree. The procedure is available to the user through the 
# View pull down menu. It also removes the prior frame in the main window area
# that previously displayed this information, and reconfigures the plan display
# to use the entire area.
#
proc separateGoalTreeCanvas {gtcanvas} {
    global canvasGoalTree mainWindow

    set canvasGoalTree $gtcanvas.goaltree.c

    catch {destroy $gtcanvas}
    toplevel $gtcanvas
    wm title $gtcanvas " Goal Tree Display "
    wm iconname $gtcanvas "  Goal Tree "
    frame $gtcanvas.goaltree  
    pack  $gtcanvas.goaltree -side top -expand yes -fill both

    set c $gtcanvas.goaltree
    drawGoalTree $c $mainWindow.infoframe.value  
    removeGoalTreeCanvas
    #Disable reinvocation of this procedure from the View menu.
    $mainWindow.mbar.view.menu entryconfigure 9 -state disabled
}


# Procedure removeGoalTreeCanvas reconfigures the main display area in the UI 
# to visualize the plan alone (i.e., the sequence of applied operators). 
#
proc removeGoalTreeCanvas {} {
    global mainWindow

    #Stop managing the goaltree canvas and unmap it from screen.
    pack forget $mainWindow.canvas.goaltree.c
    pack forget $mainWindow.canvas.goaltree.hscroll
    pack forget $mainWindow.canvas.goaltree.vscroll
    pack forget $mainWindow.canvas.goaltree

    #Reconfigure the plan display so that it expands/fills in both directions
    pack configure $mainWindow.canvas.appop -expand yes -fill both
}


#llyy============================================================================
proc fileBox {pwind} {
    #llyy  global xdialoggeometry ydialoggeometry
    global no_solution
    global xgeometry ygeometry
    global basefont obliquefont boldfont
    
    global world_path domain_name domain_file problem_name
    global common_world_paths pathnum
    global numDomains numDomainFiles numProblems
    global domain_loaded problem_loaded
    global domain_line problem_line
    global file_buttons
    
    if { [string trimright $world_path "\\"] == $world_path } {
	set world_path "$world_path\\"
    }
    set old_pathnum $pathnum
    set old_world_path $world_path
    set old_domain_name $domain_name
    set old_domain_file $domain_file
    set old_problem_name $problem_name
    
    catch {destroy .fw}
    toplevel .fw
    # Commented out the next 2 lines so the load window can be placed by the user
    #  checkGeometry $pwind
    #  wm geometry .fw "+[expr $xgeometry+25]+[expr $ygeometry+25]"
    wm title .fw " Load Domain and Problem "
    wm iconname .fw " Load "
    
    
    #===== world path
    frame .fw.up -relief raised -bd 1 
    pack  .fw.up -side top -fill x
    frame .fw.up.world_path 
    pack  .fw.up.world_path -side top
    label .fw.up.world_path.label -text "World Path:" -font $basefont
    entry .fw.up.world_path.entry -width 50 -textvariable world_path -font $basefont -relief sunken
    pack  .fw.up.world_path.label -side left
    pack  .fw.up.world_path.entry -side left
    
    bind .fw.up.world_path.entry <Return>  {
	if { [string trimright $world_path "\\"] == $world_path } {
	    set world_path "$world_path\\"
	}
	set numDomains [rescan .fw.mid.sb.dom_select.top.lb $world_path $numDomains *\\]
    }
    bind .fw.up.world_path.entry <Tab>     "focus .fw.mid.sb.dom_select.bot.domentry"
    
    #===== common world paths
    frame .fw.up.cwp 
    pack  .fw.up.cwp -side top -pady 4
    set i 0
    foreach path $common_world_paths {
	radiobutton .fw.up.cwp.r$i -text "$path" -font $basefont -variable pathnum -value $i -anchor sw
	pack .fw.up.cwp.r$i -fill x
	incr i
    }
    trace variable pathnum w setWorldPath 
    
    #===== domain name
    frame .fw.up.current 
    pack  .fw.up.current -side top
    label .fw.up.current.note -text "Loaded into Prodigy:" -font $boldfont
    label .fw.up.current.domain -text "Current Domain: $domain_name" -font $basefont
    label .fw.up.current.problem -text "Current Problem: $problem_name" -font $basefont
    pack  .fw.up.current.note -side left
    pack  .fw.up.current.domain -side top
    pack  .fw.up.current.problem -side top
    
    #===== selection boxes
    frame .fw.mid -relief raised -bd 1 
    pack  .fw.mid -side top -fill x
    frame .fw.mid.sb 
    pack  .fw.mid.sb -side top
    #===== domain selection box
    frame .fw.mid.sb.dom_select 
    pack  .fw.mid.sb.dom_select -side left
    
    frame .fw.mid.sb.dom_select.top 
    pack  .fw.mid.sb.dom_select.top -side top
    
    mkScrollSelectionBox .fw.mid.sb.dom_select.top
    set numDomains [addFiles .fw.mid.sb.dom_select.top.lb $world_path *\\]
    
    bind  .fw.mid.sb.dom_select.top.lb <Double-Button-1> {selectDomain [selection get]}
    
    #===== domain entry box
    frame .fw.mid.sb.dom_select.bot 
    pack  .fw.mid.sb.dom_select.bot -side bottom
    label .fw.mid.sb.dom_select.bot.domlabel -text "Domain: " -font $basefont
    entry .fw.mid.sb.dom_select.bot.domentry -width 20 -textvariable domain_name \
	-font $basefont -relief sunken -bd 2
    pack  .fw.mid.sb.dom_select.bot.domlabel -side left
    pack  .fw.mid.sb.dom_select.bot.domentry -side left
    
    bind  .fw.mid.sb.dom_select.bot.domentry <Return>  { selectDomain $domain_name }
    # .l select from 3
    bind  .fw.mid.sb.dom_select.bot.domentry <Tab>     "focus .fw.mid.sb.prob_select.bot.probentry"
    
    #===== problem selection box
    frame .fw.mid.sb.prob_select 
    pack  .fw.mid.sb.prob_select -side left
    
    frame .fw.mid.sb.prob_select.top 
    pack  .fw.mid.sb.prob_select.top -side top
    
    mkScrollSelectionBox .fw.mid.sb.prob_select.top
    bind  .fw.mid.sb.prob_select.top.lb <Double-Button-1> {selectProblemFile [selection get]}
    
    #===== problem selection entry box
    frame .fw.mid.sb.prob_select.bot 
    pack  .fw.mid.sb.prob_select.bot -side bottom
    label .fw.mid.sb.prob_select.bot.domlabel  -text "File: " -font $basefont
    entry .fw.mid.sb.prob_select.bot.probentry -width 20 -font $basefont \
	-textvariable problem_name -font $basefont -relief sunken -bd 2
    pack  .fw.mid.sb.prob_select.bot.domlabel  -side left
    pack  .fw.mid.sb.prob_select.bot.probentry -side left
    
    bind  .fw.mid.sb.prob_select.bot.probentry <Return>  { selectProblemFile "$problem_name" }
    bind  .fw.mid.sb.prob_select.bot.probentry <Tab>     "focus .fw.up.world_path.entry"
    
    
    #===== buttons
    frame .fw.bot -relief raised -bd 1 
    pack  .fw.bot -side top -fill both
    frame .fw.bot.buttons 
    pack  .fw.bot.buttons -side bottom  -pady 10
    
    button .fw.bot.buttons.ok -text OK -relief raised -bd 2 \
	-font $basefont \
	-command {
	    #must get rid of "Problem:" and " "
	    set no_solution 1
	    #puts "test 5"
	    set temp [lindex [$problem_line configure -text] 4]
	    set problem_name [string range $temp 8 [expr [string length $temp]-2]]
	    #must get rid of "Domain:" and "\ "
	    set temp [lindex [$domain_line configure -text] 4]
	    set domain_name [string range $temp 7 [expr [string length $temp]-2]]
	    
	    if { ($domain_loaded == 0) } {
		puts "test 1"
		if { ($domain_name == "None") } {
		    puts "test 2"
		    mkErrorDialog .error {"Please select a domain."}
		} else {
		    puts "test 3"
		    mkErrorDialog .error {"Please load the domain."}
		}
	    } else {
		if { ($problem_loaded == 0) } {
		    puts "test 4"
		    if { ($problem_name == "None") } {
			mkErrorDialog .error {"Please select a problem."}
		    } else {
			mkErrorDialog .error {"Please load the problem."}
		    }
		} else {
		    #puts "made it without tests"
		    destroy .fw
		}
	    }
	}
    set file_buttons(ok) .fw.bot.buttons.ok
    
    # you can't "cancel" the loads.
    button .fw.bot.buttons.cancel -text Cancel -relief raised -bd 2 \
	-font $basefont \
	-command {
	    #must get rid of "Problem:" and " "
	    set temp [lindex [$problem_line configure -text] 4]
	    set problem_name [string range $temp 8 [expr [string length $temp]-2]]
	    #must get rid of "Domain:" and "\ "
	    set temp [lindex [$domain_line configure -text] 4]
	    set domain_name [string range $temp 7 [expr [string length $temp]-2]]
	    destroy .fw
	}
    set file_buttons(cancel) .fw.bot.buttons.cancel
    set file_buttons(viewdomain) .fw.bot.buttons.but0
    set file_buttons(loaddomain) .fw.bot.buttons.but1
    set file_buttons(viewproblem) .fw.bot.buttons.but2
    set file_buttons(loadproblem) .fw.bot.buttons.but3
    
    set but_labels {"View Domain" "Load Domain"
	"View Problem" "Load Problem"}
    set but_commands {
	viewDomainFile
	{
	    selectDomain ""
	    $active_buttons(run) configure -state disabled
	    $active_buttons(multistep) configure -state disabled
	}
	viewProblemFile
	{selectProblemFile "$problem_name" load} 
    }
    set but_infotexts {"" "" "" ""}
    addButtons .fw .fw.bot.buttons $but_labels $but_commands $but_infotexts left
    
    pack .fw.bot.buttons.ok \
	.fw.bot.buttons.cancel \
	-side left  -pady 10 -padx 5
    
    #=====
    # if domain is already selected, then fill in info
    if {$domain_name != "None"} {
	selectDomain $domain_name
    } else {
	$file_buttons(ok) configure -state disabled
	$file_buttons(viewdomain) configure -state disabled
	$file_buttons(loaddomain) configure -state disabled
    }
    $file_buttons(viewproblem) configure -state disabled
    $file_buttons(loadproblem) configure -state disabled
    
}

#============================================================================
# SEARCH MODES
#============================================================================

proc destroyDependantButtons {} {
    global currentDependantButtons
    foreach but $currentDependantButtons {
	destroy $but
    }
    set currentDependantButtons ""
}
#============================================================================
proc setupDefaultRun {w} {
    global currentDependantButtons
    destroyDependantButtons
    changePlanningMode2 p4
    set prodigyvar(linear) nil
    lisp_command "(user::set-running-mode 'user::savta)"
}
#============================================================================
proc setupLinearRun {w} {
    global currentDependantButtons
    destroyDependantButtons
    set prodigyvar(linear) t
    changePlanningMode2 p4
}
#============================================================================
# I think that this was never used. [cox]
proc setupLinearReorderPrecRun {w} {
    global currentDependantButtons
    destroyDependantButtons
    set prodigyvar(linear) t
    changePlanningMode2 p4
}
#============================================================================
proc setupSABARun {w} {
    global currentDependantButtons
    destroyDependantButtons
    changePlanningMode2 p4
    set prodigyvar(linear) nil
    lisp_command "(user::set-running-mode 'user::saba)"
}
#============================================================================
proc setupAbstractionRun {w} {
    global currentDependantButtons
    destroyDependantButtons
    changePlanningMode2 abstraction
}
#============================================================================
proc doSetUp {command} {
    global currentDependantButtons
    global labels commands infotext
    global mainWindow
    
    destroyDependantButtons
    changePlanningMode2 $command
    set currentDependantButtons [addButtons $mainWindow $mainWindow.functionButtons $labels($command) $commands($command) $infotext($command) left]
}




#============================================================================
# CONTROL VARIABLES
#============================================================================
#============================================================================
proc mkRadioListBox {w title variable buttons values {notop ""}} {
    global basefont boldfont
    global xdialoggeometry
    global ydialoggeometry
    global prodigyvar
    
    set oldvar $prodigyvar($variable)
    
    #if this is a real window
    if {$notop == ""} {
	catch {destroy $w}
	toplevel $w
	wm title $w $title
	wm geometry $w +$xdialoggeometry+$ydialoggeometry
	frame $w.radiobuttons
	pack $w.radiobuttons -side top -pady 5
	frame $w.buttons
	pack $w.buttons -side bottom -fill x
    } else {
	#if this is a subwindow
	frame $w.titles
	pack $w.titles -side left -pady 2
	frame $w.radiobuttons
	pack $w.radiobuttons -side left -fill x
	
	label $w.titles.l -text "$title" -font $basefont
	pack  $w.titles.l
    }
    
    set numbuttons [llength $buttons]
    if { $numbuttons != [llength $values] } {
	puts "mkRadioListBox buttons and values different length"
	exit
    }
    for {set i 0} {$i < $numbuttons} {incr i} {
	set label [lindex $buttons $i]
	set val [lindex $values $i]
	radiobutton $w.radiobuttons.r$i -text $label -value $val \
	    -variable prodigyvar($variable) -anchor sw -font $basefont
	pack $w.radiobuttons.r$i -fill x
    }
    
    if {$notop == ""} {
	button $w.ok -text "OK" -font $boldfont \
	    -command "destroy $w"
	button $w.cancel -text "Cancel" -font $basefont \
	    -command "set prodigyvar($variable) $oldvar; destroy $w"
	pack $w.ok $w.cancel -side left -padx 1 -pady 1 \
	    -ipadx 1 -ipady 1 -in $w.buttons
	wm protocol $w WM_TAKE_FOCUS "checkDialogGeometry $w"
    }
}
#============================================================================
proc summarizeRunningVariables {} {
    global prodigyvar
    global planning_mode
    
    catch {destroy .rvsum}
    
    set oldsearchdefault    $prodigyvar(searchdefault)
    set oldexcise_loops     $prodigyvar(excise_loops)
    set oldminconspiracy    $prodigyvar(minconspiracy)
    set oldabstractionlevel $prodigyvar(abstractionlevel)
    set oldabstractiontype $prodigyvar(abstractiontype)
    set oldrandombehaviour  $prodigyvar(randombehaviour)
    set olddepth_bound      $prodigyvar(depth_bound)
    set oldtime_bound       $prodigyvar(time_bound)
    set oldmax_nodes        $prodigyvar(max_nodes)
    set oldoutput_level     $prodigyvar(output_level)
    
    toplevel .rvsum
    wm title .rvsum " Control Variables "
    
    set okcommand ".rvsum.buttons.ok flash ; destroy .rvsum"
    set resetCommand " \
	set prodigyvar(searchdefault)    $oldsearchdefault    ; \
	set prodigyvar(excise_loops)     $oldexcise_loops     ; \
	set prodigyvar(minconspiracy)    $oldminconspiracy    ; \
	set prodigyvar(abstractionlevel) $oldabstractionlevel ; \
	set prodigyvar(abstractiontype) $oldabstractiontype ; \
	set prodigyvar(randombehaviour)  $oldrandombehaviour  ; \
	set prodigyvar(depth_bound)      $olddepth_bound      ; \
	set prodigyvar(time_bound)       $oldtime_bound       ; \
	set prodigyvar(max_nodes)        $oldmax_nodes        ; \
	set prodigyvar(output_level)     $oldoutput_level     "
    
    if {[string compare $planning_mode "abstraction"] == 0} {
	set frames {sd el mc al at rb ol}
    } else {
	#If not abstraction mode, leave out abstraction specific flags.
	set frames {sd el mc rb ol}
    }
    
    foreach f $frames {
	frame .rvsum.$f 
    }
    
    setSearchDefault    .rvsum.sd true
    setExciseLoops      .rvsum.el t
    setMinConspiracy    .rvsum.mc t
    if {[string compare $planning_mode "abstraction"] == 0} {
	setAbstractionLevel .rvsum.al t
	setAbstractionType  .rvsum.at nil
    }
    setRandomBehaviour  .rvsum.rb t
    setOutputLevel      .rvsum.ol true
    foreach f $frames {
	# Line them up nicely.
	.rvsum.$f.titles.l configure -width 20
	pack  .rvsum.$f -side top -fill x -pady 2
    }
    
    set others {
	{depth "Maximum Depth: " depth_bound}
	{time "Maximum time (secs): " time_bound}
	{nodes "Maximum nodes: " max_nodes}
    }
    
    foreach f $others {
	set name .rvsum.[lindex $f 0]
	frame $name 
	pack $name  -side top -pady 2 -fill x
	makeOneEntry $name [lindex $f 1] prodigyvar([lindex $f 2]) 10
	$name.label configure -width 20
	bind $name.entry <Return> "$okcommand"
    }
    
    bind .rvsum.depth.entry <Tab> "focus .rvsum.time.entry"
    bind .rvsum.time.entry <Tab> "focus .rvsum.nodes.entry"
    bind .rvsum.nodes.entry <Tab> "focus .rvsum.depth.entry"
    
    focus .rvsum.depth.entry
    
    frame .rvsum.buttons 
    pack  .rvsum.buttons -side top -pady 5
    
    mkDefaultButton .rvsum.buttons "OK" "$okcommand"
    button .rvsum.buttons.reset -text "Reset Variables" \
	-command $resetCommand
    button .rvsum.buttons.cancel -text "Cancel" \
	-command "$resetCommand ; destroy .rvsum"
    pack   .rvsum.buttons.reset .rvsum.buttons.cancel -side left -padx 5 -ipadx 2 -ipady 2
    
}
#============================================================================
proc setMaxNodes  {} {
    global prodigyvar
    
    toplevel .max_nodes
    set oldmax_nodes $prodigyvar(max_nodes)
    
    mkDialogBox .max_nodes " Maximum Nodes "
    mkDialogBoxDescr .max_nodes " 0 is unlimited nodes," "otherwise number of nodes before stopping solving"
    makeOneEntry .max_nodes "Maximum nodes: " prodigyvar(max_nodes) 10
    
    bind .max_nodes.cancel <1> "set prodigyvar(max_nodes) $oldmax_nodes; destroy .max_nodes"
    bind .max_nodes.entry <Return> { destroy .max_nodes }
}
#============================================================================
proc setTimeBound  {} {
    global prodigyvar
    
    toplevel .time_bound
    set oldtime_bound $prodigyvar(time_bound)
    
    mkDialogBox .time_bound " Time Bound "
    mkDialogBoxDescr .time_bound " 0 is unlimited time," \
	"otherwise number of seconds before stopping solving"
    makeOneEntry .time_bound "Maximum time (seconds): " prodigyvar(time_bound) 10
    
    bind .time_bound.cancel <1> "set prodigyvar(time_bound) $oldtime_bound; destroy .time_bound"
    bind .time_bound.entry <Return> { destroy .time_bound }
}
#============================================================================
proc setDepthbound  {} {
    global prodigyvar
    
    toplevel .depth_bound
    set olddepth_bound $prodigyvar(depth_bound)
    
    mkDialogBox .depth_bound " Depth Bound "
    makeOneEntry .depth_bound "Maximum Depth: " prodigyvar(depth_bound) 10
    
    bind .depth_bound.cancel <1> "set prodigyvar(depth_bound) $olddepth_bound; destroy .depth_bound"
    bind .depth_bound.entry <Return> { destroy .depth_bound }
}
#============================================================================
proc setOutputLevel {w notop} {
    set buttons {"0: print nothing during problem solving"   \
		     "1: only print resulting plan"   \
		     "2: print node information and final plan"   \
		     "3: print node information, control rules and final plan"}
    set varvals {0 1 2 3}
    
    mkRadioListBox $w " Output Level " output_level $buttons $varvals $notop
}
#============================================================================
proc setSearchDefault {w notop} {
    set buttons {"Depth First" "Breadth First"}
    set varvals {"depth" "breadth"}
    
    mkRadioListBox $w "Search Default" searchdefault $buttons $varvals $notop
}

#============================================================================
proc setMinConspiracy {w notop} {
    set buttons {"True (choose smallest number of unresolved preconditions)"  \
		     "False"}
    set varvals {"t" "nil"}
    mkRadioListBox $w "Conspiracy Number" minconspiracy $buttons $varvals $notop
}


#Moved proc setAbstractionLevel to file abstraction.tcl [cox 11jul97]


#============================================================================
proc setRandomBehaviour {w notop} {
    set buttons {"True (choose candidates randomly)"   \
		     "False (choose candidates left-to-right)"}
    set varvals {"t" "nil"}
    mkRadioListBox $w "Random Behaviour" randombehaviour $buttons $varvals $notop
}

#============================================================================
proc setExciseLoops {w notop} {
    set buttons {"True (use dependency-directed backtracking)" "False"}
    set varvals {"t" "nil"}
    mkRadioListBox $w "Excise Loops" excise_loops $buttons $varvals $notop
}


proc setUserControl {w notop} {
    set buttons {"True (user planning decisions)" "False"}
    set varvals {"t" "nil"}
    mkRadioListBox $w "User Control" user_control $buttons $varvals $notop
}


#============================================================================
# DISPLAY VARIABLES
#============================================================================
proc setPrintAlternatives {w notop} {
    set buttons {"True (display alternative choices)"   \
		     "False (display number of choices)"}
    set varvals {"t" "nil"}
    mkRadioListBox $w "Print Alternatives" printalts $buttons $varvals $notop
}


#Procedure setNodeParameters allows the user to adjust the parameter settings
#that influence the spacing of nodes in the goal tree display. The routine is 
#accessible from the "Display Variables" pull-down menu of the main menu bar.
#[cox 30may97]
#
proc setNodeParams {} {
    global params
    global *node-width* *node-height* *xmargin* 
    global *inter-x-margin* *inter-y-margin*
    
    catch {destroy .gnodeparams}
    
    toplevel .gnodeparams
    wm title .gnodeparams " Goal Node Params "
    
    set params {
	{nwidth "Node Width: " *node-width*}
	{nheight "Node Height: " *node-height*}
	{interxmargin "Inter X Margin: " *inter-x-margin*}
	{interymargin "Inter Y Margin: " *inter-y-margin*}
	{xmargin "X Margin: " *xmargin*}
    }
    
    set counter 0
    foreach param $params {
	#Set the value of each variable to the value of corresponding Lisp var
	set [lindex $param 2] [lisp_command [lindex $param 2]]
	#The following adds the initialized values of each parameter 
	#to the end of each parameter list.
	set params  \
	    [lreplace $params $counter $counter \
		 [linsert $param [llength $param] [set [lindex $param 2]]]]
	incr counter
    }
    
    #Upon OK, set parameters in Lisp.
    set okcommand {
	.gnodeparams.buttons.ok flash 
	foreach f $params {
	    lisp_send "(setf [lindex $f 2] [set [lindex $f 2]])"
	    lisp_receive 
	}
	destroy .gnodeparams
    }
    
    foreach f $params {
	set name .gnodeparams.[lindex $f 0]
	frame $name 
	pack $name  -side top -pady 2 -fill x
	makeOneEntry $name [lindex $f 1] [lindex $f 2] 10
	$name.label configure -width 20
	bind $name.entry <Return> "$okcommand"
    }
    
    set counter 0
    foreach f [lrange $params 0 [expr [llength $params] - 2]] {
	incr counter 
	bind .gnodeparams.[lindex $f 0].entry <Tab> \
	    "focus .gnodeparams.[lindex [lindex $params $counter] 0].entry"
    }
    
    bind .gnodeparams.[lindex [lindex $params [expr [llength $params] - 1]] 0].entry \
	<Tab> \
	"focus .gnodeparams.[lindex [lindex $params 0] 0].entry"
    
    focus .gnodeparams.[lindex [lindex $params 0] 0].entry
    
    frame .gnodeparams.buttons 
    pack  .gnodeparams.buttons -side top -pady 5
    
    mkDefaultButton .gnodeparams.buttons "OK" "$okcommand"
    button .gnodeparams.buttons.reset -text "Reset Parameters" \
	-command {
	    foreach f $params {
		lisp_send "(setf [lindex $f 2] [lindex $f 3])"
		lisp_receive 
		set [lindex $f 2] [lindex $f 3]
	    }
	}
    button .gnodeparams.buttons.cancel -text "Cancel" \
	-command "destroy .gnodeparams"
    pack   .gnodeparams.buttons.reset .gnodeparams.buttons.cancel -side left -padx 5 -ipadx 2 -ipady 2
    
}


#============================================================================
# HELP
#============================================================================

#============================================================================
proc displayFile {w title filename obliquewords boldwords {coords ""} {extra_button_labels ""} {extra_button_commands ""}
	      } {
    global basefont boldfont obliquefont
    
    set num_extra_buttons [llength $extra_button_labels]
    if { $num_extra_buttons != [llength $extra_button_commands] } {
	puts "displayFile extra_button_labels != extra_button_commands"
	exit
    }
    
    toplevel $w
    if {$coords != ""} {
	wm geometry $w $coords
    }
    
    wm title $w "$title"
    
    #=== text area
    frame $w.top 
    pack $w.top -side top -expand 1 -fill both
    
    text $w.text -relief raised -bd 2 -yscrollcommand "$w.scroll set"
    $w.text configure -setgrid 1
    scrollbar $w.scroll -relief sunken -command "$w.text yview"
    
    pack $w.text -side left -in $w.top -expand 1 -fill both
    pack $w.scroll -side right -fill y -in $w.top
    
    #=== buttons area
    frame $w.buttons 
    pack $w.buttons -side bottom -pady 2
    
    for {set i 0} {$i < $num_extra_buttons} {incr i} {
	set label   [lindex $extra_button_labels $i]
	set command [lindex $extra_button_commands $i]
	button $w.buttons.b$i -text "$label" -command "$command"
	pack   $w.buttons.b$i -side left -ipadx 3 -ipady 2 -padx 2
    }
    
    button $w.buttons.close -text "Close" -command "destroy $w"
    pack   $w.buttons.close -side left -ipadx 3 -ipady 2 -padx 2
    
    #===== actual text
    loadFile $w.text $filename
    
    #Do the oblique matches (usually shorter words, so do them first)
    forAllMatches $w.text $obliquewords {
	$w.text tag add oblique first last
    }
    $w.text tag configure oblique -font $obliquefont
    
    #Do the bold matches
    forAllMatches $w.text $boldwords {
	$w.text tag add bold first last
    }
    $w.text tag configure bold -font $boldfont
}

#============================================================================
# Call function to start up Prodigy UI
wm withdraw .

mkScroll $mainWindow
