;;Created: Alicia Perez.          Date: nov 16 1992

;;Only one operator. Disks are specified as such in the UCPOP domain,
;;but pegs are not. Pegs are treated as the largest disks.

(create-problem-space 'uc-hanoi :current t)

(ptype-of Peg-or-disk :top-type)
(ptype-of Disk Peg-or-disk)


(operator MOVE-DISK
  (params <disk> <below-disk> <new-below-disk>)
  (preconds
   ((<disk> Disk)
    (<below-disk> (and peg-or-disk (diff <disk> <below-disk>)))
    (<new-below-disk> (and peg-or-disk 
			   (diff <new-below-disk> <disk>)
			   (diff <new-below-disk> <below-disk>))))
   (and (smaller <disk> <new-below-disk>)  ;handles pegs!
	(on <disk> <below-disk>)
	(clear <disk>)
	(clear <new-below-disk>)))
  (effects
   ()
   ((add (clear <below-disk>))
    (add (on <disk> <new-below-disk>))
    (del (on <disk> <below-disk>))
    (del (clear <new-below-disk>)))))

(setf (getf (p4::problem-space-plist *current-problem-space*)
	    :depth-bound) 100)

#|

;;calls to next functions  return the initial state and goal for the
;;specified number of disks.

(defun hanoi-inits (n)
 (let* ((disks (subseq '(d1 d2 d3 d4 d5 d6 d7 d8 d9) 0 n))
	(sizes (nconc (mapcar #'(lambda (d) `(smaller ,d p1)) disks)
		      (mapcar #'(lambda (d) `(smaller ,d p2)) disks)
		      (mapcar #'(lambda (d) `(smaller ,d p3)) disks)
		      (mapcon
		       #'(lambda (d)
			   (mapcar #'(lambda (d2)
				       `(smaller ,(car d) ,d2))
				   (cdr d)))
		       disks)))
	(initial (append '((clear p1)(clear p2)(clear d1))
			 (mapcar #'(lambda (d)
				     `(disk ,d)) disks)
			 (maplist
			  #'(lambda (d)
			      (if (cdr d)
				  `(on ,(car d) ,(cadr d))
				  `(on ,(car d) p3)))
			  disks))))
   (nconc sizes initial)))

(defun hanoi-goal (n)
  (let* ((disks (subseq '(d1 d2 d3 d4 d5 d6 d7 d8 d9) 0 n)))
    (cons :and (maplist #'(lambda (d)
			    (if (cdr d)
				`(on ,(car d) ,(cadr d))
				`(on ,(car d) p1)))
			disks))))

|#
