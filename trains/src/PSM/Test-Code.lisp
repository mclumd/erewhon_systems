;; TESTER

(in-package "PSM")

;; Set up basic map

(defun define-connection-pred (from to)
  (let* ((sorted-names (sort (list from to) #'string-lessp))
	 (name (intern (format nil "~A-~A" (car sorted-names) (cadr sorted-names)))))
    (list :connection name from to :train 100 2)))
  
(defvar map-description
  (cons :and
  (append
   (mapcar #'(lambda (x) (list :type x :city))
	   '(albany atlanta baltimore buffalo burlington boston charleston charlotte
	     chicago cincinnati cleveland columbus detroit indianapolis lexington milwaukee 
	     montreal new_york_city philadelphia pittsburgh raleigh richmond scranton syracuse toledo toronto washington))
   (mapcar #'(lambda (x)
	       (define-connection-pred (car x) (cadr x)))
	   '((albany burlington)
	     (albany boston)
	     (albany new_york_city)
	     (albany syracuse)
	     (atlanta charlotte)
	     (atlanta lexington)
	     (baltimore washington)
	     (baltimore scranton)
	     (baltimore philadelphia)
	     (buffalo cleveland)
	     (Buffalo Toronto)
	     (Buffalo Syracuse)
	     (Buffalo Pittsburgh)
	     (Burlington Montreal)
	     (Boston New_york_city)
	     (charleston cincinnati)
	     (charleston pittsburgh)
	     (charleston richmond)
	     (charleston charlotte)
	     (charlotte raleigh)
	     (chicago milwaukee)
	     (chicago indianapolis)
	     (chicago toledo)
	     (cincinnati indianapolis)
	     (cincinnati lexington)
	     (cleveland toledo)
	     (columbus toledo)
	     (columbus indianapolis)
	     (columbus pittsburgh)
	     (columbus cincinnati)
	     (detroit toledo)
	     (detroit toronto)
	     (indianapolis lexington)
	     (montreal toronto)
	     (new_york_city scranton)
	     (new_york_city philadelphia)
	     (philadelphia scranton)
	     (pittsburgh scranton)
	     (raleigh richmond)
	     (richmond washington)
	     (scranton syracuse)
	     )))))

(eval-when (load eval) 
  (handle-psm-assert map-description))


;; Basic goal introduction, further specification and confirmation
(defun t1 nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) ;;(:delay :STORM buffalo-toronto 10)
	     (:DELAY :WIND columbus 5))
           "I want to go from atlanta to montreal"
           "Go via cincinnati"
           "OK"))

(defun t1A nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE)
	     (:DELAY :WIND columbus 5))
           "I want to go from atlanta to montreal the cheapest way possible"
           "Go via cincinnati"
           "OK"))

(defun t1B nil
  (tester3 '(:and (:AT-LOC eng1 pittsburgh) (:AT-LOC eng2 albany) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE))
           "I want to go from pittsburgh to chicago in less than 20 hours"
	   "Go the cheapest way possible"
	   "Go via cincinnati"))

;; Modification to a longer route, then a route extension.
(defun t2 nil 
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE))
           "Let's go from atlanta to chicago"
           "Go via pittsburgh"
           "Now let's go from chicago to montreal"))
     
;; monotonic INSTEAD correction, topic shift

(defun t3 nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-loc eng2 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (TYPE indianapolis :city))
           "Let's go from atlanta to chicago"
           "Go via pittsburgh instead of indianapolis"
           "Now let's go from cleveland to montreal as quickly as possible"))

;; relation not identified in correction

(defun t3A nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:at-loc eng2 atlanta) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:type pittsburgh :city) (:type indianapolis :city))
           "Let's go from atlanta to chicago"
	   "Use eng1"
           "No, pittsburgh instead of indianapolis"
         ))

(defun t3B nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:type albany :city) (:type toronto :city))
           "I want to go from atlanta to montreal"
           "Go via cincinnati"
	   "No, albany instead of toronto"))

(defun t3c nil
  (tester3 '(:and (:AT-LOC eng1 pittsburgh) (:AT-LOC eng2 albany) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:type albany :city) (:type pittsburgh :city))
           "I want to go from pittsburgh to chicago"
	   "No, albany instead of pittsburgh"
	   "OK"))
  

