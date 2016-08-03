(setf *always-remove-p* t)
(load "/afs/cs/project/prodigy-1/khaigh/src/merge-static")
(setf *world-path* "/afs/cs/project/prodigy-1/khaigh/domains/")
(load "/afs/cs/project/prodigy-1/khaigh/src/print-rules")
(if (and (boundp '*use-small-database*)
	 *use-small-database*)
    (load "/afs/cs/project/prodigy-1/khaigh/domains/map/probs/static-files-small.lisp")
  (load "/afs/cs/project/prodigy-1/khaigh/domains/map/probs/static-files-medium.lisp"))

(setf *loaded-analogy* t
      *use-small-database* t
      *mei-testing* nil
      *analogical-replay* t)
;(setf *use-apply-op-rules-for-analogy* t)

;(load "/afs/cs/project/prodigy-aperez/codep4/replay/run-same-objects2.lisp")

(when (or (not (boundp '*loaded-analogy*))
	  (not *loaded-analogy*))
	  
  (load "/afs/cs/project/prodigy-1/khaigh/src/setup-analogy")
  (setf *loaded-analogy* t)
;  (setf *analogical-replay* t)
;  (init-guiding);; if you run without any cases, *guiding-case* isn't set, so you need this call
  ;; also, if no cases, set *analogical-replay* to nil.

(defun get-non-static-objects (problem)
  (intersection (p4::problem-objects (current-problem))
		'(person)
		:test #'(lambda (x y)
			  (eq (car (last x)) y))))

)
			
(defun load-analogy (&optional (prob (p4::problem-name (current-problem))))
  (domain 'map)
  (problem prob)

  (manual-retrieval)
  (load-cases)
  
  (setf *merge-mode* 'saba)
  (setf *talk-case-p* t)
  (pset :print-alts t)
  (pset :depth-bound 50)
  (pset :output-level 3)
  (init-guiding)
)

(defun init-map-guiding ()
  (fresh-start-vars)
  (if (not (string= (guiding-case-name (car *guiding-cases*))
		    "case-p4"))
      (setf *guiding-cases* (reverse *guiding-cases*)))
  ;; this is for case 2 & 4, problem 5
  (chop-case (car *guiding-cases*) 5 26)
  (chop-case (second *guiding-cases*) 8 74)
  (setf *guiding-case* (car *guiding-cases*))
  nil)

(defun segments-in-solution (solution-path)
  (let ((segments nil))
    (setf segments (cons (third (p4::instantiated-op-values (car solution-path)))
			 segments))
    (dolist (instop solution-path)
      (setf segments (cons (second (p4::instantiated-op-values instop))
			   segments)))
    (reverse segments)))

(defun intersections-in-solution (segments)
  (let ((intersections nil))
    (dotimes (i (- (length segments) 1))
      (setf intersections
	    (cons
	     (cdr (caar (intersection
			 (known `(segment-intersection-match <i> ,(nth i segments)))
			 (known `(segment-intersection-match <i> ,(nth (+ i 1) segments)))
			 :test #'equal)))
	     intersections)))
    (reverse intersections)))
(defun find-intersection-coordinates (intersections)
  (let ((coords nil)
	(all-coords nil))
    (dolist (intersection intersections)
      (setf coords (car (known `(intersection-coordinates ,intersection <x> <y>))))
      (setf all-coords
	    (cons (list (cdr (assoc '<x> coords))
			(cdr (assoc '<y> coords)))
		  all-coords)))
    (reverse all-coords)))

(defun save-coords-and-nodes
  (&optional
   (case-name (concatenate 'string 
			   "case-"
			   (string-downcase (symbol-name
					     (p4::problem-name
					      (current-problem)))))))
				
  (let* ((filename (concatenate 'string *problem-path*
				"probs/cases/coordinates/"
				case-name ".lisp"))
	 (solution-path (prodigy-result-solution *prodigy-result*))
	 (segments (segments-in-solution solution-path))
	 (intersections (intersections-in-solution segments))
	 (int-coords (find-intersection-coordinates intersections))

	 )
    (with-open-file
     (ofile filename :direction :output
	    :if-exists :rename-and-delete
	    :if-does-not-exist :create)
					;    (format t "~%~S" segments )
					;    (format t "~%~S" intersections )
     (when (and (problem-space-property :*output-level*)
		(>= (problem-space-property :*output-level*) 2))
       (format t "~% Storing coordinates in file: ~S" filename))
     (dotimes (i (length solution-path))
       (let* ((op (nth i solution-path))
	      (intersection (nth i intersections))
	      (coords (nth i int-coords))
	      (node (p4::nexus-parent (p4::nexus-parent (p4::instantiated-op-binding-node-back-pointer op))))
	      )
	 (format ofile "(~S,~S)  ~S~%"
		 (car coords)
		 (second coords)
		 (p4::nexus-name node))
	 ))
     (format t "~%./add-case pslfile ~s  2 ~S.0 ~S.0 ~S.0 ~S.0"
	     (concatenate 'string *problem-path* "probs/cases/" case-name ".lisp")
	     (first (car int-coords))
	     (second (car int-coords))
	     (first (car (last int-coords)))
	     (second (car (last int-coords))))
     )
    (when (boundp 'insts-to-vars)
      (with-open-file
       (ofile (concatenate 'string *problem-path* "probs/cases/vars/" case-name ".lisp")
	      :direction :output
	      :if-exists :rename-and-delete
	      :if-does-not-exist :create)
       (when (and (problem-space-property :*output-level*)
		  (>= (problem-space-property :*output-level*) 2))
	 (format t "~% Storing vars: ~S" insts-to-vars))
       (format ofile "~%(setf insts-to-vars '( ~S" insts-to-vars)
       (format ofile "~%))~%")))
    ))
#|
(setf solutions nil)(dolist (p '(p2 p3 p4))
  (problem p)
  (run :depth-bound db :output-level 0)
  (setf solutions
	(cons *prodigy-result* solutions))
  (save-coords-and-nodes)
  (store-case)
  
)

|#

(setf *replay-cases*
      '(("case-p7" "case-p7" ((at-segment jane 15)) ((<person11> . jane)))
	("case-p6" "case-p6" ((at-segment jane 15)) ((<person59> . jane)))))


