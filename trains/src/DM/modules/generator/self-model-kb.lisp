;; Time-stamp: <Mon Jan 13 17:18:09 EST 1997 ferguson>

(when (not (find-package :self-model-kb))
  (load "self-model-kb-def"))
(in-package :self-model-kb)

(eval-when (load eval)
  (add-initialization "Register :self-model-kb"
                      '(register :self-model-kb #'process-self-model-kb-request)
                      () 'kqml::*register-initializations*))

(defparameter *annoyance-base* 5 "bad exchanges before we get annoyed.")
(defparameter *irritated-base* 10 "not just annoyed, but irritated.")
(defparameter *mad-base* 20 "I'm mad as hell, and I'm not going to take it anymore!")
(defparameter *glad-base* -5 "good exchanges before we get glad.")
(defparameter *happy-base* -10 "Not just glad, but really happy.")
(defparameter *ecstatic-base* -20 "I'd rather be talking to this winning user than anyone else on the planet!")

(defun init-self-model-kb ()
  (simple-clear)
  (simple-replace :greeting-level 0)
  (simple-replace :frustration-level 0))

(defun process-self-model-kb-request (input)
  (let ((command  (first (content input)))
        (arg1 (second (content input)))
        (arg2 (third (content input))))
    (create-reply (ecase command
                    (:clear
                     (debug-log :self-model-kb :hard " CLEARING self-model-kb ")
                     (init-self-model-kb))
                    ( :new-generation   ; uttering a new set of sentences, clean up prior state as needed.
                      (simple-replace :just-told-about nil)
                      t)
                    (:incf-frustration-level
                     (transcribe-and-log :self-model-kb ";;; self-model: Stupid User!~@[(~A)~]" arg1)
                     (progfoo (1+ (or (simple-find :frustration-level)
                                      0))
                       (simple-replace :frustration-level foo)))
                    (:decf-frustration-level
                     (transcribe-and-log :self-model-kb ";;; self-model: Winning User!~@[(~A)~]" arg1)
                     (progfoo (- (or (simple-find :frustration-level)
                                     0)
                                 1)
                       (simple-replace :frustration-level foo)))
                    (:incf-greeting-level
                     (progfoo (1+ (or (simple-find :greeting-level)
                                      0))
                       (simple-replace :greeting-level foo)))
                    (( :mentioned-objects :greeting-level :frustration-level :just-told-about :root-plan)
                     (simple-find command))
                    (( :set-root-plan)
                     (debug-log :self-model-kb :hard "SETTING ROOT PLAN TO ~S" arg1)
                     (simple-replace :root-plan arg1)
                     nil)
                    (:update-mentioned-objects
                     (simple-add :mentioned-objects arg1)
                     t)
                    (:told-about-p
                     (if arg2
                         (member arg2 (simple-find (told-about arg1)))
                       (member arg1 (simple-find :told-about))))
                    (:tell-about
                     (cond
                      (arg2
                       (simple-add :just-told-about (cons arg1 arg2))
                       (simple-add (told-about arg1) arg2))
                      (t
                       (simple-add :told-about arg1)))
                     t)))))

(defun told-about (arg1)
  "for two-arg told-abouts"
  (intern (format nil ":told-about-~A" (string-downcase (string arg1))) (find-package 'self-model-kb)))



