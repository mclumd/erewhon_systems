

(defmacro gtype-of (new-type-name old-type-name)
  `(progn
     (setf (get (quote ,new-type-name) 'parent) 
       (quote ,old-type-name))
     (setf (get (quote ,old-type-name) 'children)
       (cons (quote ,new-type-name)
	     (get (quote ,old-type-name) 'children))))
  )

