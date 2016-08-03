

(setf alpha				;find alpha. 10 iterations because this function is slow.
  (compute-alpha 
   (setf wpTest				;wp using data as sample
     (make-wp (sample-helper 100 0 100)	;uniform sample 0-100, n=100
	      .05 0.5 100))
   (setf data				;n=1000, same distribution
     (sample-helper 1000 0 100)) 
   .4 10))

(find-change wpTest data alpha)		;any change?

 

 
(find-change 
 ;;(setf wpTest				;add-all-data changes wp passed to it 
					;so no assignment needed [mcox 4apr12]
   (add-all-data wpTest data)		;add all data to wp
  ;; )
   (setf data1 (sample-helper 1000 50 150)) ;data from a different distribution
 alpha)					;should find a change

 
(a-dist					;current relativized a-distance
 ;;(setf wpTest 
   (add-all-data wpTest data1)		;add all data to wp
 ;;  )
 t)

