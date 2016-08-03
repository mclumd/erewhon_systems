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

;; book-keeping methods & ops, to keep track of what needs to be done. Since these aren't real blocks-world operators, make their cost 0
    (:operator (!!assert ?g)
	 ()
	 ()
	 ?g 
    0)

    (:operator (!remove ?g)
	 ()
	 ?g
	 ()
    0)

;; The method for the top-layer task
    (:method (achieve-goals ?goals)
             ()
             ((assert-goals ?goals nil)(move-block nil)))

    (:method (assert-goals (?goal . ?goals) ?out)
             ()
             ((assert-goals ?goals ((goal ?goal) . ?out))))

    (:method (assert-goals nil ?out)
             ()
             ((!!assert ?out)))


    (:method (move-block ?nomove)
             ;; method for moving x from y to z
             ((arm-empty) (clear ?x) (eval (not (member '?x '?nomove))) (on ?x ?y)
              (goal (on ?x ?z)) (different ?x ?z) (clear ?z) (not (need-to-move ?z)))
             ((!unstack ?x ?y) (!stack ?x ?z) (move-block (?x . ?nomove))))

    (:method (move-block ?nomove)
             ;; method for moving x from y to table
             ((arm-empty) (clear ?x) (eval (not (member '?x '?nomove)))
              (on ?x ?y) (goal (on-table ?x)))
             ((!unstack ?x ?y) (!putdown ?x) (move-block (?x . ?nomove))))

    (:method (move-block ?nomove)
             ;; method for moving x from table to y
             ((arm-empty) (clear ?x) (eval (not (member '?x '?nomove)))
              (on-table ?x) (goal (on ?x ?y)) (clear ?y) (not (need-to-move ?y)))
             ((!pickup ?x) (!stack ?x ?y) (move-block (?x . ?nomove))))

    (:method (move-block ?nomove)
             ;; method for moving x out of the way
             ((arm-empty) (clear ?x) (eval (not (member '?x  '?nomove)))
              (on ?x ?y) (need-to-move ?x))
             ((!unstack ?x ?y) (!putdown ?x) (move-block ?nomove)))

    (:method (move-block ?nomove)
             ;; if nothing else matches, then we're done
             ((forall (?z) (block ?z) (not (need-to-move ?z))))
             nil
      )

    ;; state axioms

     (:- (different ?x ?y) ((not (same ?x ?y))))
     (:- (same ?x ?x) nil)

     (:- (need-to-move ?x)
         ;; need to move x if x needs to go from one block to another   
         ((on ?x ?y)  (goal (on ?x ?z)) (different ?y ?z))
         ;; need to move x if x needs to go from table to block   
         ((on-table ?x) (goal (on ?x ?z)))
         ;; need to move x if x needs to go from block to table   
         ((on ?x ?y)  (goal (on-table ?x)))
         ;; need to move x if x is on y and y needs to be clear
         ((on ?x ?y) (goal (clear ?y)))
         ;; need to move x if x is on z and something else needs to be on z
         ((on ?x ?z) (goal (on ?y ?z)) (different ?x ?y))
         ;; need to move x if x is on something else that needs to be moved 
         ((on ?x ?w) (need-to-move ?w)))

;;========================================================================================
))
