# File ui-start.tcl sets up default values for the ui. This file is loaded 
# before the user's file in the lisp variable *tcl-customizations*, so the user
# can overwrite these default values by putting code in that file.

# History:
#
# 19dec96 help_file_oblique_words function_file_bold_words global variables 
#         added [cox]
#
# 19dec96 no_solution global variable added [cox]
#
# 25jan97 planning_mode global variable and the changePlanningMode2 procedure 
#         added [cox]
#
# 16apr97 moved variable initialization for debug window code here [cox]
#
# 23apr97 Reconciled the code with Jim's UI version that uses the latest 
#         Tcl/Tk [cox]
#
# 15aug97 Added stackedCanvases flag to allow for alternate canvas layout.
#
# 12sep97 Changed analogy_setup from setup to setup2. See comments in
#         setup2. [cox]
#
# 19sep97 Added another prodigyvar (user_control). [cox]
#
# 12sep97 Changed analogy_setup from setup2 to loader. [cox]
#



# Global variable for the connection port
set port 5679

# If the following flag is set to 1, then display canvases are stacked on top
# of each other instead of being side by side. See procedure mkScroll in file
# ui.tcl. 
#
set stackedCanvases 0


#============================================================================
# Initialize World Paths
#============================================================================

# The corresponding variable *prod-ui-home* is defined in file ui.lisp.
#
set ui_home "/usr/local/mcox/prodigy/working/system/ui"

# The corresponding variable *world-path* is defined in file loader.lisp.
#
set world_path "/usr/local/mcox/prodigy/working/domains/"


set mainWindow .main

set uid [exec whoami]

#The following are default user domain paths.
set def1 "/usr/$uid/prodigy/domains/"
set def2 "/afs/cs/project/prodigy-$uid/prodigy/domains/"

switch $uid {
    mcox    {set user_path "/nfs/valhalla/users25/csgrad/bkerkez/ai/prodigy/working/domains/"} ;[cox 24nov99]
    aperez  {set user_path "/afs/cs/project/prodigy-aperez/domains4.0/"}
    jblythe {set user_path "/afs/cs/project/prodigy-jblythe/p4/domains/"}
    wxm     {set user_path "/afs/cs/project/prodigy-wxm/prodigy4/domains/"}
    rudis   {set user_path "/afs/cs/user/rudis/prodigy/misc/" "/afs/cs/usr/rudis/prodigy/misc/mmv-art/"}
    eugene  {set user_path "/afs/cs/project/prodigy-1/eugene/Prodigy/domains/"}
    khaigh  {set user_path "/usr/khaigh/prodigy/domains/"}
    mmv     {set user_path "/usr/mmv/prodigy4.0/domains/"}
    pstone  {set user_path "/usr/pstone/prodigy/domains/"}
    ledival {set user_path "/afs/cs/user/ledival/prodigy/domains/"}
    rizzo   {set user_path "/afs/cs.cmu.edu/user/rizzo/PRODIGY/"}
    default "set user_path \"$def1 $def2\""
}
unset def1
unset def2

set common_world_paths "$world_path $user_path"


#============================================================================
# PLANNING MODE
#============================================================================

set prodigyvar(linear)         "nil"


#============================================================================
# CONTROL VARIABLES
#============================================================================
set prodigyvar(depth_bound)       100
set prodigyvar(searchdefault)     "depth"
set prodigyvar(excise_loops)      "t"
set prodigyvar(output_level)      3
set prodigyvar(minconspiracy)     "t"
set prodigyvar(abstractionlevel)  "t"
set prodigyvar(abstractiontype)  "nil"
set prodigyvar(randombehaviour)   "nil"
set prodigyvar(time_bound)        0
set prodigyvar(max_nodes)         0
set prodigyvar(user_control)      "nil"

#============================================================================
# DISPLAY VARIABLES
#============================================================================

set prodigyvar(printalts)         "nil"

set typeHierarchy                 class
set partialOrder                  false
set displaypolygons               false



#============================================================================
# VARIABLES FOR ALPINE
#============================================================================

set hierarchy_type none

#============================================================================
# Initialize Special Functions 
#============================================================================