(defun t3d nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE))
           "I want to go from atlanta to montreal"
           "Go via cincinnati"
	   "No"))

(defun t4 nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE))
           "Let's go from atlanta to chicago"
           "Go directly from indianapolis to chicago"
           "Now let's go from chicago to montreal"))

(defun t5 nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago)  (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE))
	    "Let's go from atlanta to chicago"
	    "No, Go to montreal"
	    "Go via pittsburgh"))

;; tests multiple reasons
(defun t5a nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago)  (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE))
	    "Let's go from atlanta to chicago"
	    "Go to montreal"
	    "Go via pittsburgh"))

(defun t6 nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 cincinnati) (:AT-LOC eng3 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE)
	     (:delay :wind montreal 5) (:delay :snow chicago 3))
	    "Let's go from atlanta to chicago"
	    "Go from cincinnati"
	    "Now let's go from cleveland to montreal"))

(defun t6a nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 cincinnati) (:AT-LOC eng3 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE)
	     (:delay :wind montreal 5) (:delay :snow chicago 3))
	    "Let's go from atlanta to chicago via cincinnati"
	    "Now let's go from cleveland to montreal"
	    "Cancel the route from toronto to montreal"))

(defun t6b nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 cincinnati) (:AT-LOC eng3 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE)
	     (:delay :wind montreal 5) (:delay :snow chicago 3))
	    "Let's go from atlanta to chicago via cincinnati"
	    "Now let's go from cleveland to montreal"
	    "Cancel the route from atlanta to chicago"))

(defun t6c nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 cincinnati) (:AT-LOC eng3 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE)
	     (:delay :wind montreal 5) (:delay :snow chicago 3))
	   "Now let's go from cleveland to montreal"
	   "Let's go from atlanta to chicago via cincinnati"
	   "Cancel the route from atlanta to chicago"))

(defun t6d nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 cincinnati) (:AT-LOC eng3 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE)
	     (:delay :wind montreal 5) (:delay :snow chicago 3))
	   "Now let's go from cleveland to montreal"
	   "Let's go from atlanta to chicago via cincinnati"
	   "Cancel the goal of going to chicago"))

(defun t7 nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 cincinnati) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	     "Go to chicago"
	    "Go from cincinnati"
	    "Go directly to chicago"))
;; changing plans using a new agent
(defun t8 nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 cincinnati) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	     "Take ENG1 to chicago"
	    "Go from cincinnati"
	    "Take ENG2 to chicago"))

;; Testing introduce of two goals and then refining t9 should be :GOOD, T9A :OK
(defun t9 nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	   "I want to go to Chicago"
	   "I want to go to Montreal"
	   "Let's go from atlanta to chicago"))
	
(defun t9A nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	   "I want to go to Montreal"
	   "I want to go to Chicago"
	   "Let's go from atlanta to chicago"))
	  
;;  generates crossed routes
(defun t10 nil
  (tester3 '(:and (:AT-LOC eng1 buffalo) (:AT-LOC eng2 indianapolis) (:AT-LOC eng3 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE)
	     (:delay :snow richmond 4))
	   "Go from buffalo to richmond"
	   "Go from indianapolis to richmond"
	   "OK"))

(defun t10a nil
  (tester3 '(:and (:AT-LOC eng1 buffalo) (:AT-LOC eng2 indianapolis) (:AT-LOC eng3 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE)
	     (:delay :snow pittsburgh 4))
	   "Go from buffalo to charlotte"
	   "Don't go through toledo"
	   "OK"))

;; tests of insteads

;;  (:USE ENG1) for (:USE ENG2)
(defun t11 nil
  (tester3 '(:and (:AT-LOC eng1 buffalo) (:AT-LOC eng2 buffalo) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	   "Take ENG2 to chicago"
	   "No, use ENG1 instead of ENG2"
	   "OK"))

;; This should change the agent to ENG1 and then reject third sentence
(defun t11A nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 atlanta) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	      "Let's go from atlanta to chicago"
	      "Use eng1"
	      "No, use ENG1 instead of ENG2"))

;;  (:VIA A) instead of  (:USE B)
(defun t11b nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	      "Take ENG1 to chicago"
	      "Take ENG2 to buffalo"
	      "No, use ENG1 instead of ENG2"))

