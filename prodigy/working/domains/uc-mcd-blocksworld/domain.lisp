;;; A translation of the UCPOP mcd-blocksworld into prodigy 4.0
;;; syntax, for comparison. 
;;; Jim Blythe, 4/4/93

(create-problem-space 'uc-mcd-blocksworld :current t)

(ptype-of Block :top-type)

(pinstance-of Table Block)

 (OPERATOR 
 puton
 (params <X> <Y> <D>)
 (preconds
  ((<X> (and Block (not-table <X>)))
   (<Y> (and Block (diff <X> <Y>)))
   (<D> (and Block (diff <Y> <D>))))
  (and (on <X> <D>)
       (forall ((<B> Block)) (~ (on <B> <X>)))
       (or (is-table <Y>)
	   (forall ((<B> Block)) (~ (on <B> <Y>))))))
 (effects
  ()
  ((add (on <X> <Y>))
   (del (on <X> <D>))
   (del (above <X> <Y>))
   (forall ((<C> Block))
	   (above <Y> <C>)
	   ((add (above <X> <C>))))
   (forall ((<E> (and Block (diff <Y> <E>))))
	   (and (above <X> <E>) (~ (above <Y> <E>)))
	   ((del (above <X> <E>)))))))

(defun not-table (obj)
  (not (eq (p4::prodigy-object-name obj) 'table)))
