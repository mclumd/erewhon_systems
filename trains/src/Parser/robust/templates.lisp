(NIL
 SA-semantics
 ()
 ((lambda (x) (make-lookup-table (list x)) (and (listp (SA-semantics x)) (member ':INSTEAD (SA-semantics x)) (equal ':USE (rest (find-cl (rest (lookup (second (SA-semantics x))))))))))
 ((lambda (x) (setf temp (new-var))
    (setf (SA-objects x) (cons (list temp ':PATH (list ':VAR temp) (list ':CONSTRAINT (list ':VIA temp (third (assoc ':LOBJ (find-edges (cddr (lookup (second (SA-semantics x)))))))))) (cons (swap '(:CLASS :GO-BY-PATH) (list ':CLASS (rest (find-cl (rest (lookup (second (SA-semantics x))))))) (lookup (second (SA-semantics x)))) (remove (lookup (second (SA-semantics x))) (SA-objects x)))))))
()
()
)

(:ACCEPT 
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :OBJECTIVE) 1.0)
 ()
 ()
 ()
 ()
)

(:APPEARS-TO-BE
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :ANY-SEM) 1.0
  :LOBJ (:PROP . :PROP) 1.0)
 ()
 ()
 ()
 ()
)

(COMMENT "Changes arrive verb to arrive-at verb.  This involves replacing the
at-loc slot in the arrive verb to be the object of the arrive-at verb")

(COMMENT "e.g. The train arrived at avon into the train got to avon")

(:ARRIVE
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0
  :LCOMP (:PATH . :PATH) 1.0)
 ()
 ((change-roles ((:LOBJ :AT-LOC)))
  (swap-class :ARRIVE-AT))
 ()
 ()
)

(COMMENT "Changes arrive-at verb to go-by-path verb.  Changes the object of 
the arrive-at verb to a path, and makes the path the complement of the go-y-
path verb.")

(COMMENT "e.g. The train should arrive at avon into the train goes to avon")

(:ARRIVE-AT
 SA-semantics
 ()
 ()
 ((lambda (x) 
    (let* ((dest (assoc ':LOBJ (find-edges (SA-semantics x))))
	   (var (new-var))
	   (path (list var ':PATH (list ':VAR var) (list ':CONSTRAINT (list ':TO var (third dest))))))
      (when dest
	(setf (SA-objects x) (append (SA-objects x) (list path)))
	(replace-role (first path) ':LOBJ x))))
  (change-roles ((:LCOMP :LOBJ)))
  (swap-class :GO-BY-PATH))
 ()
 ()
)


(:ATTACH
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :CONTAINER) 1.0)
 ()
 ()
 ()
 ()
)

(:AVOID 
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0
  :LOBJ (:DESCRIPTION . :PHYS-OBJ) 1.0)
 ()
 ()
 ()
 ()
)

((:BE :EQUAL)
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :ANY-SEM) 1.0
  :LOBJ (:DESCRIPTION . :PHYS-OBJ) 1.0)
 ()
 ()
 ((lambda (x) (make-lookup-table (list x)) (and (equal (rest (find-cl (find-part (SA-semantics x) ':LSUBJ))) ':GOAL))))
 ((lambda (x) (setf (SA-type x) 'SA-ID-GOAL)))
)

((:BE :EQUAL)
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :ANY-SEM) 1.0
  :LOBJ (:DESCRIPTION . :PHYS-OBJ) 1.0)
 ()
 ()
 ((lambda (x) (make-lookup-table (list x)) (and (equal (rest (find-cl (find-part (SA-semantics x) ':LSUBJ))) ':TIME-DURATION))))
 ((lambda (x) (setf (SA-type x) 'SA-WH-QUESTION)))
)

((:BE :AT-LOC)
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PHYS-OBJ) 1.0
  :LOBJ (:DESCRIPTION . :FIXED-OBJ) 1.0)
 () 
 () 
 ()
 ()
)   

(:BE-AVAILABLE-TO 
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0
  :LOBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0
  :LCOMP (:DESCRIPTION . :FIXED-OBJ) 1.0)
 ()
 ()
 ()
 ()
)

((:BE (:HI :COMPLETION))
 SA-semantics
 ()
 ()
 ()
 ((lambda (x) (equal (SA-type x) 'SA-TELL)))
 ((lambda (x) (setf (SA-type x) 'SA-CLOSE)))
)

(:BELIEVE 
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0
  :LOBJ (:PROP . :PROP) 1.0)
 ()
 ()
 ()
 ()
)

(:CANCEL
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0
  :LOBJ (:DESCRIPTION . :ANY-SEM) 1.0)
 ()
 ()
 ()
 ()
)

(:CHANGE
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0
  :LOBJ (:DESCRIPTION . :ANY-SEM) 1.0
  :LCOMP (:DESCRIPTION . :ANY-SEM) 1.0)
 ()
 ()
 ()
 ()
)

(:COME-TO-KNOW
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :ANY-SEM) 1.0)
 ()
 ()
 ()
 ()
)

(:COMMIT
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:PROP . :PROP) 1.0)
 ()
 ()
 ()
 ()
)

(:COMPLETE
 SA-semantics
 ()
 ()
 ()
 ()
 ()
)

(:CONFIRM
 SA-semantics
 ()
 ()
 ()
 ()
 ()
)

(:CONFLICT
 SA-semantics
 ()
 ()
 ()
 ()
 ()
)

(:CONNECTED-TO
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :FIXED-OBJ) 1.0
  :LCOMP (:DESTINATION . :FIXED-OBJ) 1.0)
 ()
 ()
 ()
 ()
)

(:CONNECTS
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :SEQUENCE) 1.0
  :LOBJ (:DESCRIPTION . :FIXED-OBJ) 1.0
  :LCOMP (:DESCRIPTION . :FIXED-OBJ) 1.0)
 ()
 ()
 ()
 ()
)

(:CREATE
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0
  :LOBJ (:DESCRIPTION . :COMMODITY) 1.0
  :LCOMP (:DESCRIPTION . :COMMODITY) 1.0)
 ()
 ()
 ()
 ()
)

(:CREATE 
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0
  :LOBJ (:DESCRIPTION . :PLAN) 1.0)
 ()
 ()
 ()
 ()
)

(:DELIVER-PUT
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0
  :LOBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0
  :LCOMP (:DESCRIPTION . :FIXED-OBJ) 1.0)
 ()
 ()
 ()
 ()
)

(:DEPART
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :PHYS-OBJ) 1.0)
 ()
 ()
 ()
 ()
)
 
(:DISPLAY
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :ANY-SEM) 1.0
  :LIOBJ (:DESCRIPTION . :ANY-SEM) 1.0)
 () 
 ()
 ()
 ()
)

