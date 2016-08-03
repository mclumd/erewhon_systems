;; Time-stamp: <Mon Jan 13 17:17:10 EST 1997 ferguson>

(when (not (find-package :user-model-kb))
  (load "user-model-kb-def"))
(in-package :user-model-kb)

(eval-when (load eval)
  (add-initialization "Register :user-model-kb"
                      '(register :user-model-kb #'process-user-model-kb-request)
                      () 'kqml::*register-initializations*))

(defun init-user-model-kb ()
  (simple-clear))

(defun process-user-model-kb-request (input)
  (debug-log :user-model-kb :user-model-kb "Command: ~W" input)
  (let ((command (first (content input)))
        (arg1 (second (content input)))
        (arg2 (third (content input)))
        (arg3 (fourth (content input))))
    (progfoo (create-reply (ecase command
                             ( :clear
                               (init-user-model-kb)
                               t)
                             (( :set-engine-focus :set-last-mentioned-paths :set-last-mode :set-last-extension :set-attempted-route)
                              (let ((key (make-keyword (subseq (string command) 4))))
                                (simple-replace key arg1)
                                (simple-find key)))

                             (( :engine-focus :last-mentioned-paths :last-mode :last-extension :attempted-route :avoided-cities)
                              (simple-find command))

                             ( :add-avoided-city
                               (simple-add :avoided-cities arg1)
                               t)
                             ( :remove-avoided-city
                               (simple-subtract :avoided-cities arg1)
                               t)
                    
                             ( :set-reference-pattern
                               (unless (sa-defs:tt-assert arg3 () "bad arg3")
                                 (let ((name (make-keyword arg1)))
                                   (when (eq name :t)
                                     (setq name (make-keyword (format nil "LAST-~A-REFERENCE" arg3)))) ;; couldn't resolve to specific object
                                   (simple-replace name arg2))
                                 t))
                             ( :reference-pattern
                               (simple-find arg1))
                             ))
      (debug-log :user-model-kb :user-model-kb "response: ~W" foo))))


