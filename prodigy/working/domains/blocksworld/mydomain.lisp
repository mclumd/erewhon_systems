(use-package 'p4)

;; This is the blocksworld according to the proposed 4.0 syntax


;;(p4::reset-problem-space p4::*current-problem-space*)
(p4::create-problem-space 'block :current t)

(p4::subtype-of OBJECT :top-type)


(OPERATOR
 STACK-RED-BLOCK
 (params <ob> <underob>)
 (preconds 
   ((<ob> OBJECT)
    (<underob> (and OBJECT (diff <ob> <underob>))))
    (and (clear <underob>)
	 (holding <ob>)))
 (effects 
      ()
      ((del (holding <ob>))
       (del (clear <underob>))
       (add (arm-empty))
       (add (clear <ob> ))
       (add (on <ob> <underob>)))))

