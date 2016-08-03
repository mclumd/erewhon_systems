 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g3))
              (p4::instantiate-consed-literal '(g2))
              (p4::instantiate-consed-literal '(g1)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g3))
              (p4::instantiate-consed-literal '(g2))
              (p4::instantiate-consed-literal '(g1)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 2768 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(g3)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 2768))
  (list
    (p4::make-operator-node 
        :name 2769 
        :parent (find-node 2768) 
        :operator (p4::get-operator a2-3))))
 
(setf (p4::nexus-children (find-node 2769))
  (list
    (p4::make-binding-node 
        :name 2770 
        :parent (find-node 2769)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2770))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 2770)
          :precond 
            (p4::instantiate-consed-literal '(p3))))
 
(setf (p4::nexus-children (find-node 2770))
  (list
    (p4::make-goal-node 
        :name 2984 
        :parent (find-node 2770) 
        :goal 
            (p4::instantiate-consed-literal '(g2)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 2984))
  (list
    (p4::make-operator-node 
        :name 2985 
        :parent (find-node 2984) 
        :operator (p4::get-operator a2-2))))
 
(setf (p4::nexus-children (find-node 2985))
  (list
    (p4::make-binding-node 
        :name 2986 
        :parent (find-node 2985)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2986))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 2986)
          :precond 
            (p4::instantiate-consed-literal '(p2))))
 
(setf (p4::nexus-children (find-node 2986))
  (list
    (p4::make-goal-node 
        :name 3232 
        :parent (find-node 2986) 
        :goal 
            (p4::instantiate-consed-literal '(g1)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 3232))
  (list
    (p4::make-operator-node 
        :name 3233 
        :parent (find-node 3232) 
        :operator (p4::get-operator a2-1))))
 
(setf (p4::nexus-children (find-node 3233))
  (list
    (p4::make-binding-node 
        :name 3234 
        :parent (find-node 3233)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3234))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 3234)
          :precond 
            (p4::instantiate-consed-literal '(p1))))
 
(setf (p4::nexus-children (find-node 3234))
  (list
    (p4::make-goal-node 
        :name 3235 
        :parent (find-node 3234) 
        :goal 
            (p4::instantiate-consed-literal '(p1)) 
        :introducing-operators (list (find-node 3234) )))) 
 
(setf (p4::nexus-children (find-node 3235))
  (list
    (p4::make-operator-node 
        :name 3236 
        :parent (find-node 3235) 
        :operator (p4::get-operator a1-1))))
 
(setf (p4::nexus-children (find-node 3236))
  (list
    (p4::make-binding-node 
        :name 3237 
        :parent (find-node 3236)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3237))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 3237)
          :precond 
            (p4::instantiate-consed-literal '(i1))))
 
(setf (p4::nexus-children (find-node 3237))
  (list
    (p4::make-applied-op-node 
        :name 3238 
        :parent (find-node 3237)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3238))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 3237)
          :precond 
            (p4::instantiate-consed-literal '(i1))))

(setf (p4::a-or-b-node-applied (find-node 3238))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3238))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 3238))
  (list
    (p4::make-goal-node 
        :name 3246 
        :parent (find-node 3238) 
        :goal 
            (p4::instantiate-consed-literal '(p2)) 
        :introducing-operators (list (find-node 2986) )))) 
 
(setf (p4::nexus-children (find-node 3246))
  (list
    (p4::make-operator-node 
        :name 3247 
        :parent (find-node 3246) 
        :operator (p4::get-operator a1-2))))
 
(setf (p4::nexus-children (find-node 3247))
  (list
    (p4::make-binding-node 
        :name 3248 
        :parent (find-node 3247)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3248))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 3248)
          :precond 
            (p4::instantiate-consed-literal '(i2))))
 
(setf (p4::nexus-children (find-node 3248))
  (list
    (p4::make-applied-op-node 
        :name 3249 
        :parent (find-node 3248)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3249))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 3248)
          :precond 
            (p4::instantiate-consed-literal '(i2))))

(setf (p4::a-or-b-node-applied (find-node 3249))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3249))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))))))
 
(setf (p4::nexus-children (find-node 3249))
  (list
    (p4::make-goal-node 
        :name 3258 
        :parent (find-node 3249) 
        :goal 
            (p4::instantiate-consed-literal '(p3)) 
        :introducing-operators (list (find-node 2770) )))) 
 
(setf (p4::nexus-children (find-node 3258))
  (list
    (p4::make-operator-node 
        :name 3259 
        :parent (find-node 3258) 
        :operator (p4::get-operator a1-3))))
 
(setf (p4::nexus-children (find-node 3259))
  (list
    (p4::make-binding-node 
        :name 3260 
        :parent (find-node 3259)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3260))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 3260)
          :precond 
            (p4::instantiate-consed-literal '(i3))))
 
(setf (p4::nexus-children (find-node 3260))
  (list
    (p4::make-applied-op-node 
        :name 3261 
        :parent (find-node 3260)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3261))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 3260)
          :precond 
            (p4::instantiate-consed-literal '(i3))))

(setf (p4::a-or-b-node-applied (find-node 3261))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3261))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i2))))))
 
(setf (p4::nexus-children (find-node 3261))
  (list
    (p4::make-applied-op-node 
        :name 3262 
        :parent (find-node 3261)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3262))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 3234)
          :precond 
            (p4::instantiate-consed-literal '(p1))))

(setf (p4::a-or-b-node-applied (find-node 3262))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3262))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i3))))))
 
(setf (p4::nexus-children (find-node 3262))
  (list
    (p4::make-applied-op-node 
        :name 3263 
        :parent (find-node 3262)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3263))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 2986)
          :precond 
            (p4::instantiate-consed-literal '(p2))))

(setf (p4::a-or-b-node-applied (find-node 3263))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3263))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 3263))
  (list
    (p4::make-applied-op-node 
        :name 3264 
        :parent (find-node 3263)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3264))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 2770)
          :precond 
            (p4::instantiate-consed-literal '(p3))))

(setf (p4::a-or-b-node-applied (find-node 3264))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3264))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p2))))))
