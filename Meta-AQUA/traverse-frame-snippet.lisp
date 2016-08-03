(f.traverse-frame
	  test-token
	  #'(lambda (each-node parent role facet-name level target)
	      (if (isa-p 'state each-node)
		  (format t "~%~%~%For the state frame ~s:"
			  each-node)
		(format t "~%~%~%For the frame ~s:"
			each-node))
	      (if (null parent)
		  (format t "~%")
		  (format t "~% (Which is in the ~s slot of frame ~s)~%"
			  role
			  parent))
	      (if (literal-p each-node)
		  (format t "~%The value of the literal is ~s."
			  (*FRAME* each-node))
		  (dolist (each-role (f.role-list each-node))
		    (dolist (each-facet-name (f.facet-list each-node each-role))
		      (format t "~%The ~s facet of the ~s role is ~s."
			      each-facet-name
			      each-role
			      (f.get each-node each-role each-facet-name))))))
	  nil)