(defun t11c nil
  (tester3 '(:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 atlanta) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	      "Take ENG2 to chicago"
	      "Go via pittsburgh instead of indianapolis"
	      "No, use ENG1 instead of ENG2"))

(defun t12 nil
  (tester3  '(:and (:AT-LOC eng1 cleveland) (:AT-LOC eng2 chicago) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	     "I want to go to atlanta and montreal"
	      "Now let's go from cleveland to montreal as quickly as possible"
	       "Now let's go from chicago to montreal"))

(defun tester3 (scenario utt1 utt2 utt3)
  (let*
    ((n1 
      (find-arg-in-act (handle-psm-request (list :NEW-PROBLEM :CONTENT scenario))
                  :PLAN-ID))
     (n2 (run-and-update utt1 n1))
     (n3 (run-and-update utt2 n2)))
    (run-and-update utt3 n3)
    T))




;;  interprets the speech act and updates the history if interpretation is
;;   GOOD or OK. Returns the new focus node.
(defun run-and-update (sentence node-name)
  (format t "~%~%Interpreting ~S" sentence)
  (let* ((acts (dummy-parse sentence))
         ;; This hack sets the node to the root if we have an NEW-SUBPLAN
         (cnode-name (if (eq (caar acts) :NEW-SUBPLAN) *ROOT-NODE-NAME* node-name))
         (res1 (handle-psm-request (append (car acts) 
                                           (list :PLAN-ID cnode-name))))
         (score (find-arg-in-act res1 :recognition-score)))
    (if (member score '(:GOOD :OK))
      (let ((res2 
             (handle-psm-request 
              (list :update-pss :plan-id cnode-name
                    :PS-STATE (find-arg-in-act res1 :ps-state)))))
        (format t "~%PSM state now is:") 
        (print-task-tree (current-pss))
        (find-arg-in-act res2 :PLAN-ID))
      ;; First interp wasn't GOOD or OK, try second if there is one
      (when (cadr acts)
        (let* ((cnode-name (if (eq (caadr acts) :NEW-SUBPLAN) *ROOT-NODE-NAME* node-name))
               (res1 (handle-psm-request (append (cadr acts) (list :PLAN-ID cnode-name))))
               (score (find-arg-in-act res1 :recognition-score)))
          (if (member score '(:GOOD :OK))
            (let ((res2 
                   (handle-psm-request 
                    (list :update-pss :plan-id cnode-name
                          :ps-state (find-arg-in-act res1 :ps-state)))))
              (format t "~%PSM state now is:") 
              (print-task-tree (current-pss))
              (find-arg-in-act res2 :PLAN-ID)))))
      )))
        
        

;;  Here's the dummy parser which allows for better traces

(defun dummy-parse (s)
 (cond
           ((equal s "Let's go from atlanta to chicago") 
            '((:refine :content (:go g1 (:from atlanta) (:to chicago)))
	      (:new-subplan :content (:go g1 (:from atlanta) (:to chicago)))))
	   ((equal s "Let's go from atlanta to chicago via cincinnati") 
            '((:refine :content (:go g1 (:from atlanta) (:to chicago) (:via cincinnati)))
	      (:new-subplan :content (:go g1 (:from atlanta) (:to chicago) (:via cincinnati)))))
           ((equal s "I want to go from atlanta to montreal") 
              '((:NEW-SUBPLAN :content (:go g2 (:from atlanta) (:to montreal)))
		))
	   ((equal s "I want to go from atlanta to montreal the cheapest way possible") 
              '((:NEW-SUBPLAN :content (:go g2 (:from atlanta) (:to montreal)) :preference (<= COST))
		))
	   ((equal s "Go the cheapest way possible")
	    '((:REFINE :content (:GO g3) :preference (<= COST))))
	   
	   ((equal s  "I want to go from pittsburgh to chicago")
              '((:NEW-SUBPLAN :content (:go g2 (:from pittsburgh) (:to chicago)))
		))
	   
	    ((equal s  "I want to go from pittsburgh to chicago in less than 20 hours")
              '((:NEW-SUBPLAN :content (:go g2 (:from pittsburgh) (:to chicago)) :filter ((<= 20) DURATION))
		))
	    ((equal s  "I want to go to atlanta and montreal")
              '((:NEW-SUBPLAN :content (:go g2 (:to atlanta) (:to montreal)))
		))
	    
	   ((equal s "Go via cincinnati") 
            '((:refine :content (:go g3 (:via cincinnati)))))
           ((equal s "Go via pittsburgh") 
            '((:refine :content (:go g4 (:via pittsburgh)))))
           ((equal s "Go via pittsburgh instead of indianapolis") 
            '((:modify :add (:go g5 (:via pittsburgh)) :delete  (:go g6 (:via indianapolis)))))
	   ((equal s "No, pittsburgh instead of indianapolis")
	    '((:modify :add ((:use pittsburgh)) :delete ((:use indianapolis)))))
	   ((equal s "No, albany instead of pittsburgh")
	    '((:modify :add ((:use albany)) :delete ((:use pittsburgh)))))
	     ((equal s "No, albany instead of toronto")
	    '((:modify :add ((:use albany)) :delete ((:use toronto)))))
	   ((equal s "Use eng1")
	    '((:refine :content (:go g51 (:use eng1)))
	      (:modify :add (:go g51 (:use eng1)))))
	    ((equal s "Use eng2")
	    '((:refine :content (:go g51 (:use eng2)))
	      (:modify :add (:go g51 (:use eng2)))))
	   ((equal s "Go to pittsburgh instead") 
            '((:modify :add (:go g6 (:to pittsburgh) nil))))
           ((equal s "Go from pittsburgh instead") 
            '((:modify :add (:go g7 (:from pittsburgh)))))
            ((equal s "Don't go through toledo")
            '((:refine :content (:go g8 (:not (:via toledo))))))
           ((equal s "OK") '((:confirm) (ack)))
           ((equal s "I want to go to Rochester and Sodus") 
            '((:NEW-SUBPLAN :content (:go g9 (:to (& ROCH SODUS))))))
           ((equal s "Now let's go from cleveland to montreal") 
            '((:extend :content (:go g10 (:from cleveland) (:to Montreal)))
              (:NEW-SUBPLAN :content (:go g11 (:from cleveland) (:to Montreal)))))
	    ((equal s "Now let's go from cleveland to montreal as quickly as possible") 
            '((:refine :content (:go g10 (:from cleveland) (:to Montreal) (:preference (<= duration))))
              (:extend :content (:go g11 (:from cleveland) (:to Montreal) (:preference (<= duration))))))
           ((equal s "No, go from cleveland to montreal") 
            '((:modify :add (:go g12 (:from cleveland) (:to Montreal)))))
	    ((equal s "No, go from cleveland to buffalo") 
            '((:modify :add (:go g12 (:from cleveland) (:to Buffalo)))))
	    
           ((equal s "Now let's go from chicago to montreal") 
            '((:extend :content (:go g13 (:from chicago) (:to Montreal)))
              (:NEW-SUBPLAN :content (:go g14 (:from chicago) (:to Montreal)))))
           ((equal s "Go directly from indianapolis to chicago")
            '((:refine :content (:go g15 (:directly (:and (:from indianapolis) (:to chicago)))))
              (:NEW-SUBPLAN :content (:go g16 (:directly (:and (:from indianapolis) (:to chicago)))))))
           ((equal s "Go directly to chicago")
            '((:refine :content (:go g17 (:directly (:to chicago))))))
           ((equal s "Let's go from atlanta to montreal")
            '((:refine :content (:go g18 (:from atlanta) (:to montreal)))
	      (:extend :content (:go g18 (:from atlanta) (:to montreal)))))
           ((equal s "Go to chicago") 
            '((:refine :content (:go g19 (:to chicago)))
              (:modify :add (:go g20 (:to chicago)))
            ))
           ((equal s "Go to montreal") 
            '((:refine :content (:go g21 (:to montreal)))
              (:modify :add (:go g22 (:to Montreal)))
            ))
           ((equal s "No, Go to montreal") 
            '((:modify :add (:go g23 (:to Montreal)))
              ))
	   ((equal s "No") 
            '((:reject-solution))
              )
           ((equal s "Go from cincinnati") 
            '((:refine :content (:go g24 (:from cincinnati)))
              (:modify :add (:go g25 (:from cincinnati)))))
	   
	   ((equal s "Take ENG1 to chicago") 
            '((:refine :content (:go g19 (:agent eng1) (:to chicago)))
              (:modify :add (:go g20 (:agent eng1 (:to chicago))))))
	   ((equal s "Take ENG2 to chicago")
            '((:refine :content (:go g19 (:agent eng2) (:to chicago)))
              (:modify :add (:go g20 (:agent eng2) (:to chicago)))))
	   ((equal s "Take ENG2 to buffalo")
	    '((:refine :content (:go g19 (:agent eng2) (:to buffalo)))
	      (:new-subplan :content (:go g19 (:agent eng2) (:to buffalo)))))
	    ((equal s  "No, use ENG1 instead of ENG2")
	     '((:modify :add (:go g11 (:use ENG1)) :delete (:go g11(:use ENG2)))))
	    ((equal s "I want to go to Chicago")
	     '((:new-subplan :content (:go g22 (:to Chicago)))))
	    ((equal s "I want to go to Montreal")
	     '((:new-subplan :content (:go g23 (:to Montreal)))))   
	    ((equal s "Go from buffalo to charlotte")
	     '((:new-subplan :content (:go g22 (:from buffalo) (:to charlotte)))
	       (:extend content (:go g22 (:from buffalo) (:to charlotte)))))
	     ((equal s "Go from buffalo to richmond")
	     '((:new-subplan :content (:go g22 (:from buffalo) (:to richmond)))
	       (:extend content (:go g22 (:from buffalo) (:to richmond)))))
	    ((equal s "Go from indianapolis to richmond")
	     '((:new-subplan :content (:go g22 (:from indianapolis) (:to richmond)))
	       (:new-subplan :content (:go g22 (:from indianapolis) (:to richmond)))))
	    ((equal s "Cancel the route from toronto to montreal")
	     '((:cancel :content (:object (:route  g23 (:and (:from Toronto) (:to Montreal)))))))
	     ((equal s "Cancel the route from atlanta to chicago")
	     '((:cancel :content (:object (:route  g23 (:and (:from Atlanta) (:to chicago)))))))
	    ((equal s "Cancel the goal of going to chicago")
	     '((:cancel :content (:goal (:go  g23 (:to chicago))))))
           (t (format t "~%ERROR: sentence not parsed: ~S" s))
	   	   
           ))

(defun test-all nil
  (t1)
  (t1A)
  (t1B)
  (t2)
  (t3a)
  (t3b)
  (t3c)
  (t3d)
  (t4)
  (t5)
  (t5a)
  (t6)
  (t7)
  (t8)
  (t9)
  (T9a)
  (t10)
  (t10a)
  (t11)
  (t11a)
  (t11b)
  (t11c)
)

;;  HERE STARTS THE MORE DETAILED TESTING CODE THAT WRITES OUR TEST FILES

;; Basic goal introduction, further specification and confirmation
(setq t1 '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE)
	     (:DELAY :WIND columbus 5))
           "I want to go from atlanta to montreal"
           "Go via cincinnati"
           "OK"))

