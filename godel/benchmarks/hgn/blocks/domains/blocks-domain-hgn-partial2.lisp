(in-package :shop2)

(defdomain blocks-hgn-simpl
					 ((:operator (!pickup ?a)
											 ((on-table ?a)
												(arm-empty)
												(clear ?a))
											 ((clear ?a)
												(arm-empty)
												(on-table ?a))
											 ((holding ?a)))

						(:operator (!putdown ?a)
											 ((holding ?a))
											 ((holding ?a))
											 ((clear ?a)
												(arm-empty)
												(on-table ?a)))

						(:operator (!stack ?a ?b)
											 ((holding ?a)
												(clear ?b))
											 ((holding ?a)
												(clear ?b))
											 ((arm-empty)
												(on ?a ?b)
												(clear ?a)))

						(:operator (!unstack ?a ?b)
											 ((on ?a ?b)
												(arm-empty)
												(clear ?a))
											 ((on ?a ?b)
												(arm-empty)
												(clear ?a))
											 ((holding ?a)
												(clear ?b)))

            (:gdr (move-block-onto-block ?a ?b)
                  ((on ?a ?b))
                  ((arm-empty) (not (need-to-move ?b)))
                  (((clear ?a) (clear ?b))
;                   ((holding ?a))
                   ))

            (:gdr (clear-block ?a ?b)
                  ((clear ?a))
                  ((on ?b ?a) (arm-empty))
                  (((clear ?b))
;                   ((holding ?b))
                   ((on-table ?b))))

;            (:gdr (move-block-onto-table ?a)
;                  ((on-table ?a))
;                  ((arm-empty))
;                  (((clear ?a))
;                   ((holding ?a))))

						(:- (same ?x ?x) nil)
						(:- (different ?x ?y) ((not (same ?x ?y))))

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
								((on ?x ?w) (need-to-move ?w)))))

