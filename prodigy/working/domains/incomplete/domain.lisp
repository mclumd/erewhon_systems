;; The first artificial example of Prodigy incompleteness.

(create-problem-space 'incomplete :current t)

;; -= OPERATORS =-

(Operator O1
  (params )
  (preconds () (true))
  (effects () ((add (g1)) (del (g2)) (del (g3)))))

(Operator O2
  (params )
  (preconds () (g3))
  (effects () ((add (g4)))))

(Operator O3
  (params )
  (preconds () (g4))
  (effects () ((add (g2)))))