(setq t1a '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE)
	     (:DELAY :WIND columbus 5))
           "I want to go from atlanta to montreal the cheapest way possible"
           "Go via cincinnati"
           "OK"))

(setq t1b  '((:and (:AT-LOC eng1 pittsburgh) (:AT-LOC eng2 albany) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE))
           "I want to go from pittsburgh to chicago in less than 20 hours"
	   "Go the cheapest way possible"
	   "Go via cincinnati"))

;; Modification to a longer route, then a route extension.
(setq t2 '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE))
           "Let's go from atlanta to chicago"
           "Go via pittsburgh"
           "Now let's go from chicago to montreal"))
     
;; monotonic INSTEAD correction, topic shift

(setq t3 '((:and (:AT-LOC eng1 atlanta) (:AT-loc eng2 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE))
           "Let's go from atlanta to chicago"
           "Go via pittsburgh instead of indianapolis"
           "Now let's go from cleveland to montreal as quickly as possible"))

;; relation not identified in correction

(setq t3a '((:and (:AT-LOC eng1 atlanta) (:at-loc eng2 atlanta) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE))
           "Let's go from atlanta to chicago"
	   "Use eng1"
           "No, pittsburgh instead of indianapolis"
         ))

(setq t3b '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE))
           "I want to go from atlanta to montreal"
           "Go via cincinnati"
	   "No, albany instead of toronto"))