(:DO
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :ACTION) 1.0)
 ()
 ()
 ()
 ()
)

(:EXISTS
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :ANY-SEM) 1.0)
 ()
 () 
 ()
 ()
)

(:FIND
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0
  :LOBJ (:DESCRIPTION . :PHYS-OBJ) 1.0) 
 ()
 ()
 ()
 ()
)

(:FIND
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0
  :LOBJ (:DESCRIPTION . :SEQUENCE) 1.0)
 ()
 ()
 ()
 ()
)

(:FOCUS-ON
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LCOMP (:DESCRIPTION . :ANY-SEM) 1.0)
 ()
 ()
 ()
 ()
)

(:FOLLOW
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0
  :LOBJ (:DESCRIPTION . :SEQUENCE) 1.0)
 ()
 ()
 ()
 ()
)

(COMMENT "Changes forget verb in imperative to cancel verb")

(:FORGET
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0)
 ((lambda (x) (equal (SA-type x) 'SA-REQUEST))
  (lambda (x) (equal (third (assoc ':LSUBJ (find-edges (SA-semantics x)))) ':*YOU*)))
 ((swap-class :CANCEL))
 ()
 ()
)

(:GAIN-SAVE
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0)
 ()
 ()
 ()
 ()
)

(:GO-BACK
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0
  :LCOMP (:DESCRIPTION . :PATH) 1.0)
 ()
 ()
 ()
 ()
)

(COMMENT "Changed go-by-path verb to use verb, if the go-by-path has an object,
i.e. is of the form 'Take the route...'")

(COMMENT "Changed go-by-path verb to move verb, if the go-by-path has a 
complement, i.e. is of the form 'Go to ...' Not used just now because I'm not
sure this is really what we want to do.")

(:GO-BY-PATH
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0
  :LOBJ (:DESCRIPTION . :SEQUENCE) 1.0)
 ()
 () 
 ()
 ()
)

(COMMENT "Changed go-by-path verb to use verb, if the go-by-path has an object,
i.e. is of the form 'Take the route...'")

(COMMENT "Changed go-by-path verb to move verb, if the go-by-path has a 
complement, i.e. is of the form 'Go to ...' Not used just now because I'm not
sure this is really what we want to do.")

(:GO-BY-PATH
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0
  :LCOMP (:DESCRIPTION . :PATH) 1.0)
 ((lambda (x) (assoc ':LOBJ (find-edges (SA-semantics x)))))
 ((swap-class :USE))
 ()
 ()
)

(COMMENT "Changed go-to verb into go-by-path verb.  Since the complement of
go-to is a destination, and the complement of go-by-path is a path, we need
to make a path of the destination")

(COMMENT "e.g. It headed for avon becomes it headed to avon")

(:GO-TO 
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0
  :LCOMP (:DESCRIPTION . :FIXED-OBJ) 1.0)
 ()
 ((lambda (x) 
    (let* ((dest (assoc ':LCOMP (find-edges (SA-semantics x))))
	   (var (new-var))
	   (path (list var ':PATH (list ':VAR var) (list ':CONSTRAINT (list ':TO var (third dest))))))
      (when dest
	(setf (SA-objects x) (append (SA-objects x) (list path)))
	(replace-role (first path) ':LCOMP x))))
  (swap-class :GO-BY-PATH))
 ()
 ()
)

(:HAVE
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0
  :LOBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0)
 ()
 ()
 ()
 ()
)

(:HAVE-SPACE-FOR
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0
  :LOBJ (:DESCRIPTION . :CONTAINER) 1.0)
 ()
 ()
 ()
 ()
)

(:IGNORE
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :ANY-SEM) 1.0)
 ()
 ()
 ()
 ()
)

(:KEEP
 SA-semantics
 ()
 ()
 ()
 ()
 ()
)

(:LET
 SA-semantics
 ()
 ()
 ()
 ()
 ()
)

(:LOSE
 SA-semantics
 ()
 ()
 ()
 ()
 ()
)

(:LOAD-INTO
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :COMMODITY) 1.0
  :LCOMP (:DESCRIPTION . :CONTAINER) 1.0)
 ()
 ()
 ()
 ()
)

(COMMENT "Changes load-with verb into load-into verb.  Since the object of 
load-with is the complement of load-into and vice versa, we have to swap them 
around")

(COMMENT "e.g. We loaded the boxcar with oranges into We loaded the oranges 
into the boxcar")

(:LOAD-WITH
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :CONTAINER) 1.0
  :LCOMP (:DESCRIPTION . :COMMODITY) 1.0)
 ()
 ((change-roles ((:LOBJ :LCOMP) (:LCOMP :LOBJ)))
  (swap-class :LOAD-INTO))
 ()
 ()
)

(:MAKE-IT-SO
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0
  :LCOMP (:DESCRIPTION . :PATH) 1.0)
 ()
 ()
 ()
 ()
)

(:MEET
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0
  :LOBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0)
 ()
 ()
 ()
 ()
)

(:MOVE 
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0
  :LOBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0
  :LCOMP (:DESCRIPTION . :PATH) 1.0)
 ()
 ()
 ()
 ()
)

(:OPTIMIZE
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :PLAN) 1.0)
 ()
 ()
 ()
 ()
)

