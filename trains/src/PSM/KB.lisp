;;;; Dummy  Knowlege base until a real one is built

(in-package "PSM")

(let ((KB nil))

  (defun init-KB nil
    (setq KB nil)
    (clear-route-temp-info))

  (defun get-KB nil
    KB)

  (defun define-KB (props)
    (setq KB (mapcar #'check-for-route-info props)))

  (defun add-to-KB (prop)
    (if (not (member prop KB :test #'equal))
      (setq KB (cons (check-for-route-info prop) KB))))
  
  ;; direct match to KB avoiding overhead of handle-domain-query
  (defun domain-query (prop)
    (or (matchKB prop KB)
        (map-query prop)))
  
  (defun get-props-from-KB (predname)
    (remove-if-not #'(lambda (x) (eq (car x) predname))
		   KB))
 
)

;;    HANDLE DOMAIN ASSERT

(defun handle-psm-assert (prop)
  (let ((predname (car prop)))
    (cond 
     ((member predname (known-PS-level-predicate-names))
      (make-error-msg (format nil "You can't add a PS-level prop: ~S" prop)))
     ((contains-variable prop)
      (make-error-msg (format nil "You can't have variables in asserts: ~S" prop)))
     ((eq predname :AND)
      (let ((ans (mapcar #'handle-psm-assert (cdr prop))))
        (if (some #'(lambda (x) (eq (car x) 'ERROR)) ans)
	    (make-error-msg (format nil "Unknown error somewhere in AND: ~S" prop))
          (car ans))))
     ((member predname '(:OR :MEMBER :AT-PS-STATE))
      (make-error-msg (format nil "You can't add a ~S predicate: ~S" predname prop)))
     (t (handle-domain-assert prop)))))


(defun handle-domain-assert (prop)
  (add-to-KB prop)
  '(answer :result :SUCCESS))

(defun contains-variable (prop)
  (cond
   ((isvariable prop) t)
   ((consp prop)
    (some #'contains-variable prop))
   ))

;;   HANDLE DOMAIN QUERY

(defun handle-domain-query (op prop vars-of-interest plan ps-state)
  (prepare-answer-from-tuples
   op 
   prop 
   vars-of-interest
   (find-domain-tuples prop plan ps-state)))

;; This diverts any procedural queries to the right function, 
;;   and matches everything else against the KB

(defun find-domain-tuples (prop plan ps-state)
  (let ((predname (car prop))) 
    (case predname
      (:ENGINE-ROUTE (find-engine-routes ps-state))
      (:PROBLEM (find-route-problems ps-state))
      (otherwise
        (mapcar #'cdr
	     (remove-if-not #'(lambda (p)
				(eq (car p) predname))
			    (get-KB)))))))

(defun matchKB (prop KB)
  (some #'(lambda (x) (match-prop prop x 'T)) KB))


(defun match-prop (prop KBprop ST)
  ;;   THIS depends on the fact that there are no variables in the KB!
  (cond ((and (null prop) (null KBprop))
	 ST)
	((atom prop)
	 (cond 
	  ((eq KBprop prop) ST)
	  ((isvariable prop) 
	   (if (eq ST 'T) 
	       (list (cons (car prop) (car KBprop)))
	     (cons (cons (car prop) (car KBprop)) ST)))))
	((atom KBprop) nil)
	((isvariable (car prop))
	 (match-prop (cdr prop) (cdr KBprop) 
		      (if (eq ST 'T) 
			  (list (cons (car prop) (car KBprop)))
			(cons (cons (car prop) (car KBprop)) ST))))
	((atom (car prop))
         (if (eq (car prop) (car KBprop)) 
           (match-prop (cdr prop) (cdr KBprop) ST)))
        ((listp (car prop))
         (if (listp KBprop)
           (match-prop (cdr prop) 
                       (cdr KBprop) 
                       (match-prop (car prop) (car KBprop) ST))))
        (t nil)))

(defun isvariable (sym)
  (and (symbolp sym)
       (eq (car (coerce (symbol-name sym) 'list))
           #\?)))

(defun get-binding (var binding-list)
  (cdr (assoc var binding-list)))
         

;;  querys to the map

(defun map-query (prop)
  (cond ((eq (car prop) :connected)
         (let* ((city1 (lookup-city (second prop)))
                (city2 (lookup-city (third prop)))
                (tracks (location-direct-tracks city1)))
           (some #'(lambda (c)
                     (eq (track-to c) city2))
                 tracks)))))

;;  Procedural domain queries

;; (ENGINE-ROUTE ?eng ?route)
(defun find-engine-routes (ps-state)
  "Returns pair: agent - list of routes  for ENGINE-ROUTE query"
  (let ((plan-nodes (task-tree-leaf-cache ps-state))
	(st (task-tree-symbol-table ps-state)))
    (mapcan #'(lambda (n)
		(let* ((agent (car (handle-query-agent n)))
		       (soln (task-solution (task-node-content  n)))
		       (route (car (handle-query-actions n))))
		  (if route
		      (list (list agent route)))))
	    (mapcar #'(lambda (x) (get-node-by-name x ST)) plan-nodes))))

(defun get-engine-route-cities-and-tracks (ps-state)
  "Returns triple: (agent - list of cities - list of tracks) query"
  (let ((plan-nodes (task-tree-leaf-cache ps-state))
	(st (task-tree-symbol-table ps-state)))
    (mapcan #'(lambda (n)
		(let* ((agent (car (handle-query-agent n)))
		       (soln (task-solution (task-node-content  n)))
		       (route (car (handle-query-actions n))))
		  (if route
		      (list (list agent 
			    (mapcar #'(lambda (x) (car (find-constraint-in-act x :FROM))) route)
			    (mapcar #'(lambda (x) (car (find-constraint-in-act x :TRACK))) route))))))
	    (mapcar #'(lambda (x) (get-node-by-name x ST)) plan-nodes))))
			    
    
;; (PROBLEM ?type ?agent ?loc ?delay-time ?arg)
(defun find-route-problems (ps-state)
  "Finds all tuples of the :PROBLEM predicate that currently hold in the domain"
  (let* ((routes (get-engine-route-cities-and-tracks ps-state)) ;; routes will be a list of form (engine (list of cities) (list of tracks))
	 (possible-delays (get-props-from-KB :DELAY))
	 (delays (mapcan #'(lambda (r)
			     (find-actual-delays possible-delays (car r) (append (second r) (third r))))
			 routes))
	 (cross-delays (find-crossing-delays routes)))
    (if delays
	(mapcar #'cdr (append cross-delays delays))
      (mapcar #'cdr cross-delays))))
    
					      
(defun find-actual-delays (delay-props agent cities)
  "returns the delay props that involve a city in cities and converts it into a PROBLEM proposition"
  (when delay-props
    (let ((p (car delay-props)))
      (if (member (third p) cities)
	  (cons (list :PROBLEM :DELAY agent (third p) (fourth p) (second p))
		(find-actual-delays (cdr delay-props) agent cities))
	(find-actual-delays (cdr delay-props) agent cities)))))
		    
;;  FINDING ROUTE CORSSINGS

(defun find-crossing-delays (routes)
  "Given routes of form (engine  list-of-cities list-of-tracks), finds any routes that use same city at 
   same time and producing a crossed route delay"
  (case (length routes)
    ;; only possible when there's more than one route
    (2 (find-route-intersection (car routes) (second routes)))
    (3 (append (find-route-intersection (car routes) (second routes))
			(find-route-intersection (car routes) (third routes))
			(find-route-intersection (second routes) (third routes))))
    (otherwise nil)))
			

(defun find-route-intersection (route1 route2)
  (let* ((agent1 (car route1))
	 (cities1 (second route1))
	 (tracks1 (third route1))
	 (agent2 (car route2))
	 (cities2 (second route2))
	 (tracks2 (third route2))
	 (delay-cities (append (check-for-overlap cities1 cities2)
			       (check-for-overlap tracks1 tracks2))))
    (if delay-cities
	(mapcan #'(lambda (delay-city)
		    (list (list :PROBLEM :CROSSED-ROUTE agent1 delay-city 5 agent2)
			  (list :PROBLEM :CROSSED-ROUTE agent2 delay-city 5 agent1)))
		delay-cities))))
	      

(defun check-for-overlap (list1 list2)
  (when list1
    (if (eq (car list1) (car list2))
	(cons (car list1)
	      (check-for-overlap (cdr list1) (cdr list2)))
      (check-for-overlap (cdr list1) (cdr list2)))))

(defun append-solns (ll)
  (when ll
    (append (car ll)
	    (append-solns (cdr ll)))))
