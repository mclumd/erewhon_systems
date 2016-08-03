(in-package :user)

(defun tell (&key sender 
		  content 
		  receiver 
		  reply-with 
		  (language 'PDL)
		  (ontology
		   (concatenate
		       'string
		     *prodigy-base-directory*
;		     "/working/domains/logistics/domain.lisp"))
		     "/working/domains/gtrans/domain.lisp"))
		  )
  (cond ((equal sender 'PRODIGY-Agent)
	 (send-to-socket 
	 (format 
	  nil
;	  s-b
	  "~S"
		  `(tell
		    :sender ,sender 

		    :content ,content
		    :receiver ,receiver
		    :reply-with ,reply-with
		    :language ,language
		    :ontology ,ontology
		    ))
	  *tcl-send*)
	 )
	(t
	 (format
	  t
	  "Here write the code to receive a tell message.")))
  )