(:PASS-BY
 SA-semantics
 ()
 ()
 ()
 ()
 ()
)

(:PICK-UP
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0
  :LOBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0)
 ()
 ()
 ()
 ()
)

(:REPAIR
 SA-semantics
 ()
 ()
 ()
 ()
 ()
)

(:QUIT
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :ANY-SEM) 1.0)
 ()
 ()
 ()
 ()
)

(:RESOURCE-LEFT
 SA-semantics
 ()
 ()
 ()
 ()
 ()
)

(:RESOURCE-SAVED
 SA-semantics
 ()
 ()
 ()
 ()
 ()
)

(:RESOURCE-LOST
 SA-semantics
 ()
 ()
 ()
 ()
 ()
)

(:RESTART
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0
  :LOBJ (:DESCRIPTION . :ANY-SEM) 1.0)
 ()
 ()
 ((lambda (x) (or (and (not (assoc ':LOBJ (find-edges (SA-semantics x)))) 
		   (not (assoc ':LCOMP (find-edges (SA-semantics x)))))
		  (and (not (assoc ':LCOMP (find-edges (SA-semantics x))))
		       (assoc ':LOBJ (find-edges (SA-semantics x)))
		       (equal ':PLAN (rest (find-cl (third (assoc ':LOBJ (find-edges (SA-semantics x)))))))))))
    
 ((lambda (x) (setf (SA-type x) 'SA-RESTART)))
)
 
(:REVISE
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :OBJECTIVE) 1.0)
 ()
 ()
 ()
 ()
)

(:SAY
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :ANY-SEM) 1.0
  :LCOMP (:DESCRIPTION . :PERSON) 1.0)
 ()
 ()
 ()
 ()
)

(:SCHEDULE
 SA-semantics
 ()
 ()
 ()
 ()
 ()
)

(:SEE
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :PHYS-OBJ) 1.0)
 ()
 ()
 ()
 ()
)