# The special functions establish extended planning modes for Prodigy. 
# Analogy implements the Prodigy/Analogy case-based planner, 
# Abstraction implements Knoblock's Alpine hierarchical planner, and
# Bayes (see file bayes.tcl) implements Blythe's Weaver conditional planner.
#
# Note that the following two assignments are overridden by file bayes.tcl.
#


# The list of functions to create. each element is the index to labels,
# commands and infotext below.

set special_commands {analogy abstraction}


# The label corresponding to special_commands

set special_commands_label {"Prodigy/Analogy" "Abstraction"}


# These three arrays are the buttons strictly related to the special_commands
#   labels()   is the label on the buttons
#   commands() is the name of the function to call **YOU NEED TO CREATE THESE**
#   infotext() is the text to put in the information line

set labels(analogy) {"Manual Case Retrieval" "Auto Case Retrieval" 
	             "Store Current Case" "Merge Demo" "Merge Strategy"
}
#          "Replay Past Case(s)" "Restart cases" 

set commands(analogy) { "retrieveCases $wind" \
			    autoRetrieveCases \
				saveCase \
				performDemo \
				mergeStrats
			}
#	  ReplayCases RestartCases  

set infotext(analogy) { "Manually retrieve case" "Automatically retrieve case" 
    "Save planning episode" "Retrieve and merge multiple past cases." 
    "Select merge strategy if multiple cases retrieved" 
}
#         "Replay retrieved cases"   "Restart cases" 


set labels(abstraction) {"Show Abstraction Hierarchy" "Make Hierarchy" \
	"Clear Hierarchy" "Abstraction Type"}
set commands(abstraction) { showAbstractionHierarchy makeAbstractionHierarchy \
	clearAbstractionHierarchy \
	{
    catch {destroy .abstractiontype}
    toplevel .abstractiontype
    setAbstractionType .abstractiontype ""
}   }
set infotext(abstraction) {"Display the Abstraction Hierarchy" \
	"Make either Problem-Specific or Problem-Independent Hierarchy" \
	"Clear the Abstraction Hierarchy" \
	"Change Abstraction Type to/from Problem-Specific"}


#============================================================================
# TCL VARIABLES
#============================================================================


# If the user changes to prodigy/analogy mode then the domain must be reloaded.
# Flag used to enforce this constraint.
#
set analogy_domain_needs_loading 1

#The location of the Prodigy/Analogy loader file.
set analogy_setup "/usr/local/mcox/prodigy/working/system/analogy/loader.lisp"

# Global variable planning_mode records the current running mode of Prodigy.
# The variable is used by the runCommand and changePlanningMode2 procedures.
# The start-up mode of Prodigy is generative planning (p4). The possible
# variable assignments are one of p4, analogy, abstraction, or bayes. 
#
set planning_mode p4


