(create-problem-space 'hero :current t)

(ptype-of Robot :Top-Type)
(ptype-of Debris :Top-Type)
(ptype-of Bin :Top-Type)
(ptype-of Location :Top-Type)
(ptype-of Cup Debris)
(ptype-of Big-Chiller Cup)

(OPERATOR MoveTo
	  (params <robot> <fromloc> <toloc>)
	  (preconds () (and))
	  (effects
	   ((<robot> Robot)
	    (<fromloc> Location)
	    (<toloc> Location))
	   ((del (at <robot> <fromloc>))
	    (add (at <robot> <toloc>)))))

(OPERATOR Grab
	  (params <robot> <object> <loc>)
	  (preconds
	   ((<robot> Robot)
	    (<object> Debris)
	    (<loc> Location))
	   (and (at <robot> <loc>)
		(at <object> <loc>)
		(arm-empty <robot>)))
	  (effects
	   ()
	   ((del (arm-empty <robot>))
	    (del (at <object> <loc>))
	    (add (holding <robot> <object>)))))

(OPERATOR Drop-in-Bin
	  (params <robot> <object> <bin> <loc>)
	  (preconds
	   ((<robot> Robot)
	    (<object> Debris)
	    (<loc> Location)
	    (<bin> Bin))
	   (and (holding <robot> <object>)
		(at <robot> <loc>)
		(at <bin> <loc>)))
	  (effects
	   ()
	   ((add (at <object> <loc>))
	    (add (in-bin <object> <bin>)))))


(Control-Rule Leave-Bin-Where-It-Is
	      (if (and (current-goal (in-bin <thing> <bin>))
		       (current-operator drop-in-bin)
		       (known (at <bin> <binloc>))))
	      (then select bindings
		    ((<loc> . <binloc>))))

(control-rule Grab-stuff-where-it-is
	      (if (and (current-goal (holding <robot> <object>))
		       (current-operator grab)
		       (known (at <object> <obj-loc>))))
	      (then select bindings
		    ((<loc> . <obj-loc>))))