(setq t3c '((:and (:AT-LOC eng1 pittsburgh) (:AT-LOC eng2 albany) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE))
           "I want to go from pittsburgh to chicago"
	   "No, albany instead of pittsburgh"
	   "OK"))
  

(setq t3d '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE))
           "I want to go from atlanta to montreal"
           "Go via cincinnati"
	   "No"))

(setq t4 '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE))
           "Let's go from atlanta to chicago"
           "Go directly from indianapolis to chicago"
           "Now let's go from chicago to montreal"))

(setq t5 '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago)  (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE))
	    "Let's go from atlanta to chicago"
	    "No, Go to montreal"
	    "Go via pittsburgh"))

;; tests multiple reasons
(setq t5a '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago)  (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE))
	    "Let's go from atlanta to chicago"
	    "Go to montreal"
	    "Go via pittsburgh"))


(setq t6 '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 cincinnati) (:AT-LOC eng3 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE)
	     (:delay :wind montreal 5) (:delay :snow chicago 3))
	    "Let's go from atlanta to chicago"
	    "Go from cincinnati"
	   "Now let's go from cleveland to montreal"))

(setq t6a '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 cincinnati) (:AT-LOC eng3 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE)
	     (:delay :wind montreal 5) (:delay :snow chicago 3))
	    "Let's go from atlanta to chicago via cincinnati"
	    "Now let's go from cleveland to montreal"
	    "Cancel the route from toronto to montreal"))

