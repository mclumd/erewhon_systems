;;;; This file contains general-purpose lisp utilities

(in-package :gdp)

;;; This function returns true if the elements of l1 are present in l2, i.e. l1 \subseteq l2.
(defun subset (l1 l2)
  (if (null l1)
    t
    (if (shop2.common::tagged-state-p l2)
      (and (shop2.common::atom-in-state-p (car l1) l2) (subset (cdr l1) l2))
      (and (member (car l1) l2 :test #'equal) (subset (cdr l1) l2)))))

;;; ------ CODE TO RANDOMLY SHUFFLE A LIST ------------

(defun randomize-list (l l-shuffled)
	(if (null l)
		l-shuffled
		(let* ((r (random (length l)))
					 (rth-element (nth r l)))
			(randomize-list (remove-nth r l) (cons rth-element l-shuffled)))))

(defun remove-nth (n l)
	(remove-nth-helper n l 0))

(defun remove-nth-helper (n l i)
	(if (= n i)
		(cdr l)
		(cons (car l) (remove-nth-helper n (cdr l) (+ i 1)))))
	
