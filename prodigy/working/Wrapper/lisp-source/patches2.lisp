;;;;
;;;; From search.lisp in planner dir.
;;;;


;;; NOTE that the code that constructs the plan to be "told" may
;;; depend on other assumptions that the code here ignores.



;;;
;;; Init condition.
;;;
(setf *dont-ask-and-find-all* nil)




;;; This new function complements the abstractions in the beginning
;;; of search.lisp.
;;;
(defun get-solution ()
  (first *all-solutions*)
  )



;;; The changes here allow non-interactive control of these parameters
;;; under agent control from the KQML code.
;;;
(defun ask-for-more-solutions (&aux
			       request)
  (cond
    (*dont-ask-and-find-all*)
    (t
     
     (tell :content 
	   (get-solutions)) ;This is not going to work.
     (setf request (get-socket-message))
     (extract-answer request)
     )))



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

