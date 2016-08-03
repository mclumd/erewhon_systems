(in-package :shop2)

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
			
