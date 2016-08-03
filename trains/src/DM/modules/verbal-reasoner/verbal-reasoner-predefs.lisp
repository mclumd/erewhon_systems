;; Time-stamp: <Mon Jan 13 17:22:50 EST 1997 ferguson>

(when (not (find-package :verbal-reasoner))
  (load "verbal-reasoner-def"))
(in-package verbal-reasoner)

(defmacro build-simple-pred (name)
  (let ((pred-name (intern (format nil "~A-P" name)))
        (setter (intern (format nil "SET-~A" name)))
        (resetter (intern (format nil "CLEAR-~A" name))))
    `(let (,name)
       (defun ,pred-name ()
         ,name)
       (defun ,setter ()
         (setq ,name t))
       (defun ,resetter ()
         (setq ,name nil)))))

(defmacro build-stack-pred (name &optional (push-fn 'push))
  (let ((pred-name (intern (format nil "~A-P" name)))
        (setter (intern (format nil "SET-~A" name)))
        (resetter (intern (format nil "CLEAR-~A" name)))
        (pusher (intern (format nil "PUSH-~A" name)))
        (popper (intern (format nil "POP-~A" name)))
        (ppopper (intern (format nil "POP-ALL-~A" name)))
        (getter (intern (format nil "GET-~A" name)))
        (arg (gensym)))
    `(let (,name)
       (defun ,getter ()
         ,name)
       (defun ,pred-name ()
         ,name)
       (defun ,setter (,arg)
         (setq ,name ,arg))
       (defun ,pusher (,arg)
         ,(if (eq push-fn 'pushnew)
              `(pushnew ,arg ,name :test #'equal)
            `(,push-fn ,arg ,name)))
       (defun ,popper ()
         (pop ,name))
       (defun ,resetter ()
         (setq ,name nil))
       (defun ,ppopper ()
         (prog1 (,getter)
           (,resetter))))))



(defmacro build-value-pred (name)
  (let ((pred-name (intern (format nil "~A-P" name)))
        (setter (intern (format nil "SET-~A" name)))
        (resetter (intern (format nil "CLEAR-~A" name)))
        (popper (intern (format nil "POP-~A" name)))
        (getter (intern (format nil "GET-~A" name)))
        (arg (gensym)))
    `(let (,name)
       (defun ,getter ()
         ,name)
       (defun ,pred-name ()
         ,name)
       (defun ,setter (,arg)
         (debug-log :prince :prince "setting ~A to ~S" ',name ,arg)
         (setq ,name ,arg))
       (defun ,resetter ()
         (setq ,name nil))
       (defun ,popper ()
         (prog1 (,getter)
           (,resetter))))))

(defmacro build-commitment-pair (proposal committal &optional (proposal-pusher 'push))
  (let ((commit-name (intern (format nil "COMMIT-~A" proposal)))
        (pgetter (intern (format nil "GET-~A" proposal)))
        (cgetter (intern (format nil "GET-~A" committal)))
        (setter (intern (format nil "SET-~A" committal)))
        (resetter (intern (format nil "CLEAR-~A" proposal))))
    `(progn (build-stack-pred ,proposal ,proposal-pusher)
            (build-stack-pred ,committal)
            (defun ,commit-name (&optional reason)
              (debug-log :prince :prince "Committing output: ~S, plan: ~S, ps-state: ~S (~A)" 
                         (,pgetter) (get-plan) (get-ps-state) reason)
              
              (,setter (nconc (,pgetter) (,cgetter)))
              (,resetter)))))

