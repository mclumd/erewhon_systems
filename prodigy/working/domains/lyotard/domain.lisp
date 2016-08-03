;;; The cat call assignment domain.
;;;

(create-problem-space 'lyotard :current t)

(ptype-of Object :top-type)

(ptype-of Toy-Mouse Object)
(ptype-of Container Object)
(ptype-of Room Container)

(pinstance-of lyotard Object)

(operator
 find-object
 (params <object>)
 (preconds
  ((<object> Object)
   (<place> Object))
  (or 
   (in <object> <place>)
   (on <object> <place>)))
 (effects
  ((<other> Container)
   (<other-supporter> Object))
  ((del (in lyotard <other>))
   (del (on lyotard <other-supporter>))
   (add (cat-in-same-place <object>))
   (if (in <object> <place>)
       ((add (in lyotard <place>))))
   (if (on <object> <place>)
       ((add (on lyotard <place>)))))))

#|
(operator
 find-object-in-something
 (params <object>)
 (preconds
  ((<object> Object)
   (<container> Container))
  (in <object> <container>))
 (effects
  ((<other> Container)
   (<other-supporter> Object))
  ((if (in lyotard <other>)
       ((del (in lyotard <other>))))
   (if (on lyotard <other-supporter>)
       ((del (on lyotard <other-supporter>))))
   (add (cat-in-same-place <object>))
   (add (in lyotard <container>)))))


(operator
 find-object-on-something
 (params <object>)
 (preconds
  ((<object> Object)
   (<supporter> Object))
  (on <object> <supporter>))
 (effects
  ((<other> Container)
   (<other-supporter> Object))
  ((if (in lyotard <other>)
       ((del (in lyotard <other>))))
   (if (on lyotard <other-supporter>)
       ((del (on lyotard <other-supporter>))))
   (add (cat-in-same-place <object>))
   (add (on lyotard <supporter>)))))
|#

(operator
 get-object
 (params <object>)
 (preconds
  ((<object> Object))
  (cat-in-same-place <object>))
 (effects
  ((<cont> Container)
   (<supp> Object))
  ((del (in <object> <cont>))
   (del (on <object> <supp>))
   (add (in <object> lyotard)))))

(operator
 aggress
 (params <object>)
 (preconds
  ((<object> Toy-Mouse))
  (in <object> lyotard))
 (effects
  ()
  ((del (frustrated lyotard)))))

#|
(inference-rule
 in-same-place
 (params <object>)
 (preconds
  ((<object> Object)
   (<place> Object))
  (or (and (in <object> <place>) (in lyotard <place>))
      (and (on <object> <place>) (on lyotard <place>))))
 (effects
  ()
  ((add (cat-in-same-place <object>)))))
|#

#|
;;; At the moment 4.0 will crash if this control rule is in but
;;; in-same-place is commented out. It doesn't tell you anything
;;; useful either. This should be caught.
(control-rule
 move-the-cat
 (if (and (current-goal (cat-in-same-place <object>))
	  (current-ops (in-same-place))
	  (known (in <object> <room>))))
 (then select bindings ((<place> . <room>))))
|#

(control-rule
  find-object-in-place
  (if (and (current-goal (cat-in-same-place <object>))
	   (current-ops (find-object))
	   (or (known (in <object> <k-place>))
	       (known (on <object> <k-place>)))))
  (then select bindings ((<place> . <k-place>))))

(control-rule
 get-objects
 (if (current-goal (in <something> lyotard)))
 (then select operator get-object))


