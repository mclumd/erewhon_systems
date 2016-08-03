;;;
;;; subway domain: hacked together to test various stuff in Prodigy 4
;;; This is not a good example of writing an efficient domain, but it does
;;; use a lot of Prodigy's features.
;;;
;;; To move from one station to another, you must have a ticket, and
;;; each move uses all your tickets.

(create-problem-space 'subway :current t)

(ptype-of Place   :top-type)
(ptype-of Station Place)
(ptype-of Color   :top-type)
(ptype-of Object  :top-type)
(ptype-of TicketMachine Object)
(ptype-of Person Object)
(ptype-of Bomb   Object)
(ptype-of Neutron-Bomb Bomb)
(ptype-of Conventional-Bomb Bomb)
(ptype-of Sensitive-Object Object)

(pinstance-of red blue Color)
(pinstance-of home Place)
(pinstance-of wood-street Station)
(pinstance-of machine TicketMachine)

(OPERATOR
 Buy-Ticket
 (params <person> <station> <machine>)
 (preconds
  ((<person> Person)
   (<station> station)
   (<machine> TicketMachine))
  (and (at-p <person> <station>)
       (at-o <machine> <station>))
  )
 (effects
  ()
  ((add (has-ticket <person>)))))

;;; This is an example of a fully instantiated operator. Once we are
;;; at station2, we can get out onto the platform as long as we have a
;;; ticket and our shoes are red or blue. prob2.lisp has being on the
;;; platform the goal (and has red shoes in the start state) so it
;;; uses this operator.

(OPERATOR
 Get-On-Platform
 (params <person>)
 (preconds
  ((<person> Person))
  (and (at-p <person> wood-street)
       (can-board <person>)
       (or (shoe-color <person> red) (shoe-color <person> blue))))
 (effects
  ()
  ((del (at-p <person> wood-street))
   (add (on-platform <person> wood-street))
   (if (shoe-color <person> red)
       ((add (the-angels-want-to-wear-my-red-shoes)))))))

;;; This one is added just to be rejected - see the control-rule
;;; "dont-just-sit-there"
(OPERATOR
 Sit-at-station
 (params <at> <person>)
 (preconds
  ((<at> station)
   (<person> person))
  (at-p <person> <at>))
 (effects
  ()
  ((del (at-p <person> <at>))
   (add (at-p <person> <at>)))))

(OPERATOR
 Move-One-Station
 (params <person> <from> <to>)
 (preconds
  ((<person> Person)
   (<from> Station)
   (<to>   Station))
  (and (adjacent <from> <to>)
       (at-p <person> <from>)
       (can-board <person>)))
 (effects
  ()
  ((del (at-p <person> <from>))
   (add (at-p <person> <to>))
   (del (has-ticket <person>)))))

(OPERATOR
 pick-up
 (params <person> <object> <place>)
 (preconds
  ((<person> Person)
   (<object> Object)
   (<place>  Place))
  (and (at-p <person> <place>)
       (at-o <object> <place>)))
 (effects
  ()
  ((add (carrying <person> <object>))
   (del (at-o <object> <place>)))))

(OPERATOR
 put-down
 (params <person> <object> <place>)
 (preconds
  ((<person> Person)
   (<object> Object)
   (<place>  Place))
  (and (carrying <person> <object>)
       (at-p <person> <place>)))
 (effects
  ()
  ((add (at-o <object> <place>))
   (del (carrying <person> <object>)))))

;;; This somewhat macabre operator was added to test implicit
;;; universal quantification of effects. It's also an interesting
;;; example (I think) of an eager operator. It's not really an
;;; inference rule because it changes the state, but it "goes off"
;;; (sorry) even if you didn't subgoal it.
(Inference-Rule
 explode
 (mode eager)
 (params <bomb> <station>)
 (preconds
  ((<bomb> Conventional-Bomb)
   (<station> Station))
  (and (at-o <bomb> <station>)
       (~ (destroyed <bomb>))
       (should-explode <bomb>)))
 (effects
  ((<sensitive-object> Sensitive-Object))
  ((forall ((<object> Object))
	   (at-o <object> <station>)
	   ((add (destroyed <object>)))) ; This will include <bomb>.
   (add (destroyed <sensitive-object>)))))

(Inference-Rule
 neutron-explode			; This one only kills people.
 (mode eager)				; Gruesome, eh?
 (params <bomb> <station>)
 (preconds
  ((<bomb> Neutron-Bomb)
   (<station> Station))
  (and (at-o <bomb> <station>)
       (~ (destroyed <bomb>))
       (should-explode <bomb>)))
 (effects
  ()
  ((forall ((<victim> Person))
	   (at-p <victim> <station>)
	   ((add (destroyed <victim>))))
   (add (destroyed <bomb>)))))

(Inference-Rule
 location-sensitive-bomb
 (mode eager)
 (params <bomb> <place>)
 (preconds
  ((<bomb> Bomb)
   (<place> Place))
  (and (at-o <bomb> <place>)
       (location-detonating <bomb> <place>)))
 (effects
  ()
  ((add (should-explode <bomb>)))))

;;; This is an example of a static eager inference rule.
(Inference-Rule
 Adjacent-Reflexive
 (mode eager)
 (params <station1> <station2>)
 (preconds
  ((<station1> Station)
   (<station2> Station))
  (adjacent <station1> <station2>))
 (effects
  ()
  ((add (adjacent <station2> <station1>)))))

(Inference-Rule
 Machine-at-every-station
 (mode eager)
 (params <station>)
 (preconds ((<station> station)) ())
 (effects ()
	  ((add (at-o machine <station>)))))

;;; This one allows me to test the truth maintenance with the same
;;; example that was used for goal-clobbering. Then, the requirement
;;; to get on a train was (has-ticket). Now it will be (can-board),
;;; which the tms has to keep track of.

;;; This is an example of a non-static eager inference rule. This is
;;; unimportant for the running of problem 1, since it has been
;;; subgoaled on before it becomes applicable.
(Inference-Rule
 Can-Board
; (mode eager)
 (params <person>)
 (preconds
  ((<person> Person))
  (has-ticket <person>))
 (effects
  ()
  ((add (can-board <person>)))))

(Inference-Rule
 Where-Home-Is
 (params <person> <station>)
 (preconds
  ((<station> Station)
   (<person> Person))
  (and (home-for <person> <station>)
       (at-p <person> <station>)))
 (effects
  ()
  ((add (at-p <person> home)))))

;;; Here's an eager inference rule that just slows down the domain,
;;; but fires anyway
#|
(Inference-Rule
 always-hungry
 (mode eager)
 (params <place> <person>)
 (preconds ((<place> station) (<person> Person))
	   (at <person> <place>))
 (effects ()
	  ((add (hungry-at <person> <place>)))))
|#

;;; Control Rules

#|
(Control-Rule
 Come-from-someplace-else
 (IF (and (current-goal (at <station>))
	  (current-ops (move-one-station))))
 (THEN reject bindings ((<from> . <station>) (<to> . <station>))))
|#


;;; Different rule to test bindings preference rules. I guess this
;;; looks at first as though it would cause a control rule loop..
(control-rule
 come-from-someplace-else
 (if (and (current-goal (at-p <someone> <station>))
	  (current-ops (move-one-station))))
 (then prefer bindings ((<from> . <x>) (<to> . <y>) (<person> . <someone>))
       ((<from> . <z>) (<to> . <z>) (<person> . <someone>))))

(control-rule
 Dont-just-sit-there
 (If (candidate-operator <anything>))
 (then prefer operator <anything> sit-at-station))

(control-rule
 prefer-to-move
 (IF (current-goal (at-p <person> <station>)))
 (THEN prefer operator move-one-station where-home-is))

(control-rule
 Buy-a-ticket-where-you-are
 (IF (and (current-goal (has-ticket <dude>))
	  (current-ops (buy-ticket))
	  (known (at-p <dude> <hangout>))))
 (THEN select bindings
       ((<person> . <dude>) (<station> . <hangout>) (<machine> . machine))))

(control-rule
 Pick-it-up-where-it-is
 (IF (and (current-goal (carrying <someone> <something>))
	  (current-operator pick-up)
	  (known (at-o <something> <someplace>))))
 (THEN prefer bindings
       ((<person> . <someone>) (<object> . <something>) (<place> . <someplace>))
       <anyother>))

(control-rule
 People-can-move-themselves
 (IF (and (current-goal (at-p <someone> <somewhere>))
	  (ptype <someone> Person)))
 (THEN reject operator put-down))

;;; Something like this should be in meta-predicates.
(defun ptype (Objects Type)
  "If one arg is a variable, returns a list for the other arg. If both
are variables, fails."
  (declare (special *current-problem-space*))
  (let ((real-object (if (or (p4::strong-is-var-p objects)
			     (typep objects 'p4::prodigy-object))
			 objects
			 (p4::object-name-to-object
			  objects *current-problem-space*)))
	(real-type (if (or (p4::strong-is-var-p type)
			   (typep type 'p4::type))
		       type
		       (p4::type-name-to-type
			type *current-problem-space*))))
  (cond ((p4::strong-is-var-p Objects)
	 (if (p4::strong-is-var-p Type)
	     (error "Can't both be variables in ptype: ~S ~S~%"
		    objects type))
	 (p4::instances real-type))
	((p4::strong-is-var-p type)
	 (let ((thetype (p4::prodigy-object-type real-object)))
	   (cons thetype (p4::type-all-parents thetype))))
	(t
	 (p4::object-type-p real-object real-type)))))
	 
#|
(control-rule
 place-bomb-first
 (IF (and (current-goal (destroyed <x>))
	  (current-ops  (neutron-explode))
	  (location-detonating <b> <place>)))
 (THEN select bindings
       ((<station> . <place>)
	(<victim> . <anyone>)
	(<bomb> . <b>))))
|#


;;; This one is a test to see if I can walk through the domain.
#|
(control-rule
 Ask-user-for-bindings
 (IF (and
      (current-operator <op>)
      (candidate-bindings <bindings1>)
      (candidate-bindings <bindings2>)
      (~ (eq <bindings1> <bindings2>))
      (user-prefer <bindings1> <bindings2>)))
 ;; changed to select for a quick test
 (THEN select bindings <bindings1> ;<bindings2>
       ))

(defun prefer-bindings (a b)
  (format t "Would you prefer the bindings:~S")
  (print a)
  (princ "to:")
  (print b)
  (y-or-n-p "Well? "))
|#

