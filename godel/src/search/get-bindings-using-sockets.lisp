(setf d-file (second (sys:command-line-arguments)))
;(setf p-file (third (sys:command-line-arguments)))

(if (not (>= (sys:command-line-argument-count) 2))
  (progn
    (error "Not enough arguments to alisp. The command should be of the form ~%
           'alisp -# get-bindings.lisp <domain-file>'.")))

(require :asdf)
(asdf:oos 'asdf:compile-op :gdp)
(asdf:oos 'asdf:load-op :gdp)

(compile-file d-file)
(load d-file)

;(compile-file p-file)
;(load p-file)

;(in-package :gdp)
(in-package :shop2)

(defun get-bindings-for-problem (state goal-list)
  (let ((state-obj (apply 'shop2.common:make-initial-state 
			   *domain* 
			   *state-encoding* 
			   (list state)))
	(start-internal-time (get-internal-run-time)))
    ; (format t "original state: ~A ~%~%" (list state))
;    (format t "state obj: ~A ~%" state-obj)
    ; (format t "goal list : ~A ~%" goal-list)

    ; (dolist (g goal-list)
    ;   (add-atom-to-state (list 'goal g) state-obj 0 nil))

    ; (format t "getting the bindings ... ~%" (name my-problem))

    ; (format s "--------------------- ~%")
    ; (format s "Problem : ~A ~%" (name my-problem))

    ; (multiple-value-bind (final-tree plan) (achieve-subtasks state-obj task-list nil)
    (let ((bindings nil)
          (methods (domain-methods *domain*))
          (task-goal (set-difference goal-list (state-atoms state-obj) :test #'equal)))
      ; (format t "task-goal is ~A~%" task-goal)
      ; (format t "methods~%")
      (maphash
        (lambda (key value)
          (setf bindings
                (append bindings (gdp::bindings-of-gdr-achieving-goal nil
                                                                      task-goal 
                                                                      state-obj
                                                                      value))))
        methods)
      ; (dolist (m (domain-methods *domain*))
      ;   (let ((m-groundings (bindings-of-gdr-achieving-goal nil task-goal state-obj m)))
      ;     (append bindings m-groundings)))
      ; (format t "bindings are as follows: ~%")
      ; (format t "~A~%" (length bindings))
      ; (format t "~A~%~%" bindings)
      (let ((bindings-stream (make-string-output-stream)))
        (format bindings-stream "~A~%" (length bindings))
        (dolist (x bindings)
          (format bindings-stream "~{~(~A~)~^ ~}~%" x))
        (format bindings-stream "~A" (/ (float (- (get-internal-run-time) start-internal-time)) internal-time-units-per-second))
        (get-output-stream-string bindings-stream)
        ))))
      ;(dolist (result bindings)
      ;	(dolist (x result)
      ;	  (format t "~(~A~) " x))
      ;	(format t "~%"))

;; now opening up a server here for external code to connect to,
;; send (initial-state, goal) pairs and retrieve bindings 
(require :socket)
;(setf simple-prob-obj (shop2::make-problem "test" (first simple-prob) (second simple-prob)))
;(format t "simple-prob-obj: ~A~%" simple-prob-obj) 

; (compile-file "probs.lisp")
; (load "probs.lisp")
;(format t "state from simple-prob is ~A~%" (first shop2::simple-prob))
;(format t "state from file is ~A~%" (shop2::problem->state *domain* (first shop2::*all-problems*)))
;(format t "testing equality: ~A~%" (equal (shop2::problem->state *domain* (first shop2::*all-problems*)) (list (first sample-prob))))

; (get-bindings-for-problem (first shop2::simple-prob) (second shop2::simple-prob))
;(get-bindings-for-problem (first (shop2::problem->state *domain* simple-prob-obj)) (goal-list-from-problem simple-prob-obj))
;(get-bindings-for-problem (first (shop2::problem->state *domain* (first shop2::*all-problems*))) (goal-list-from-problem (first shop2::*all-problems*)))

(with-open-file (s "lisp_server.out"
		   :direction :output
		   :if-does-not-exist :create
		   :if-exists :supersede)
  (let ((socket (socket:make-socket :connect :passive
				    :type :stream
				    :address-family :file
				    ;				  :local-port 45676)))
				    :local-filename "bindings-socket-file")))
    (format s "opened up socket ~A for connections~%" socket)

    ;; now wait for connections and accept
    (let ((client (socket:accept-connection socket 
					    :wait t)))
      (when client
	;; we've got a new connection from client
	(format s "got a new connection from ~A~%" client)

	;; now wait for data from client
	;      (loop until (listen client) do
	;      (loop until nil do
	;	(format t "first character seen is ~A~%" (peek-char t client))
	(loop for line = (read-line client nil) while line do
	      ;        (if line
	      (format s "line: ~A~%" line)
	      (format s "package: ~A~%" *package*)
	      (in-package :shop2)
	      (setf line-exp (read-from-string line))
	      (format s "line-exp: ~A~%" line-exp)
	      ;(in-package :gdp)
	      (if (not (listp line-exp))
		(format s "line-exp: ~A~%~%" line-exp)
		;; if it comes here, you've got a list
		(progn
		  (format s "state: ~A~%goal: ~A~%" (first line-exp) (second line-exp))
		  (let ((msg (get-bindings-for-problem (first line-exp) (second line-exp))))
		    (format s "msg: ~A~%" msg)
		    (format client "~A~%" msg)
		    (finish-output client))
		  ))

	      ;	(let ((data (read-line client)))
	      ;	(format t "data received: ~A~%" data)
	      )
	(format s "outside loop macro~%")
	)

      (close socket)
      )))
;)