# Procedure changePlanningMode2 manages changes in planning modes, especially 
# when going to or from Prodigy/Analogy mode.
#
proc changePlanningMode2 {new_mode} {
    global planning_mode 
    global active_buttons 
    global mainWindow
    global world_path domain_name domain_file
    global multstep_win_open
    global analogy_domain_needs_loading
    global analogy_setup 
    global prodigyvar

    if {($multstep_win_open == 1)} {
	cancelMultistep
    }
    if {[string compare $new_mode $planning_mode] != 0} {
	# If leaving Prodigy/Analogy mode
	if {[string compare $planning_mode "analogy"] == 0} {
	    set domain_name "None"
	    lisp_command "(setf *analogical-replay* nil)"
	    $active_buttons(run) configure -text "Run"
	    $active_buttons(run) configure -state disabled
	    $active_buttons(multistep) configure -state disabled
	    $active_buttons(break) configure -state disabled
	    $active_buttons(restart) configure -state disabled
	    $active_buttons(abort) configure -state disabled
	} elseif {[string compare $planning_mode "abstraction"] == 0} {
	    # If leaving abstraction (Alpine) mode
	    #Disable Alpine-specific control variables
	    $mainWindow.mbar.rv.menu entryconfigure 10 -state disabled
	    $mainWindow.mbar.rv.menu entryconfigure 11 -state disabled
	}
	switch $new_mode {
	    p4 {
	        wm title $mainWindow " Prodigy 4.0 "
	    }
	    abstraction {
	        wm title $mainWindow " Alpine "

		#Enable Alpine-specific control variables
		$mainWindow.mbar.rv.menu entryconfigure 10 -state normal
		$mainWindow.mbar.rv.menu entryconfigure 11 -state normal
	    }
	    analogy {
		#If not already in analogical planning mode
		if {[string compare $planning_mode analogy] != 0} {
		    set analogy_domain_needs_loading 1
		    set domain_name "None"
		    wm title $mainWindow " Prodigy/Analogy "
		    if {[string compare [lispVar *analogy-loaded*] NIL] == 0} {
			lisp_command "(load \"$analogy_setup\")"
		    }
		    lisp_command "(setf *analogical-replay* t)"
		    lisp_command "(user::set-for-replay)"
		    lisp_command "(user::set-for-replay-ui)"
		    $active_buttons(run) configure -text "Replay"
		    $active_buttons(run) configure -state disabled
		    $active_buttons(multistep) configure -state disabled
		    $active_buttons(break) configure -state disabled
		    $active_buttons(restart) configure -state disabled
		    $active_buttons(abort) configure -state disabled
	    }   }
	    bayes {
	        wm title $mainWindow " B Prodigy "
	    }
	}
	if {[string compare $planning_mode "abstraction"] == 0} {
	    set planning_mode $new_mode
	    #This has to be done because of "trace" side-effect of making 
	    #changes to prodigyvar when leaving abstraction mode. See proc pvar
	    #in file ui-comm.tcl [cox 11ju97]
	    set prodigyvar(abstractiontype)  "nil"
	} else {
	    set planning_mode $new_mode
	}
    }
}



# Fonts
# use the command "xlsfonts" to see list of available fonts
# Keep these as variables so we can play with them more easily

# Font names:
#     courier, helvetica, new century schoolbook, symbol, times
# Weight:
#     bold, medium
# Slant:
#     r, (i, o)
# Points:
#     specified in 10ths of points

# viewsize is the fontsize (in points) for the views
set viewsize 140
set largeviewsize 140

# basefont is used for normal text in the domain and object view windows.
# boldfont and obliquefont are what you'd think.

set basefont    -adobe-times-medium-r-normal--*-$viewsize-*
set obliquefont -adobe-times-medium-i-normal--*-$viewsize-*
set boldfont    -adobe-times-bold-r-normal--*-$viewsize-*

set appliedopfont -adobe-times-bold-r-normal--*-$viewsize-*
set operatorfont -adobe-times-bold-r-normal--*-$largeviewsize-*
set goalfont -adobe-times-medium-i-normal--*-$viewsize-*

set canvasfont -adobe-helvetica-medium-r-normal-*-
set canvasfontsize 24

# Topfont is the font used in the top info bar
#set topfont  -adobe-times-medium-r-normal--*-180-*
#set toplabel -adobe-times-medium-i-normal--*-180-*
set topfont  -adobe-times-medium-r-normal--*-$largeviewsize-*
set toplabel -adobe-times-bold-r-normal--*-$largeviewsize-*

#========
# Colours
#========

# Re-establish colors that existed in the UI before the port to latest Tcl/Tk [cox]
set uiColor #ffe4c4 
option add *background $uiColor
option add *activeBackground #efd4b4

set GoalTreeBackground   ivory
set AppliedOpBackground  ivory

# Colours in the goal tree canvas
set OperatorTextColour black
set InferenceTextColour green4
set GoalTextColour blue
# Colour of application annotation in goal tree canvas
set AppGoalColour red
# Highlighting color for a node (LightGreen = 144 238 144)
set OutlineColor green

# Colour of text in applied op canvas
set AppTextColour black

#======

set domain_oblique_words {add|del|if|then|forall}
set domain_bold_words {operator|params|preconds|effects|ptype-of|pinstance-of|control-rule|inference-rule|event|probability|duration}
set problem_oblique_words {and}
set problem_bold_words {setf|current-problem|create-problem|name|object|objects|state|goal|igoal}
set function_file_oblique_words {not|eq|nil|if|p4::|and|or}
set function_file_bold_words {defun|declare|let|cond|loop}

