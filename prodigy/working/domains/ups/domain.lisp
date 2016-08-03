
;;; ********************************************************************
;;;               UPS Domain - Version 0 - January, 1992
;;;      Routing constrained by linking time and arrival deadlines
;;; ********************************************************************

;;; convert from nolimit, Mei, 1/30/92


(create-problem-space 'ups :current t)

(ptype-of HUB :top-type)
(ptype-of OBJECT :top-type)
(infinite-type TIME #'numberp)


(OPERATOR ROUTE-PACKAGE 
  (params <hub-from> <hub-to> <pac> <link-time> <deadline-time>
	  <new-deadline-time> <arrival-time>)
  (preconds
   ((<hub-from> HUB)
    (<hub-to> HUB)
    (<pac> OBJECT)
    (<link-time>
     (and TIME
	  (get-link-time <hub-from> <hub-to> <link-time>)))
    (<deadline-time> TIME)
    (<new-deadline-time>
     (and TIME
	  (compute-new-deadline <new-deadline-time> <pac> <hub-from>
				<deadline-time> <link-time>))))
   (and
    (link <hub-from> <hub-to> <link-time>)
    (satisfy-deadline <pac> <hub-from> <new-deadline-time>)))
  (effects
   ((<arrival-time>
     (and TIME
	  (compute-new-effective-time <arrival-time> <pac>
				      <hub-from> <link-time>))))
   ((add (satisfy-deadline <pac> <hub-to> <deadline-time>))
    (add (effectively-at <pac> <hub-to> <arrival-time>)))))


(OPERATOR INITIAL-ROUTE-PACKAGE
  (params <hub-from> <hub-to> <pac> <link-time> <deadline-time> <initial-time>
	  <arrival-time>)
  (preconds
   ((<hub-from> HUB)
    (<hub-to> HUB)
    (<pac> OBJECT)
    (<link-time>
     (and TIME
	  (get-link-time <hub-from> <hub-to> <link-time>)))
    (<deadline-time> TIME)
    (<initial-time>
     (and TIME
	  (compute-initial-time <initial-time> <pac> <hub-from>
				<deadline-time> <link-time>))))
   (and
    (link <hub-from> <hub-to> <link-time>)
    (effectively-at <pac> <hub-from> <initial-time>)))
  (effects
   ((<arrival-time>
     (and TIME
	  (compute-new-effective-time <arrival-time> <pac>
				      <hub-from> <link-time>))))
   ((add (satisfy-deadline <pac> <hub-to> <deadline-time>))
    (add (effectively-at <pac> <hub-to> <arrival-time>)))))

