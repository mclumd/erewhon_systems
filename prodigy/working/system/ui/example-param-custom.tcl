#If you want an alternate path displayed in the Load Domain and Problem
#function then place here; otherwise this should be set to "" 
#

#set alternate_path "/usr/local/mcox/prodigy/working/system/analogy/domains/"

set alternate_path "c:/prodigy/working/domains/"

set world_path $alternate_path
set user_path $alternate_path

if {[string length $alternate_path] != 0} {
    set common_world_paths "$world_path $user_path $alternate_path" 
} 


#Color changes in the UI.

set uiColor #ffe4c4 
set GoalTreeBackground   ivory
set AppliedOpBackground  ivory
set OperatorTextColour black
set InferenceTextColour brown
set GoalTextColour blue
set AppGoalColour red
set OutlineColor green
set AppTextColour black

# To make display canvases stacked on top of each other, uncomment line below.
# set stackedCanvases 1