(setq t6b '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 cincinnati) (:AT-LOC eng3 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE)
	     (:delay :wind montreal 5) (:delay :snow chicago 3))
	    "Let's go from atlanta to chicago via cincinnati"
	    "Now let's go from cleveland to montreal"
	    "Cancel the route from atlanta to chicago"))

(setq t6c '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 cincinnati) (:AT-LOC eng3 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE)
	     (:delay :wind montreal 5) (:delay :snow chicago 3))
	   "Now let's go from cleveland to montreal"
	   "Let's go from atlanta to chicago via cincinnati"
	   "Cancel the route from atlanta to chicago"))

(setq t6d '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 cincinnati) (:AT-LOC eng3 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE)
	     (:delay :wind montreal 5) (:delay :snow chicago 3))
	   "Now let's go from cleveland to montreal"
	   "Let's go from atlanta to chicago via cincinnati"
	   "Cancel the goal of going to chicago"))

(setq t7 '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 cincinnati) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	     "Go to chicago"
	    "Go from cincinnati"
	    "Go directly to chicago"))
;; changing plans using a new agent
(setq t8 '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 cincinnati) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	     "Take ENG1 to chicago"
	    "Go from cincinnati"
	    "Take ENG2 to chicago"))

;; Testing introduce of two goals and then refining t9 should be :GOOD, T9A :OK
(setq t9 '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	   "I want to go to Chicago"
	   "I want to go to Montreal"
	   "Let's go from atlanta to chicago"))
	
(setq t9a '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	   "I want to go to Montreal"
	   "I want to go to Chicago"
	   "Let's go from atlanta to chicago"))
	  
;;  generates crossed routes
(setq t10 '((:and (:AT-LOC eng1 buffalo) (:AT-LOC eng2 indianapolis) (:AT-LOC eng3 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE)
	     (:delay :snow pittsburgh 4))
	   "Go from buffalo to charlotte"
	   "Go from indianapolis to richmond"
	   "OK"))

(setq t10a '((:and (:AT-LOC eng1 buffalo) (:AT-LOC eng2 indianapolis) (:AT-LOC eng3 cleveland) (:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE)
	     (:delay :snow pittsburgh 4))
	   "Go from buffalo to charlotte"
	   "Don't go through toledo"
	   "OK"))

;; tests of insteads

;;  (:USE ENG1) for (:USE ENG2)
(setq t11 '((:and (:AT-LOC eng1 buffalo) (:AT-LOC eng2 buffalo) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	   "Take ENG2 to chicago"
	   "No, use ENG1 instead of ENG2"
	   "OK"))

