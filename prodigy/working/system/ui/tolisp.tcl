# This has just the code to set up sockets between the lisp and the tcl 
# processes. Somewhere in your main tcl code you need to call
# start_up_connection. This is mostly the code used by Sean in his
# theo-ical interface, separated out.

# Global variables to hold the socket ids used. 
set lisp 0
set listen_socket 0
set task_array(dummy) 0
set query 0
set qbuffer {}

# This one holds the number of sends minus the number of receives
set lisp_waiting 0

proc start_up_connection {{inet_hostname localhost}} {
    global lisp port
    set lisp [socket $inet_hostname $port]
}

# Makes a buffer of input that comes across the query socket
# (added by Jim)
proc new-message {mode sockid} {
    global qbuffer
    lappend qbuffer [gets $sockid]
}

# Closes the connection down. The lisp-side tcl-servers will finish
#  when they get the (quit) commands. The prodigy ui currently doesn't call 
# this, so you can run more than one ui without re-calling (start-tcl-server).
# It should be an option in the ui to call this on quit, because you don't
# always want the server hanging around.
proc finish_sean {} {
    global lisp query
    lisp_command "(quit)"
    # dp_shutdown $lisp all
    close $lisp
    puts $query "(quit)"
    # dp_shutdown $query all
    close $query
    exit
}

# This effectively blocks on the result. If we want to be able to
# interrupt and draw as the run progresses, we need to split this into two.
# That's what lisp_send and lisp_receive below do.
# Another problem with this is that if lisp gets an error, we're left hanging.
proc lisp_command { command } {
global prod_status
    lisp_flush
    #puts stdout "% Issuing blocking command $command"
    global lisp
    puts $lisp $command
    flush $lisp
    set prod_status "Running"
    update
    set a [gets $lisp]
    set a [ string trim $a { } ]
    set prod_status "Ready"
    #puts stdout "> $a"
    return $a
}

# These three allow us to start up lisp functions and keep running. 
proc lisp_send { command } {
  global lisp lisp_waiting
  #puts "% Issuing command $command"
  puts $lisp $command
  flush $lisp
  incr lisp_waiting
}

# Send a command without incrementing the reply count
proc lisp_blat { command } {
    global lisp
    #puts "% Sending: $command"
    puts $lisp $command
    flush $lisp
}

# This blocks on getting input on the $lisp pipe
proc lisp_receive { } {
  global lisp lisp_waiting
  set a [gets $lisp]
  set a [ string trim $a { } ]
  #puts stdout "> $a"
  incr lisp_waiting -1
  return $a
}

# Flush the lisp return buffer.
proc lisp_flush {} {
  global lisp lisp_waiting
  while {$lisp_waiting > 0} {lisp_receive}
}

# I don't use these functions in the current version of the prodigy
# tcl interface, I just pass raw strings around.
 
proc list_to_array { l } {
    global alist_array

    set alist_array(dummy) 0
    for { set i 0 } { $i < [llength $l] } { incr i 2 } {
        set alist_array([lindex $l $i]) [lindex $l [ expr $i + 1] ]
    }
    return $alist_array()
}

# For the moment only do non-nested lists.
proc lisp_list_to_tcl_list { l } {

    set str_len [ string length $l ]
    set res ""
    set mode 0
    for { set i 1 } { $i < $str_len } { incr i } {
        set char [ string index $l $i ]
        if { ( [ string compare $char {\\} ] == 0 ) } {
            incr i
            set char2 [ string index $l $i ]
            set res   [ format "%s%s%s" $res $char $char2 ]
        } elseif { ( [ string compare $char {(} ] == 0 ) && ( $mode == 0 ) } {
            set res [ format "%s%s" $res " \{ " ]
        } elseif { ( [ string compare $char {)} ] == 0 ) && ( $mode == 0 ) } {
            set res [ format "%s%s" $res " \} " ]
        } elseif { ( [ string compare $char {"} ] == 0 ) && ( $mode == 0 ) } {
            set res [ format "%s%s" $res "\{" ]
            set mode 1
        } elseif { ( [ string compare $char {"} ] == 0 ) && ( $mode == 1 ) } {
            set res [ format "%s%s" $res "\}" ]
            set mode 0
        } else {
            set res [ format "%s%s" $res $char ]
        }
    }
    puts stdout $res
    return $res
}
       
proc tcl_list_to_lisp_list { l } {
    regsub -all {({)([^\}]*)(})} $l {\2} res
    return $res
}

