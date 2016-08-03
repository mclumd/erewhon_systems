 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g2))
              (p4::instantiate-consed-literal '(g3))
              (p4::instantiate-consed-literal '(g4)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g2))
              (p4::instantiate-consed-literal '(g3))
              (p4::instantiate-consed-literal '(g4)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 2283 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(g4)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 2283))
  (list
    (p4::make-operator-node 
        :name 2284 
        :parent (find-node 2283) 
        :operator (p4::get-operator a2-4))))
 
(setf (p4::nexus-children (find-node 2284))
  (list
    (p4::make-binding-node 
        :name 2285 
        :parent (find-node 2284)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2285))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 2285)
          :precond 
            (p4::instantiate-consed-literal '(p4))))
 
(setf (p4::nexus-children (find-node 2285))
  (list
    (p4::make-goal-node 
        :name 2941 
        :parent (find-node 2285) 
        :goal 
            (p4::instantiate-consed-literal '(g3)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 2941))
  (list
    (p4::make-operator-node 
        :name 2942 
        :parent (find-node 2941) 
        :operator (p4::get-operator a2-3))))
 
(setf (p4::nexus-children (find-node 2942))
  (list
    (p4::make-binding-node 
        :name 2943 
        :parent (find-node 2942)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2943))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 2943)
          :precond 
            (p4::instantiate-consed-literal '(p3))))
 
(setf (p4::nexus-children (find-node 2943))
  (list
    (p4::make-goal-node 
        :name 3146 
        :parent (find-node 2943) 
        :goal 
            (p4::instantiate-consed-literal '(g2)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 3146))
  (list
    (p4::make-operator-node 
        :name 3147 
        :parent (find-node 3146) 
        :operator (p4::get-operator a2-2))))
 
(setf (p4::nexus-children (find-node 3147))
  (list
    (p4::make-binding-node 
        :name 3148 
        :parent (find-node 3147)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3148))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 3148)
          :precond 
            (p4::instantiate-consed-literal '(p2))))
 
(setf (p4::nexus-children (find-node 3148))
  (list
    (p4::make-goal-node 
        :name 3149 
        :parent (find-node 3148) 
        :goal 
            (p4::instantiate-consed-literal '(p2)) 
        :introducing-operators (list (find-node 3148) )))) 
 
(setf (p4::nexus-children (find-node 3149))
  (list
    (p4::make-operator-node 
        :name 3150 
        :parent (find-node 3149) 
        :operator (p4::get-operator a1-2))))
 
(setf (p4::nexus-children (find-node 3150))
  (list
    (p4::make-binding-node 
        :name 3151 
        :parent (find-node 3150)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3151))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 3151)
          :precond 
            (p4::instantiate-consed-literal '(i2))))
 
(setf (p4::nexus-children (find-node 3151))
  (list
    (p4::make-applied-op-node 
        :name 3152 
        :parent (find-node 3151)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3152))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 3151)
          :precond 
            (p4::instantiate-consed-literal '(i2))))

(setf (p4::a-or-b-node-applied (find-node 3152))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3152))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))))))
 
(setf (p4::nexus-children (find-node 3152))
  (list
    (p4::make-goal-node 
        :name 3157 
        :parent (find-node 3152) 
        :goal 
            (p4::instantiate-consed-literal '(p3)) 
        :introducing-operators (list (find-node 2943) )))) 
 
(setf (p4::nexus-children (find-node 3157))
  (list
    (p4::make-operator-node 
        :name 3158 
        :parent (find-node 3157) 
        :operator (p4::get-operator a1-3))))
 
(setf (p4::nexus-children (find-node 3158))
  (list
    (p4::make-binding-node 
        :name 3159 
        :parent (find-node 3158)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3159))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 3159)
          :precond 
            (p4::instantiate-consed-literal '(i3))))
 
(setf (p4::nexus-children (find-node 3159))
  (list
    (p4::make-applied-op-node 
        :name 3160 
        :parent (find-node 3159)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3160))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 3159)
          :precond 
            (p4::instantiate-consed-literal '(i3))))

(setf (p4::a-or-b-node-applied (find-node 3160))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3160))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i2))))))
 
(setf (p4::nexus-children (find-node 3160))
  (list
    (p4::make-goal-node 
        :name 3169 
        :parent (find-node 3160) 
        :goal 
            (p4::instantiate-consed-literal '(p4)) 
        :introducing-operators (list (find-node 2285) )))) 
 
(setf (p4::nexus-children (find-node 3169))
  (list
    (p4::make-operator-node 
        :name 3170 
        :parent (find-node 3169) 
        :operator (p4::get-operator a1-4))))
 
(setf (p4::nexus-children (find-node 3170))
  (list
    (p4::make-binding-node 
        :name 3171 
        :parent (find-node 3170)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3171))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 3171)
          :precond 
            (p4::instantiate-consed-literal '(i4))))
 
(setf (p4::nexus-children (find-node 3171))
  (list
    (p4::make-applied-op-node 
        :name 3172 
        :parent (find-node 3171)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3172))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 3171)
          :precond 
            (p4::instantiate-consed-literal '(i4))))

(setf (p4::a-or-b-node-applied (find-node 3172))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3172))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i3))))))
 
(setf (p4::nexus-children (find-node 3172))
  (list
    (p4::make-applied-op-node 
        :name 3173 
        :parent (find-node 3172)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3173))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 3148)
          :precond 
            (p4::instantiate-consed-literal '(p2))))

(setf (p4::a-or-b-node-applied (find-node 3173))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3173))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i4))))))
 
(setf (p4::nexus-children (find-node 3173))
  (list
    (p4::make-applied-op-node 
        :name 3174 
        :parent (find-node 3173)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3174))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 2943)
          :precond 
            (p4::instantiate-consed-literal '(p3))))

(setf (p4::a-or-b-node-applied (find-node 3174))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3174))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p2))))))
 
(setf (p4::nexus-children (find-node 3174))
  (list
    (p4::make-applied-op-node 
        :name 3175 
        :parent (find-node 3174)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3175))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 2285)
          :precond 
            (p4::instantiate-consed-literal '(p4))))

(setf (p4::a-or-b-node-applied (find-node 3175))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3175))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p3))))))
