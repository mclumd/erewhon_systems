

(setf alpha				;find alpha. 10 iterations because this function is slow.
  (compute-alpha 
   (setf data				
     (sample-helper 1000 0 100))	;n=1000
   .4 10))

(find-change (make-wp data		;wp using data as sample
		      .05 
		      0.5 
		      100) 
	     data 
	     alpha)			;any change?




(find-change (make-wp data		;wp using data as sample
		      .05 
		      0.5 
		      100)
	     (setf data1 
	       (append 
		data 
		(sample-helper 1000 50 150))) ;data from a different distribution
	     alpha)			;should find a change

 