;; This should change the agent to ENG1 and then reject third sentence
(setq t11a '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 atlanta) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	      "Let's go from atlanta to chicago"
	      "Use eng1"
	      "No, use ENG1 instead of ENG2"))

;;  (:VIA A) instead of  (:USE B)

(setq t11b '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 chicago) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	      "Take ENG1 to chicago"
	      "Take ENG2 to buffalo"
	      "No, use ENG1 instead of ENG2"))

(setq t11c '((:and (:AT-LOC eng1 atlanta) (:AT-LOC eng2 atlanta) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	      "Take ENG2 to chicago"
	      "Go via pittsburgh instead of indianapolis"
	      "No, use ENG1 instead of ENG2"))

(setq t12 '((:and (:AT-LOC eng1 cleveland) (:AT-LOC eng2 chicago) (:AT-LOC eng3 cleveland)(:TYPE eng1 :ENGINE) (:TYPE eng2 :ENGINE) (:TYPE eng3 :ENGINE))
	     "I want to go to atlanta and montreal"
	      "Now let's go from cleveland to montreal as quickly as possible"
	       "Now let's go from chicago to montreal"))


(setq ALL-TESTS (list t1 t1a t1b t2 t3 t3a t3b t3c t3d t4 t5 t5a t6 t6a t6b t6c t6d t7 t8 t9 t9a t10 t10a t11 t11a t11b t11c t12))

    
;;  generate a test history