(:SEND 
 SA-semantics
 ()
 ()
 ()
 ()
 ()
)

(:START
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0)
 ()
 ()
 ()
 ()
)

(:STAY-UNTIL
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0
  :LOBJ (:DESCRIPTION . :FIXED-OBJ) 1.0
  :LCOMP (:DESCRIPTION . :TIME-INTERVAL) 1.0)
 ()
 ()
 ()
 ()
)

(:STOP 
 SA-semantics
 (:LSUBJ (:DESCRIOTION . :AGENT) 1.0)
 ()
 ()
 ()
 ()
)

(:TAKE-TIME
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0
  :LOBJ (:DESCRIPTION . :TIME-DURATION) 1.0
  :LCOMP (:PROP . :ANY-SEM) 1.0)
 ()
 ()
 ()
 ()
)

(:TELL
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :ANY-SEM) 1.0
  :LIOBJ (:DESCRIPTION . :PERSON) 1.0)
 ()
 ()
 ()
 ()
)

(:THANK
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :PERSON) 1.0)
 ()
 ()
 ()
 ()
)

(:TRY 
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0
  :LOBJ (:DESCRIPTION . :OBJECTIVE) 1.0)
 ()
 ()
 ()
 ()
)

(:TRY
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0
  :LOBJ (:PROP . :PROP) 1.0)
 ()
 ()
 ()
 ()
)

(:UNLOAD 
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :COMMODITY) 1.0
  :LCOMP (:DESCRIPTION . :CONTAINER) 1.0)
 ()
 ()
 ()
 ()
)

(:USE
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :AGENT) 1.0
  :LOBJ (:DESCRIPTION . :ANY-SEM) 1.0)
 ()
 ()
 ()
 ()
)

(:WANT-NEED
  SA-semantics
 (:LSUBJ (:DESCRIPTION . :MOVABLE-OBJ) 1.0
  :LOBJ (:DESCRIPTION . :PHYS-OBJ) 1.0
  :LCOMP (:PROP . :PROP) 1.0)
 ()
 ()
 ((lambda (x) (equal (SA-type x) 'SA-TELL)))
 ((lambda (x) (setf (SA-type x) 'SA-ID-GOAL)))
)

(:WANT-OBJECT
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LOBJ (:DESCRIPTION . :ANY-SEM) 1.0)
 ()
 ()
 ()
 ()
)

(:WORRY 
 SA-semantics
 (:LSUBJ (:DESCRIPTION . :PERSON) 1.0
  :LCOMP (:DESCRIPTION . :ANY-SEM) 1.0)
 ()
 ()
 ()
 ()
)









