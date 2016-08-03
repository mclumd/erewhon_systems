(in-package :shop2)
;;; ------------------------------------------------------------------------
;;; Declare all the data
;;; ------------------------------------------------------------------------

(defdomain blocks-normal
  (
    ;; basic block-stacking operators
    
    (:operator (!pickup ?a)
	 (    
		( on-table ?a )
		( clear ?a )
		( arm-empty ))
                   ((clear ?a) (on-table ?a) (arm-empty))
                   ((holding ?a))
    )
    
    (:operator (!putdown ?b)
               ((holding ?b))
                   ((holding ?b))
                   ((on-table ?b) (clear ?b)(arm-empty))
       )
    
    (:operator (!stack ?c ?d)
               (      
		( clear ?d )
		( holding ?c ))
                   ((holding ?c) (clear ?d))
                   ((on ?c ?d) (clear ?c)(arm-empty))
    )
    
    (:operator (!unstack ?e ?f)
               (   
		( on ?e ?f )
		( clear ?e )
		( arm-empty ))
                   ((clear ?e) (on ?e ?f)(arm-empty))
                   ((holding ?e) (clear ?f))
    )

;;========================================================================================
))
