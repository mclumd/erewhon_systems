# This file contains the tcl code that implements visual display of the
# activation of monitors during dynamic replanning with sensing of the
# environment. See also overload.tcl in this directory.



#Should do more with this, but for now...
proc showSentinel {line} {
    #puts $line
    set monitorName [string range $line 9 end]
    displaySentinel $monitorName
}



# Notice wName not global here. But, I changed this 
# and it is explicitly global now.
#
# wName is not the name of the global now, wNameList is so the OK button on the
# monitor display can remove all monitors. Changed it back to not being global
# so that the window name list will not be modified. [20dec97 cox]
#
# Added addLiteral flag as parameter. Signals whether the new information was 
# the adding of a literal or the deletion of a literal. [26mar98 cox]
#
proc activateSentinel  {sdata addLiteral} {
    global uiColor
;    global wName

    set casefont  -adobe-times-medium-r-normal--*-140-*

    # Window name is the second element in sdata, data is the third.
    set wName .s[string range [lindex $sdata 1] [expr 1 + [string first "." [lindex $sdata 1]]] end]
    set predicate [lindex $sdata 2]

#    set wName .s[string range $sname [expr 1 + [string first "." $sname]] end]
    $wName configure -background $uiColor
    $wName.cf configure -background $uiColor
    $wName.cf.label configure -background $uiColor
    $wName.bot configure -background $uiColor
    $wName.bot.ok configure -background $uiColor
    if {$addLiteral == 1} {
        $wName.cf.label2 configure -text " Senses new info \n $predicate" -font $casefont -background $uiColor
    } else {
	$wName.cf.label2 configure -text " Senses new info \n (\~ $predicate)" -font $casefont -background $uiColor
    }
    focus $wName
}


# Immediately after an activateSentinel comes a noticeData. This call
# displays the new predicate that was sensed from the environment. 
#
# This procedure is now obsolete and not used. [20dec97 cox]
#
proc noticeData  {sdata} {
    # Window name is the second element in sdata, data is the third.
    set wName .s[string range [lindex $sdata 1] [expr 1 + [string first "." [lindex $sdata 1]]] end]
    set predicate [lindex $sdata 2]
    $wName.cf.label2 configure -text " Senses new info \n $predicate" 
}



#Global list of window names
set wNameList {}

proc displaySentinel {sname} {
    global wNameList

    set casefont  -adobe-times-medium-r-normal--*-140-*
    set snum [string range $sname [expr 1 + [string first "." $sname]] end]
    set wName  .s$snum 
    # Add new window name to list
    lappend wNameList $wName


    toplevel $wName
    wm title $wName " Monitor Display "
    wm geometry $wName +[expr 5 + [expr 5 * $snum]]+[expr 375 + [expr 2 * $snum]]
    
    frame $wName.cf -relief raised -bd 1 -bg grey
    pack  $wName.cf -side top -fill y
    label $wName.cf.label -text $sname -font $casefont -bg grey
    pack  $wName.cf.label -side top
    label $wName.cf.label2 -text "Watching" -font $casefont -bg grey
    pack  $wName.cf.label2 -side bottom -expand yes -fill both
    frame $wName.bot -relief raised -bd 1 -bg grey
    pack  $wName.bot -side top -fill both

    button $wName.bot.ok -text OK -relief raised -bd 2 -font $casefont -bg grey \
	    -command {
	foreach wind $wNameList {destroy $wind} 
	set wNameList {}
    }
    pack  $wName.bot.ok  -side left  -pady 10 -padx 10
}

