proc runStart {} {
    global prodigyvar canvasGoalTree canvasAppliedOps 
    global applications applmark lisp_waiting
    global no_more_input planning_mode
    global lisp debug_msg

    lisp_flush

    set no_more_input 0
    #=== Figure out the running variables passed at run time.
    set runspec ":output-level $prodigyvar(output_level)\
	    :search-default :$prodigyvar(searchdefault)-first"
    if {$prodigyvar(depth_bound) != 0} {
	set runspec [concat $runspec " :depth-bound $prodigyvar(depth_bound) "]
    } 
    if {$prodigyvar(max_nodes) != 0} {
	set runspec [concat $runspec " :max-nodes $prodigyvar(max_nodes) "]
    } 
    if {$prodigyvar(time_bound) != 0} {
	set runspec [concat $runspec " :time-bound $prodigyvar(time_bound) "]
    }
    $canvasAppliedOps delete all
    set applications []
    set applmark []
    # Here is where it runs the front-end function if in jade mode [cox]
    if {[string compare $planning_mode "jade"] == 0} {
	lisp_send "(if (return-val FE::*ForMAT-loaded*)\
		(user::start-prodigy-front-end t ))"
	set line [gets $lisp]
	while {$line != "DisplayCases"} {
	    set debug_msg $line
#	    puts $debug_msg
	    update 
	    set line [gets $lisp]
	}
	puts "Found DisplayCases string"
	CloseAll
	DisplayCases
    } else {
	#Removed the setting of *user-guidance* to t below [19sep97 cox]
	lisp_send "(progn \
      		(if (return-val *use-monitors-p*) \
                    (reset))\
                (add-drawing-handler)\
		(print (user::run $runspec))\
		(if (return-val *use-transducer-p*) \
		(user::gen-file)) \
		(remove-drawing-handler)\
		(opt-send-final))"
    }
    incr lisp_waiting -1
    # We need a function call that also removes the information stored 
    # about the nodes.
    $canvasGoalTree delete all
    drawOperator $canvasGoalTree 4 -1 100 10 150 30 {"Top Goals"}
    runLoop
}