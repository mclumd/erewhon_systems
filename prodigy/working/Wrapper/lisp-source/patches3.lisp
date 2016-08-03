(in-package :p4)

;;;; From search.lisp in planner dir. 
;;;; 
 
 
;;; NOTE that the code that constructs the plan to be "told" may 
;;; depend on other assumptions that the code here ignores. 
 
 
 
;;; 
;;; Init condition. 
;;; Not necessary because the run function resets each time invoked.
;(setf *dont-ask-and-find-all* nil) 
 
 
 
 
 
;;; The changes here allow non-interactive control of these parameters under
;;; agent control from the KQML code. This is taken from
;;; system/planner/search.lisp
;;; 
(defun ask-for-more-solutions (&aux 
			       request 
			       converted-request 
			       multiple-sols-field-val 
			       ) 
  (user::tell :sender
	      "PRODIGY-Wrapper"
	      :content  
	      (format 
		 nil
		 "~s"
		 (user::gen-file)
		 ))
  (setf  
      *dont-ask-and-find-all* 
    (setf multiple-sols-field-val 
      (extract-m-sols-arg 
       (extract-content-field 
	(rest (setf converted-request 
		(read-from-string  
		 (setf request 
		   (user::get-socket-message t))))))))) 
  ;; Function from kqml.lisp 
  (user::handle-kqml 
   request 
   converted-request 
   t) 
  (format
   t
   "~%ask-for-more-solutions returns ~s~%"
   multiple-sols-field-val)
  multiple-sols-field-val 
  ) 




;;; 
;;; THIS IS NOT CHANGED YET
;;; 
;;; Ask user how to proceed.  This is similar to ask-for-more-solutions(), but
;;; the choices won't allow longer plans to be found.
(defun ask-for-more-solutions-shortest ()
  (cond
   (*dont-ask-and-find-all*)
   (t
    (format t
            "~% Do you want to search for another solution:~%  ~
           0. No more solutions.~%  ~
           1. Only equal length or shorter solutions.~%  ~
           2. Only different solutions of shorter or eq length.~%  ~
           3. Only strictly shorter solutions.~%  ~
           4. Continue searching for all non-longer solutions without asking.~%  ~
           5. Continue searching for non-longer diff solutions without asking.~%~
           >> ")
    (let ((answer (car (read-atoms))))
      (case answer
            (0 (format t  "~% BYE, BYE!!"))
            (1 :shorter)
            (2 :shorter-and-diff)
            (3 :strict-shorter)
            (4 (setf *dont-ask-and-find-all*  :shorter))
            (5 (setf *dont-ask-and-find-all*  :shorter-and-diff))
            (t (break "set answer by hand")))))))


 
 
;;; kqml-body must be the rest of the kqml message read from the socket. 
(defun extract-content-field (kqml-body) 
  (cond ((null kqml-body) 
	 nil) 
	((equal :content 
		(first kqml-body)) 
	 (if (eq 'quote (first (second kqml-body)))
	     (first (rest (second kqml-body)))
	   (second kqml-body)))
	(t 
	 (extract-content-field 
	  (rest  
	   (rest 
	    kqml-body))) 
	 ) 
	) 
  ) 
 
 
;;; Specific to Multi-soln version 
(defun extract-m-sols-arg (content-field) 
  (cond ((null content-field)
	 nil)
	((eq 'quote (first content-field))
	 (extract-m-sols-arg 
	  (rest content-field)))
	((equal :multiple-sols 
		(first content-field)) 
	 (second content-field))
	(t 
	 (extract-m-sols-arg 
	  (rest  
	   (rest content-field)))) 
	)   
  )
 
 
 
;;; THIS IS NOT MODIFIED FROM SEARCH.LISP. 
(defun run-multiple-sols (start-node depth-bound) 
  (do* ((result (main-search start-node start-node 2 depth-bound)) 
	(plan (prepare-plan result) 
	      (prepare-plan result)) 
	answer) 
       (nil) 
       (cond 
        ((and plan			;only new solutions wanted 
              (and (or (eq answer :different) 
                       (eq answer :shorter-and-diff)) 
                   (repeated-solution-p plan))) 
         (setf result (call-main-search plan answer depth-bound))) 
 
        ;;if plan is null it means that no sol was found  
        ((null plan)  
         (format t "~%No solution found ~A.~%" result) 
         (store-solution result) 
         (return result))			;terminate	    
 
        (t ; Print the plan nicely and store it 
         (announce-plan plan) 
         (store-solution plan) 
         ;;and search some more if required 
         (setf answer (ask-for-more-solutions)) 
         (cond 
          (answer 
           (setf result (call-main-search plan answer depth-bound)) 
           (if (null result) 
               ;;found all solutions: note that :termination-reason 
               ;;will be the termination-reason of the last path, which 
               ;;is a failure even when other solutions have been 
               ;;found. (You can distinguish that case by checking 
               ;;*all-solutions*) Is this the behaviour we want? 
               (return))) 
          (t ;;problem was solved, but no more solutions are needed 
           (return plan)))))))		;terminate 
 