set help_file_oblique_words {p4::|User|Interface}
set help_file_bold_words {defun|prodigy|prodigy|analogy|weaver|alpine}

#======
# If no_solution==1 then cannot store case. Set by "OK" button in "Load" 
# function and by abort command. Unset by runLoop function. 
set no_solution 1
set domain_name  "None"
set domain_file  "domain.lisp"
set problem_name "None"
set function_file "functions.lisp"
set pathnum 0

#When value equals 1, Prodigy/Analogy code has been loaded.
set analogy_loaded 0

set domain_loaded 0
set problem_loaded 0

set numDomains 0
set numDomainFiles 0
set numProblems 0

# Directory where postscript files of head and tail plans are written.
# If not changed from "", then posctscript is written to probs directory
# of a given domain. 
#
set canvas_directory ""

# winfo depth . would get the answer I need, but I'm avoiding the hassle 
# for now.
set colourModel color
#set colourModel [tk colormodel .]

switch $uid {
    mcox    {set canvas_directory "/afs/cs/project/prodigy-1/mcox/"}
    aperez  {set canvas_directory "/afs/cs/project/prodigy-aperez/"}
    jblythe {set canvas_directory "/afs/cs/project/prodigy-jblythe/p4/"}
    wxm     {set canvas_directory "/afs/cs/project/prodigy-wxm/prodigy4/"}
    rudis   {set canvas_directory "/afs/cs/user/rudis/prodigy/misc/"}
    eugene  {set canvas_directory "/usr/eugene/"}
    khaigh  {set canvas_directory "/usr/khaigh/prodigy/"}
    mmv     {set canvas_directory "/usr/mmv/prodigy4.0/"}
    pstone  {set canvas_directory "/usr/pstone/prodigy/"}
}

#=====
set currentDependantButtons ""
set xgeometry 527
set ygeometry 33
set xdialoggeometry 700
set ydialoggeometry 250

set display_line ""

#The next three variables will be set to the values of the label widgets
#corresponding to Domain Name, Problem Name, and Abstraction Type respectively
#on the lower information line of the main window.

set domain_line ""
set problem_line ""
set abs_line ""

#=====
# These can (or will be able to) grow as items are added.
set canvasGoalTreeWidth 100
set canvasGoalTreeHeight 50
set canvasAppliedOpWidth 500
set canvasAppliedOpHeight 500

set canvasGoalTree $mainWindow.canvas.goaltree.c
set canvasAppliedOps $mainWindow.canvas.appop.c

# Used with procedure drawGenericGraphWin in file dot.tcl 
set canvasGeneric ""

# Control position of the application annotation.
set applheight 20
set applymargin 50

#============================================================================
# Variables for putting up "dag" drawings in canvases
#============================================================================

# Two programs are used, dag and dot. Dot is the successor to dag and is 
# better, but is not available for sun4_mach, hence the use of dag.

# Choosing a nice big font for the demo
#set graphfont -adobe-helvetica-bold-r-*-*-16-*-*-*-*-*-*-*
# This is a regular one
set graphfont -adobe-helvetica-medium-r-*-*-*-110-*-*-*-*-*-*

set dotmult 0.6

# This was set to 0.8 for the demo, but typically you want smaller nodes than
# that for Bayes nets. I think 1 is best for the partial order and not too bad
# for the type hierarchy, which are the most usual applications.
#
set dagxmult 1
#set dagxmult 1.2
set dagymult 0.6

# The lisp command for drawing a net (here so it can be overidden) In this
# version, this MUST currently be overidden with tcldot-savvy code.
#
set lisp_bayes_draw "(bayes::dag-net :net (second *plan-net*) :ori 'down)"

# These options control how the "postscipt" button on dag windows behaves.
#
set dag_ps_opts "-file /tmp/tmp.ps -rotate true"

# This variable states that graphviz is loaded
#
set gviz 0

# Variables for the debug window. Added [cox]

#Establish debug display window.
set debug 0
set debug_window .debug
set var_counter 0
set debug_msg "Result of issuing \"Tcl Command\" below displayed here. Also, \
	can mix tcl expressions with \"LISP command\" below."

set in_update 0
