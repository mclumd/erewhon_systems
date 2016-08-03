;;;
;;; display-parser.lisp: the process that gets the output fron the system
;;;                 and decides how to handle it.
;;;
;; Time-stamp: <Mon Jan 13 17:29:07 EST 1997 ferguson>

(when (not (find-package :display-parser))
  (load "display-parser-def"))
(in-package :display-parser)

(eval-when (load eval)
  (add-initialization "Register :display-manager"
                      '(register :display-manager #'display-parser::parse-display-commands)
                      () 'kqml::*register-initializations*))

(defun parse-display-commands (input)
  ;; input is a generic message
  (debug-log :display-manager :display-manager "Command: ~W" input)
  (if (and (eq (sender input) 'hack::speech-out)
           (consp (content input))
           (eq (car (content input)) 'hack::done)) ; an uncaught speech done, ignore it.
      (return-from parse-display-commands nil))
  (let (meta-record
        actions
        uncommitted-update-p
        highlights
        unhighlights)
    (labels ((add-actions (l)
               (mapc #'(lambda (x)
                         (push (create-request :display x) actions))
                     l))
             (display-update ()
               (setq uncommitted-update-p t))
             (commit-update (&optional force-p)
               #|| (if (and (not (eql (car (content (car actions))) 'hack::refresh))
                            n(or uncommitted-update-p 
                                 force-p))
                       (push (create-request :display '( hack::refresh)) actions)) ||#
               )
             (subparser (act-name act-args)
               (case act-name
                 ( :restart
                   (add-actions (kb-request-kqml (create-request :display-kb
                                                                 `(,(fix-pkg act-name) ,@act-args))))
                   (push '(:restart) meta-record))
                 
                 ( :clear
                   (add-actions (kb-request-kqml (create-request :display-kb
                                                                `(,(fix-pkg act-name) ,@act-args))))
                   (push '(:clear) meta-record))
                 
                 ( :exit
                   (push '(:exit) meta-record)
                   (push (create-request :display '(hack::exit)) actions))
                 
                 ( :and
                  ;; handle message parts
                  (mapc #'(lambda (x) (subparser (car x) (cdr x))) act-args))
                 
                 ( :SAY
                  (push (cons :say act-args) meta-record)
                  (commit-update)
                  (push (create-request :display `(,(fix-pkg act-name) ,@act-args))
                        actions))              ; reverse speech .
                 
                 ( :dialogue-box
                   (display-update)
                   (push (cons :confirm act-args) meta-record)
                   (push (create-request :display `( hack::confirm ,@act-args)) actions))
                 
                 ( :highlight
                   (display-update)
                   (if (eq (car act-args) :mentioned)
                       (pushnew (list :highlight :mentioned :objects) meta-record :test #'equalp)
                     (push (list :highlight (car act-args) (object-name (cadr act-args))) meta-record))
                   (mapc #'(lambda (x)
                             (push (create-request :display x) highlights))
                         (kb-request-kqml (create-request :display-kb `(,act-name ,@act-args)))))
                 
                 ( :unhighlight
                   (display-update)
                   (if (eq (car act-args) :mentioned)
                       (pushnew (list :unhighlight :mentioned :objects) meta-record :test #'equalp)
                     (push (list :unhighlight (car act-args) (object-name (cadr act-args))) meta-record))
                   (mapc #'(lambda (x)
                             (push (create-request :display x) unhighlights))
                         (kb-request-kqml (create-request :display-kb `(,act-name ,@act-args)))))
                 
                 (( :ZOOM-IN :ZOOM-OUT :FOCUS :color-engine)
                  (display-update)
                  (push (list act-name (object-name (car act-args)) (cadr act-args)) meta-record)
                  ;; essentially database actions, may want to echo to X interface.
                  (add-actions (kb-request-kqml (create-request :display-kb `(,act-name ,@act-args)))))
                 
                 (( :draw-arrow :erase-arrow :show :unshow :define-route)
                  (display-update)
                  (if (eq act-name :define-route)
                      (push (list :define-route :for-engine (object-name (car act-args))
                                  :color (cadr act-args) 
                                  :from (display-kb::dkb-object-name (fourth act-args))
                                  :to (display-kb::dkb-object-name (fifth act-args)))
                            meta-record)
                    (push (delete nil
                                  (list act-name (object-name (car act-args)) (object-name (cadr act-args))))
                          meta-record))
                  (add-actions (kb-request-kqml (create-request :display-kb `(,act-name ,@act-args)))))
                 )))
      (subparser (car (content input)) (cdr (content input)))
      ;; make sure unhighlights come before highlights.
      ;; if the last action isn't a refresh, add one for good measure.
      (commit-update t)
      ;; tell the logger the meta-actions
      (mapc #'(lambda (x)
                (hack::send-to-log (format nil "dsp~(~{ ~A~}~)." x)))
            (nreverse meta-record))
      (mapc #'hack:handle-kqml unhighlights)
      (mapc #'hack:handle-kqml highlights)
      (let ((deferred-actions nil)
            gonna-exit)
        (mapc #'(lambda (x)
                  (cond
                   ((eq (car (content x)) 'hack::say)
                    ;; handle specially, until we make a coordination module.
                    (push x deferred-actions)) ; hack
                   ((eq (car (content x)) 'hack::exit)
                    (setq gonna-exit t))   ; score instead of exiting display.
                   (t
                    (hack:handle-kqml x))))
              (nreverse actions))
        (if actions
            (hack:handle-kqml (create-request :display '( hack::refresh)))) ; force refresh of display
        ;; temporary hack to force speech last
        (mapc #'hack:handle-speech-kqml (nreverse deferred-actions))
        (if gonna-exit
            (hack::do-score))))))