(defun make-test-dump nil

  (mapc #'(lambda (x) (apply #'gen-results x)) ALL-TESTS)
  (values))


(defun gen-results (scenario utt1 utt2 utt3)
  (let*
    ((init (list :NEW-Scenario :CONTENT 
                 (append scenario (cdr map-description))))

     (n1 
        (find-arg-in-act (handle-psm-request init)
                         :PLAN-ID)))
    (format t "~%~%(test-session '~S '~S~%'(" scenario N1)
    (let*
      ((n2 (generate-test-call utt1 n1))
       (n3 (generate-test-call utt2 n2)))
      (generate-test-call utt3 n3)
      (Format t "~%))")
      T)))

(defun generate-test-call (sentence node-name)
  (let* ((acts (dummy-parse sentence))
         ;; This hack sets the node to the root if we have an NEW-SUBPLAN
         (cnode-name (if (eq (caar acts) :NEW-SUBPLAN) *ROOT-NODE-NAME* node-name))
         (request (append (car acts) (list :PLAN-ID cnode-name)))
         (res1 (handle-psm-request request))
         (score (find-arg-in-act res1 :recognition-score)))
    (format t "~%~%~S~%~S~%~S" sentence request res1) 
    (if (member score '(:GOOD :OK))
      (let* ((update  (list :update-pss :plan-id cnode-name
                    :PS-STATE (find-arg-in-act res1 :ps-state)))
            (res2 
             (handle-psm-request update)))
        (format t "~%~%~S~%~S~%~S" "" update res2)   
        (find-arg-in-act res2 :PLAN-ID))
      ;; First interp wasn't GOOD or OK, try second if there is one
      (when (cadr acts)
        (let* ((cnode-name (if (eq (caadr acts) :NEW-SUBPLAN) *ROOT-NODE-NAME* node-name))
               (request2 (append (cadr acts) (list :PLAN-ID cnode-name)))
               (res1 (handle-psm-request request2))
               (score (find-arg-in-act res1 :recognition-score)))
          (format t "~%~%~S~%~S~%~S" sentence request2 res1)
          
          (if (member score '(:GOOD :OK))
            (let* ((update (list :update-pss :plan-id cnode-name
                          :ps-state (find-arg-in-act res1 :ps-state)))
                   (res2 
                   (handle-psm-request update)))
               (format t "~%~%~S~%~S~%~S" "" update res2)))
              
      )))))

;; DETAILED TESTING

(defun test-session (scenario old-plan-id data)
  (let
    ((plan-id (find-arg-in-act
                  (handle-psm-request (list :NEW-Scenario :CONTENT 
                                                 (append scenario (cdr map-description))))
                  :PLAN-ID)))
    (test-each-interaction data (list (cons old-plan-id plan-id)))))

(defun test-each-interaction (data symbol-table)
(format t ".")
  (if (null data)
    T
    (let* ((sentence (car data))
          (call (second data))
          (ans (third data))
          (new-ans (handle-psm-request (replace-plan-id-and-ps-state call symbol-table)))
          (match-result (match-answer ans new-ans)))
      (if match-result
        (test-each-interaction (cdddr data) (append match-result symbol-table))
        (let nil
          (Format t "Failure was on ~S" sentence))))))
          
    
(defun replace-plan-id-and-ps-state (call st)
  (cons (car call) (replace-vals (cdr call) st)))

(defun replace-vals (args st)
  (when args
    (cons (car args)
          (cons
           (if (member (car args) '(:ps-state :plan-id))
             (cdr (assoc (cadr args) st))
             (cadr args))
           (replace-vals (cddr args) st)))))

;;  CODE FOR MATCHING ANSWERS

(defun match-answer (ref answer)
  (match-ans (cdr ref) (cdr answer) nil nil))

(defun match-ans (ref ans plan-id-pair ps-state-pair)
  (if (and (null ref) (null ans))
    (if plan-id-pair
      (if ps-state-pair
        (list plan-id-pair ps-state-pair)
        (list plan-id-pair))
      (list ps-state-pair))
        
    (case (car ref)
      (:PLAN-ID
       (if (null plan-id-pair)
         (match-ans (cddr ref) (cddr ans) (cons (cadr ref) (cadr ans)) ps-state-pair)
         (if (and (eq (cadr ref) (car plan-id-pair))
                  (eq (cadr ans) (cdr plan-id-pair)))
           (match-ans ref ans plan-id-pair ps-state-pair)
           (let nil
             (format t "~% Mismatch on ~S value: ~S vs ~S" (car ref) (cadr ref) (cadr ans))
             NIL))))
      
      (:PS-STATE
       (if (null ps-state-pair)
         (match-ans (cddr ref) (cddr ans) plan-id-pair (cons (cadr ref) (cadr ans)))
         (if (and (eq (cadr ref) (car ps-state-pair))
                  (eq (cadr ans) (cdr ps-state-pair)))
           (match-ans (cddr ref) (cddr ans) plan-id-pair ps-state-pair)
           (let nil
             (format t "~% Mismatch on ~S value: ~S vs ~S" (car ref) (cadr ref) (cadr ans))
             NIL))))
      
      ((:PLAN :RESULT)
       (if (match-ans (cdadr ref) (cdadr ans) plan-id-pair ps-state-pair)
         (match-ans (cddr ref) (cddr ans) plan-id-pair ps-state-pair)
         (let nil
           (format t "~% Mismatch on ~S value: ~S vs ~S" (car ref) (cadr ref) (cadr ans))
           NIL)))
      
      (:OBJECTS
       (and (every #'(lambda (x) (member x (cadr ref))) (cadr ans))
	    (every #'(lambda (x) (member x (cadr ans))) (cadr ref))))

      (:GOAL
       (if (match-action (cadr ref) (cadr ans))
           (match-ans (cddr ref) (cddr ans) plan-id-pair ps-state-pair)
           (let nil
           (format t "~% Mismatch on ~S value: ~S vs ~S" (car ref) (cadr ref) (cadr ans))
           NIL)))

      (:ACTIONS
       (if (every #'match-action (cadr ref) (cadr ans))
          (match-ans (cddr ref) (cddr ans) plan-id-pair ps-state-pair)
           (let nil
           (format t "~% Mismatch on ~S value: ~S vs ~S" (car ref) (cadr ref) (cadr ans))
           NIL)))

      
      (otherwise
       (if (equal (cadr ref) (cadr ans))
         (match-ans (cddr ref) (cddr ans) plan-id-pair ps-state-pair)
         (let nil
           (format t "~% Mismatch on ~S value: ~S vs ~S" (car ref) (cadr ref) (cadr ans))
           NIL)))
      )))

(defun match-action (ref new)
  "ignore id when matching actions"
  (or (and (eq (car ref) :and) 
           (eq (car new) :and)
           (every #'match-action (cdr ref) (cdr new)))
      (and (eq (car ref) (car new))
           (equal (cddr ref) (cddr new)))))
        
