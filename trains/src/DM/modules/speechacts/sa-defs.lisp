;; Time-stamp: <Mon Jan 13 16:52:00 EST 1997 ferguson>

(when (not (find-package :sa-defs))
  (load "sa-defs-def.lisp"))
(in-package sa-defs)

;; this lets us easily avoid haing assert "crash" the system.
(defmacro tt-assert (test-fn places format-string &rest args)
  "Like assert, but deals with debug flags"
  `(cond
    ((and user::*debug-interactive* (logging:debug-p :hard))
     (assert ,test-fn ,places ,format-string ,@args))
    ((not ,test-fn)
     (logging:log-warning (or kqml:*kqml-recipient* :DM) "Assert failed: ~?" ,format-string (list ,@args))
     t)))                               ; caller knows assert tripped.

(defclass-x generic-comm-act ()
  ((initiator :initform :user :accessor initiator :initarg :initiator)
   (mode :initform :written :accessor mode :initarg :mode)
   (reliability :initform 100 :accessor reliability :initarg :reliability :type (integer 0 100))
   ;; additional information some module didn't handle, e.g. unrecognized words.
   (noise :initform nil :accessor noise :initarg :noise)
   (action :initform nil :type t :accessor action :initarg :action) ; associated action, if any
   (input :initform nil :accessor input :initarg :input) ; what was written/said (more or less)
   ))                                   ; all comm acts inherit from this

(defun copy-gca (gca)                   ; always get here sooner or later
  (make-generic-comm-act :initiator (initiator gca)
                         :mode (mode gca)
                         :reliability (reliability gca)
                         :noise (noise gca)
                         :action (action gca)
                         :input (input gca)))

(defclass-x compound-communications-act (generic-comm-act)
  ((acts :type list :accessor acts :initarg :acts) ; a set of communications acts.
   (ps-state :initform nil :type symbol :accessor ps-state :initarg :ps-state) ; associated ps-state, if any.
   (plan :initform nil :type symbol :accessor plan :initarg :plan) ; associated plan, if any.
   ))

(defgeneric copy-sa (sa))

(defmethod copy-sa ((cca compound-communications-act))
  (progfoo (change-class (copy-gca cca) ; generic-comm-act
                         'compound-communications-act)
    (setf (acts foo) (mapcar #'copy-sa (acts cca)))
    (setf (ps-state foo) (ps-state cca))
    (setf (plan foo) (plan cca))))
    

(defmethod make-load-form ((o compound-communications-act) &optional environment)
  (declare (ignore environment))
  `(make-instance ',(class-name (class-of o))
     :initiator ',(initiator o)
     :mode ',(mode o)
     :reliability ',(reliability o)
     :action ',(action o)
     :acts ',(acts o)
     :noise ',(noise o)
     :ps-state ',(ps-state o)
     :plan ',(plan o)
     :input ',(input o)))

(defmethod print-object ((o compound-communications-act) stream)
  (if *print-readably*
      (format stream "#.~S" (make-load-form o))
    (print-unreadable-object (o stream :type t)
      ;; only print slots that are interesting
      (unless (eq (initiator o) :self)
        (format stream "Initiator: ~A" (initiator o)))
      (format stream " Mode: ~A " (mode o))
      (unless (eql (reliability o) 100)
        (format stream "Reliability ~D" (reliability o)))
      (if (plan o) 
          (format stream " Plan: ~W" (plan o)))
      (if (ps-state o)
          (format stream " PS-State: ~W" (ps-state o)))
      (if (action o)
          (format stream " Action: ~W" (action o)))
      (if (input o)
          (format stream " Input: ~W" (input o)))
      (mapc #'(lambda (x) (print x stream)) (acts o)))))

;; definitions of speech acts, with structures.
;; all acts are a subclass of communications-act.
(defclass-x communications-act (generic-comm-act) ; handle tds message protocol, can send these.
  ((focus :initform nil :accessor focus :initarg :focus)
   (objects :initform nil :accessor objects :initarg :objects)
   (paths :initform nil :accessor paths :initarg :paths) ; for all path-like properties, changes.
   (setting :initform nil :accessor setting :initarg :setting) ; for general settings related to an act, like "In avon, xxxx" that parser can't otherwise resolve.
   (syntax :initform nil :accessor syntax :initarg :syntax) ; this is wrong, should be per item in objects slot.
   (defs :initform nil :accessor defs :initarg :defs)
   (semantics :initform nil :accessor semantics :initarg :semantics)
   ;; urgency, politeness, etc.
   (social-context :initform nil :accessor social-context :initarg :social-context)
   ))

#+tds
(defmethod tds-user::comm-act-p ((message communications-act) &optional version)
  (declare (ignore version))
  t)

(defmethod copy-sa ((ca communications-act))
  (progfoo (change-class (copy-gca ca) ; generic-comm-act
                         (class-of ca)) ; makes a copy of what we inherited, so we handle all the guys who only differ by type.
    (setf (focus foo) (focus ca))
    (setf (objects foo) (copy-list (objects ca)))
    (setf (paths foo) (copy-list (paths ca)))
    (setf (setting foo) (if (consp (setting ca))
                            (copy-list (setting ca))
                          (setting ca)))
    (setf (syntax foo) (copy-list (syntax ca)))
    (setf (defs foo) (copy-list (defs ca)))
    (setf (semantics foo) (if (consp (semantics ca))
                              (copy-list (semantics ca))
                            (semantics ca)))
    (setf (social-context foo) (if (consp (social-context ca))
                                   (copy-list (social-context ca))
                                 (social-context ca)))))
    
        
(defmethod basic-ca-printer ((o communications-act) stream)
  (let ((*print-circle* t))
    (format stream "Initiator: ~A ~:_Mode: ~A ~:_Reliability: ~D ~_~@[Focus: ~W ~:_~]~@[Action: ~W ~:_~]" 
            (initiator o) (mode o) (reliability o) (focus o) (action o))
    (format stream "~@[Objects: ~W ~:_~]~@[Setting: ~W ~:_~]~@[Syntax: ~W ~:_~]~@[Paths: ~W ~:_~]" 
            (objects o) (setting o) (syntax o) (paths o))
    (format stream "~@[Defs: ~W ~:_~]~@[Semantics: ~W ~:_~]~@[Social-Context: ~W ~:_~]~@[Noise: ~W ~:_~]"
            (defs o) (semantics o) (social-context o) (noise o))
    (format stream "~@[Input: ~W ~:_~]" (input o))))

(defmethod print-object ((o communications-act) stream)
  (if *print-readably*
      (format stream "#.~S" (make-load-form o))
    (print-unreadable-object (o stream :type t)
      (pprint-logical-block (stream nil)
        (basic-ca-printer o stream)))))

(defmethod make-load-form ((o communications-act) &optional environment)
  (declare (ignore environment))
  `(make-instance ',(class-name (class-of o))
     :focus ',(focus o)
     :objects ',(objects o)
     :paths ',(paths o)
     :defs ',(defs o)
     :setting ',(setting o)
     :input ',(input o)
     :syntax ',(syntax o)
     :semantics ',(semantics o)
     :social-context ',(social-context o)
     :noise ',(noise o)
     #+TDS
     :cookies #+TDS ',(tds-basic:cookies o)
     #+TDS
     :thread #+TDS ',(tds-basic:thread o)))

(defclass-x sa-null (communications-act)
  ()) ;; no content. User just hit return, or said nothing. 

(defclass-x sa-point-with-mouse (communications-act)
  ())

(defclass-x speech-act (communications-act) ;; superclass
  ())

;;

(defclass-x sa-break (speech-act) ;; sez the prior and next sa cannot be combined.
  ())

(defclass-x sa-conversational-act (speech-act) ;; superclass
  ())

(defclass-x sa-response (sa-conversational-act) ; superclass and leaf (e.g. "maybe" isn't a confirm
                                                ; or a reject, but it is a response)
  ())

(defclass-x sa-close (sa-conversational-act) ;; e.g., I'm done.
  ())

(defclass-x sa-greet (sa-conversational-act) ;; e.g. hello
  ())

(defclass-x sa-reject (sa-response) ;;e.g., No. Not to avon
  ())


;;
(defclass-x sa-expressive (sa-conversational-act) ;; e.g. thank you
  ())

(defclass-x sa-apologize (sa-expressive)
  ())

(defclass-x sa-evaluation (sa-response) ;; e.g. "That's ok." or "great!"
  ())

(defclass-x sa-confirm (sa-response) ;; e.g., Okay
  ())


;;
(defclass-x sa-tell (speech-act) ;; superclass
  ())

(defclass-x sa-elaborate (sa-tell) ;; e.g., I'm taking the path through avon.
  ())

(defclass-x sa-warn (sa-tell) ;; e.g. the city bath is congested, you might want to use an alternate route.
  ())

(defclass-x sa-id-goal (sa-tell) ;; e.g., I need to geta train to Rochester
  ())


;;
(defclass-x sa-request-action (speech-act) ;; superclass
  ())
;; this should be handled as :action :restart on request.
(defclass-x sa-restart (sa-request-action) ;; e.g., Let's start over
  ())
(defclass-x sa-request (sa-request-action) ;; e.g., Send the train to Avon via Bath
  ())
(defclass-x sa-suggest (sa-request) ;; e.g. Let's go via avon
  ())



(defclass-x sa-question (sa-request-action) ;; superclass
  ())

(defclass-x sa-wh-question (sa-question) ;; e.g., Where is the train?
  ())

(defclass-x sa-why-question (sa-wh-question) ;;  e.g., why go to avon?, why not bath?
  ())

(defclass-x sa-how-question (sa-wh-question) ;;  e.g., How can I get to avon?
  ())

;; ok? is yn-question with 
(defclass-x sa-yn-question (sa-question) ;; e.g., Is Mount Morris red?
  ())


;;
(defclass-x sa-wait (speech-act) ;; e.g., Let^s see
  ())


;;
(defclass-x sa-conditional (speech-act) ;; e.g., If I use the train at Rochester ...
  ((condition :accessor condition :initarg :condition)
   (condition-object-true :accessor condition-object-true :initarg :condition-object-true)
   (condition-object-false :accessor condition-object-false :initarg :condition-object-false)))

(defmethod copy-sa :around ((sac sa-conditional))
  (progfoo (call-next-method)
    (setf (condition foo) (condition sac))
    (setf (condition-object-true foo) (condition-object-true sac))
    (setf (condition-object-false foo) (condition-object-false sac))))

(defmethod basic-ca-printer :after ((o sa-conditional) stream)
  (format stream "Condition: ~S, T: ~S F: ~S" 
          (condition o)
          (condition-object-true o)
          (condition-object-false o)))

(defmethod make-load-form ((o sa-conditional) &optional environment)
  (declare (ignore environment))
  `(make-instance ',(class-name (class-of o))
     :focus ',(focus o)
     :objects ',(objects o)
     :paths ',(paths o)
     :defs ',(defs o)
     :setting ',(setting o)
     :input ',(input o)
     :syntax ',(syntax o)
     :semantics ',(semantics o)
     :condition ',(condition o)
     :condition-object-true ',(condition-object-true o)
     :condition-object-false ',(condition-object-false o)
     #+TDS
     :cookies #+TDS ',(tds-basic:cookies o)
     #+TDS
     :thread #+TDS ',(tds-basic:thread o)))


;;
(defclass-x sa-nolo-comprendez (speech-act) ;; e.g. I don't understand (general)
  ())

(defclass-x sa-huh (sa-nolo-comprendez) ;; e.g. I have no idea what a berfle is.
  ((object :accessor object :initarg :object)
   (nc-plan :accessor nc-plan :initarg :nc-plan) ; plan we're having problems with.
   (expected-type :accessor expected-type :initarg :expected-type)))

(defmethod copy-sa :around ((sanc sa-nolo-comprendez))
  (progfoo (call-next-method)
    (setf (object foo) (object sanc))
    (setf (nc-plan foo) (nc-plan sanc))
    (setf (expected-type foo) (expected-type sanc))))

(defclass-x sa-ambiguous (sa-huh) ;; e.g. you said "the train at avon" but there are two there.
  ())                                   ; use inherited "object" as the list of abiguities,
                                        ; use inherited expected-type as the type of object we want. for
                                        ; clarification subdialogue.


(defmethod make-load-form ((o sa-huh) &optional environment)
  (declare (ignore environment))
  `(make-instance ',(class-name (class-of o))
     :focus ',(focus o)
     :objects ',(objects o)
     :paths ',(paths o)
     :defs ',(defs o)
     :setting ',(setting o)
     :input ',(input o)
     :syntax ',(syntax o)
     :semantics ',(semantics o)
     :object ',(object o)
     :expected-type ',(expected-type o)
     :nc-plan ',(nc-plan o)
     #+TDS
     :cookies #+TDS ',(tds-basic:cookies o)
     #+TDS
     :thread #+TDS ',(tds-basic:thread o)))

(defmethod basic-ca-printer :after ((o sa-huh) stream)
  (format stream "~&Bad Object: ~S, Expected-Type: ~S Plan: ~S" (object o) (expected-type o) (nc-plan o)))

;; the following can be contents of speech acts, as per NLU 2/e by James Allen

(defvar *all-objects* nil "All kb-objects")

(defflags kb
  for-reference)

(defclass-x kb-object () ;; common to anything that can be in a kb.
  ((name :initform 't :type symbol :initarg :name :accessor name)
   (flags :initform +kb-for-reference+ :type fixnum :initarg :flags :accessor kb-flags)))

(defmethod make-load-form ((o kb-object) &optional environment)
  `(or (find ',(name o) *all-objects* :key #'name :test #'equal)
       ,(make-load-form-with-all-slots o environment)))

(defmethod initialize-instance :after ((ob kb-object) &rest initargs)
  (declare (ignore initargs))
  (push ob *all-objects*))               ; so we can find it later, if necessary (on the same machine)

(defmethod print-object ((o kb-object) stream)
  (if *print-readably*
      (format stream "#.~S" (make-load-form o))
    (print-unreadable-object (o stream :type t) 
      (princ (name o) stream)
      (when (kb-for-reference-p o)
        (format stream " <ForReference> ")))))

(defclass-x proposition (kb-object) ;; common to all propositions
  ((parser-token :initform nil :accessor parser-token :initarg :parser-token)))

(defclass-x n-ary-operator (kb-object)
  ((arity :reader arity :initarg :arity)))

(defclass-x 1-ary-operator (n-ary-operator)
  ((arity :initform 1)))

(defclass-x 2-ary-operator (n-ary-operator)
  ((arity :initform 2)))

(let (operators)
  (defun all-operators ()
    operators)                          ; for debugging
  (defun find-operator (op)
    (find op operators :key #'name))
  (defun make-operator (op arity)
    (or (find-operator op)
        (progfoo (case arity
                   (1
                    (make-1-ary-operator :name op))
                   (2
                    (make-2-ary-operator :name op))
                   (t
                    (make-n-ary-operator :name op :arity arity)))
          (push foo operators)))))

(defmethod print-object ((o n-ary-operator) stream)
  (if *print-readably*
      (call-next-method)
    (print-unreadable-object (o stream :type t)
      (princ (name o) stream))))

(defclass-x prop-prop (proposition)       ; proposition that takes other propositions as arguments (inherited class)
  ((propositions :type list :initarg :propositions :accessor propositions)))

(defclass-x operator-prop (prop-prop)
  ((operator :type n-ary-operator :initarg :operator :accessor operator)))

(defmethod print-object ((o operator-prop) stream)
  (if *print-readably*
      (call-next-method)
    (print-unreadable-object (o stream :type t) 
      (format stream "~A~{ ~S~}" (name (operator o)) (propositions o)))))
   
(defclass quantifier (kb-object)
  ())

(defun quantifier-p (x)
  (typep x 'quantifier))

(let (quantifiers)
  (defun find-quantifier (q)
     (find q quantifiers :key #'name))
  (defun make-quantifier (q)
    (or (find-quantifier q)
        (progfoo (make-instance 'quantifier :name q)
          (push foo quantifiers)))))

(defmethod print-object ((o quantifier) stream)
  (if *print-readably*
      (call-next-method)
    (print-unreadable-object (o stream :type t)
      (princ (name o) stream))))

(defclass-x vari (kb-object)            ; can be used for "what" etc.
  ((vclass :initform nil :initarg :vclass :accessor vclass)
   (vsort :initform nil :initarg :vsort :accessor vsort)))

(defmethod print-object ((o vari) stream)
  (cond
   (*print-readably*
    (call-next-method))
   (kqml:*print-for-kqml*
    (intern (format nil "?~A" (name o)) user::*hack-package*)) ; sort/class better be elsewhere.
   (t
    (print-unreadable-object (o stream :type t) 
      (princ (name o) stream)
      (if (slot-boundp o 'vclass)
          (format stream " vclass: ~S" (vclass o)))
      (if (slot-boundp o 'vsort)
          (format stream " vsort: ~S" (vsort o)))))))

(defclass-x quantifier-prop (prop-prop)
  ((quantifier :type quantifier :initarg :quantifier :accessor quantifier)
   (variable :type vari :initarg :variable :accessor variable)))

(defmethod print-object ((o quantifier-prop) stream)
  (if *print-readably*
      (call-next-method)
    (print-unreadable-object (o stream :type t) 
      (format  stream "~S ~S~{ ~S~}" (quantifier o) (variable o) (propositions o)))))


(defclass-x n-ary-predicate (kb-object)
  ((arity :accessor arity :initarg :arity)
   (flags :accessor pred-flags :initform 0 :initarg :pred-flags :type fixnum)))

(defflags pred
  for-reference
  type)

(defmethod print-object ((o n-ary-predicate) stream)
  (if *print-readably*
      (call-next-method)
    (print-unreadable-object (o stream :type t)
      (princ (name o) stream))))


(defclass-x 1-ary-predicate (n-ary-predicate)
  ((arity :initform 1)))

(defclass-x 2-ary-predicate (n-ary-predicate)
  ((arity :initform 2)))

(let (predicates)
  (defun find-predicate (pred)
    (find pred predicates :key #'name))
  
  (defun make-predicate (pred arity)
    (or (find-predicate pred)
        (progfoo
            (case arity
              (1
               (make-1-ary-predicate :name pred))
              (2
               (make-2-ary-predicate :name pred))
              (t
               (make-n-ary-predicate :name pred :arity arity)))
          (push foo predicates))))
  (defun make-type-predicate (pred)
    (progfoo (find-predicate pred)
      (if foo
          (tt-assert (pred-type-p foo) () "Addition of a type-predicate, formally added as a regular predicate")
        (return-from make-type-predicate
          (progfoo (make-predicate pred 1)
            (setf (pred-type-p foo) t)))))))

(defclass-x predicate-prop (proposition)
  ((predicate :type n-ary-predicate :initarg :predicate :accessor predicate)
   (terms :type list :initarg :terms :initform nil :accessor terms)))

(defmethod print-object ((o predicate-prop) stream)
  (if *print-readably*
      (call-next-method)
    (print-unreadable-object (o stream :type t) 
      (format stream "~A~{ ~S~}" (name (predicate o)) (terms o)))))


(eval-when ( :load-toplevel :eval)
  (make-operator :not 1)
  (make-operator :and 2)
  (make-operator :or 2)
  (make-predicate :member t)
  (make-quantifier :the)
  (make-quantifier :some)
  (make-quantifier :every)
  (make-quantifier :forall)
  (make-quantifier :exists)
  (make-quantifier :wh))

(defparameter *from-pred* (make-predicate :from 1))
(defparameter *other-pred* (make-predicate :other 1))

(defclass-x collection (kb-object)
  ((terms :type list :initarg :terms :accessor terms)
   (flags :type fixnum :initarg 0 :accessor collection-flags)))

(defflags collection
  disjunct)

(defmethod print-object ((o collection) stream)
  (cond
   (*print-readably*
    (call-next-method))
   (kqml:*print-for-kqml*
    (if (endp (cdr (terms o)))
        (format stream "~W" (car (terms o))) ; don't bother if there's no alternative.
      (format stream "(~S~{ ~S~})" (if (collection-disjunct-p o) :OR :AND) (terms o))))
   (t
    (format stream "{~{ ~S~}}:~A" (terms o) (if (collection-disjunct-p o) "DISJ" "CONJ")))))

;; for passing paths
(defclass-x path-quantum (kb-object)
  ((engine :initform nil :initarg :engine :accessor engine)
   (from :initform nil :initarg :from :accessor from)
   (not-from :initform nil :initarg :not-from :accessor not-from) ; might be used to disambiguate between multiple foci
   (to :initform nil :initarg :to :accessor to)
   (not-to :initform nil :initarg :not-to :accessor not-to) ; similar to not-via, avoid the city. Might be content of reject.
   (via :initform nil :initarg :via :accessor via)
   (not-via :initform nil :initarg :not-via :accessor not-via)
   (use :initform nil :initarg :use :accessor use)
   (stay-at :initform nil :initarg :stay-at :accessor stay-at) ; gf
   (beyond :initform nil :initarg :beyond :accessor beyond)
   (not-beyond :initform nil :initarg :not-beyond :accessor not-beyond)
   (between :initform nil :initarg :between :accessor between)
   (not-between :initform nil :initarg :not-between :accessor not-between)
   (predicates :initform nil :initarg :predicates :accessor predicates)
   (preferences :initform nil :initarg :preferences :accessor preferences)))

(defun copy-path-quantum (pq)
  (make-path-quantum
   :engine (engine pq)
   :from (from pq)
   :not-from (if (consp (not-from pq))
                 (copy-list (not-from pq))
               (not-from pq))
   :to (to pq)
   :not-to (if (consp (not-to pq))
                 (copy-list (not-to pq))
             (not-to pq))
   :via (if (via pq)
            (copy-list (via pq)))
   :not-via (if (not-via pq)
                (copy-list (not-via pq)))
   :use (if (use pq)
            (copy-list (use pq)))
   :stay-at (if (stay-at pq) 		; gf
		(copy-list (stay-at pq)))
   :beyond  (if (beyond pq)
                (copy-list (beyond pq)))
   :not-beyond (if (not-beyond pq)
                   (copy-list (not-beyond pq)))
   :between (if (between pq)
                (copy-list (between pq)))
   :not-between (if (not-between pq)
                    (copy-list (not-between pq)))
   :predicates (if (predicates pq)
                   (copy-list (predicates pq)))
   :preferences (if (preferences pq)
                    (copy-list (preferences pq)))))

(defmethod print-object ((o path-quantum) stream)
  (cond
   (*print-readably*
    (format stream "#.~W" (make-load-form o)))
   (kqml:*print-for-kqml*
    (let (supress-slots supress-all-slots)
      (format stream "(:AND")           ; this avoids consing
      (dolist (pred (predicates o))
        (cond
         ((eq (name (predicate pred)) :direct)
          (format stream " (:DIRECTLY ~W)" (terms pred))
          (if (path-quantum-p (car (terms pred))) ; directly for the whole pq, so don't repeat it.
              (setq supress-all-slots t)
            (push (car (terms pred)) supress-slots))) ; ps doesn't want to see them twice
         (t
          (let ((kqml:*print-for-kqml* nil))
            (logging:log-warning :ps "Unhandled predicate ~S in path quantum ~S - for PS" pred o))))) ; and gets silently dropped.
      (unless supress-all-slots
        (flet ((pslot (s sname)
                 (if (and s (not (member sname supress-slots)))
                     (format stream " ~W" `(,sname ,@(if (consp s) s (list s))))))
               (pnslot (s sname psname)
                 (if (and s (not (member sname supress-slots)))
                     (format stream " ~W" `(:not (,psname ,@(if (consp s) s (list s))))))))
          (pslot (engine o) :agent)
          (pslot (from o) :from)
          (pslot (to o) :to)
          (pslot (via o) :via)
          (pslot (use o) :use)
          (pslot (stay-at o) :stay-at)	; gf
          (pnslot (not-from o) :not-from :from)
          (pnslot (not-to o) :not-to :to)
          (pnslot (not-via o) :not-via :via)
          (pslot (beyond o) :beyond)
          (pnslot (not-beyond o) :not-beyond :beyond)
          (pslot (between o) :between)
          (pnslot (not-between o) :not-between :between)
          (pslot (preferences o) :preference)))
      (format stream ")")))
   (t
    (print-unreadable-object (o stream :type t) 
      (format stream "~@[~W: ~]~W -> ~W~@[ Via ~W~]~@[ </- ~W~]~@[ /-> ~W~]~@[ NotVia ~W~]~@[ ->> ~W~]~@[ /->> ~W~]~@[ <> ~W~]~@[ /<> ~W~] ~@[ USE: ~W~] ~@[ STAY-AT: ~W~]~{{~W}~}" 
              (engine o)
              (from o)
              (to o)
              (via o)
              (not-from o)
              (not-to o)
              (not-via o)
              (beyond o)
              (not-beyond o)
              (between o)
              (not-between o)
              (use o)
              (stay-at o)		; gf
              (predicates o))))))


