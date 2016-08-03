;;; A translation of the UCPOP blocksworld domain into prodigy 4.0
;;; syntax, for comparison.
;;; Jim Blythe, 4/4/93

(create-problem-space 'uc-blocksworld :current t)

(ptype-of OBJECT :top-type)

;;; Another way would be to have conditional effects, and have
;;; (is-table) be a static predicate that is always true of table in
;;; the problem.
(pinstance-of Table OBJECT)

(OPERATOR 
 puton
 (params <X> <Y> <Z>)
 (preconds 
  ((<X> Object)
   (<Y> (and Object (diff <X> <Y>)))
   (<Z> (and Object (diff <X> <Z>) (diff <Y> <Z>))))
  (and (on <X> <Z>) (clear <X>) (clear <Y>)))
 ;; The static predicate approach would be a lot cleaner.
 (effects 
  ((<z-not-table> (and Object (eq <Z> <Z-NOT-TABLE>)
		       (not-table <Z-NOT-TABLE>)))
   (<Y-NOT-TABLE> (and Object (eq <Y> <Y-NOT-TABLE>)
		       (not-table <Y-NOT-TABLE>))))
  ((add (on <X> <Y>))
   (del (on <X> <Z>))
   (add (clear <Z-NOT-TABLE>))
   (del (clear <Y-NOT-TABLE>)))
  ))

(defun diff (x y) (not (eq x y)))

(defun not-table (object)
  (not (eq (p4::prodigy-object-name object) 'table)))
