 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g4))
              (p4::instantiate-consed-literal '(g11))
              (p4::instantiate-consed-literal '(g2)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g4))
              (p4::instantiate-consed-literal '(g11))
              (p4::instantiate-consed-literal '(g2)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(g4)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator a2-4))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p4))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(p4)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator a1-4))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 10)
          :precond 
            (p4::instantiate-consed-literal '(i4))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-goal-node 
        :name 142 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(g11)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 142))
  (list
    (p4::make-operator-node 
        :name 143 
        :parent (find-node 142) 
        :operator (p4::get-operator a2-11))))
 
(setf (p4::nexus-children (find-node 143))
  (list
    (p4::make-binding-node 
        :name 144 
        :parent (find-node 143)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p11))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 144))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-11)
          :binding-node-back-pointer (find-node 144)
          :precond 
            (p4::instantiate-consed-literal '(p11))))
 
(setf (p4::nexus-children (find-node 144))
  (list
    (p4::make-goal-node 
        :name 232 
        :parent (find-node 144) 
        :goal 
            (p4::instantiate-consed-literal '(p11)) 
        :introducing-operators (list (find-node 144) )))) 
 
(setf (p4::nexus-children (find-node 232))
  (list
    (p4::make-operator-node 
        :name 233 
        :parent (find-node 232) 
        :operator (p4::get-operator a1-11))))
 
(setf (p4::nexus-children (find-node 233))
  (list
    (p4::make-binding-node 
        :name 234 
        :parent (find-node 233)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i11))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 234))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-11)
          :binding-node-back-pointer (find-node 234)
          :precond 
            (p4::instantiate-consed-literal '(i11))))
 
(setf (p4::nexus-children (find-node 234))
  (list
    (p4::make-goal-node 
        :name 308 
        :parent (find-node 234) 
        :goal 
            (p4::instantiate-consed-literal '(g2)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 308))
  (list
    (p4::make-operator-node 
        :name 309 
        :parent (find-node 308) 
        :operator (p4::get-operator a2-2))))
 
(setf (p4::nexus-children (find-node 309))
  (list
    (p4::make-binding-node 
        :name 310 
        :parent (find-node 309)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 310))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 310)
          :precond 
            (p4::instantiate-consed-literal '(p2))))
 
(setf (p4::nexus-children (find-node 310))
  (list
    (p4::make-goal-node 
        :name 343 
        :parent (find-node 310) 
        :goal 
            (p4::instantiate-consed-literal '(p2)) 
        :introducing-operators (list (find-node 310) )))) 
 
(setf (p4::nexus-children (find-node 343))
  (list
    (p4::make-operator-node 
        :name 344 
        :parent (find-node 343) 
        :operator (p4::get-operator a1-2))))
 
(setf (p4::nexus-children (find-node 344))
  (list
    (p4::make-binding-node 
        :name 345 
        :parent (find-node 344)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 345))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 345)
          :precond 
            (p4::instantiate-consed-literal '(i2))))
 
(setf (p4::nexus-children (find-node 345))
  (list
    (p4::make-applied-op-node 
        :name 346 
        :parent (find-node 345)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 346))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 345)
          :precond 
            (p4::instantiate-consed-literal '(i2))))

(setf (p4::a-or-b-node-applied (find-node 346))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 346))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))))))
 
(setf (p4::nexus-children (find-node 346))
  (list
    (p4::make-applied-op-node 
        :name 347 
        :parent (find-node 346)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 347))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 10)
          :precond 
            (p4::instantiate-consed-literal '(i4))))

(setf (p4::a-or-b-node-applied (find-node 347))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 347))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i2))
                 (p4::instantiate-consed-literal '(i3))))))
 
(setf (p4::nexus-children (find-node 347))
  (list
    (p4::make-applied-op-node 
        :name 348 
        :parent (find-node 347)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 348))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-11)
          :binding-node-back-pointer (find-node 234)
          :precond 
            (p4::instantiate-consed-literal '(i11))))

(setf (p4::a-or-b-node-applied (find-node 348))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 348))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p11)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i4))
                 (p4::instantiate-consed-literal '(i5))
                 (p4::instantiate-consed-literal '(i6))
                 (p4::instantiate-consed-literal '(i7))
                 (p4::instantiate-consed-literal '(i8))
                 (p4::instantiate-consed-literal '(i9))
                 (p4::instantiate-consed-literal '(i10))))))
 
(setf (p4::nexus-children (find-node 348))
  (list
    (p4::make-applied-op-node 
        :name 349 
        :parent (find-node 348)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 349))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 310)
          :precond 
            (p4::instantiate-consed-literal '(p2))))

(setf (p4::a-or-b-node-applied (find-node 349))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 349))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i11))
                 (p4::instantiate-consed-literal '(i12))
                 (p4::instantiate-consed-literal '(i13))
                 (p4::instantiate-consed-literal '(i14))
                 (p4::instantiate-consed-literal '(i15))))))
 
(setf (p4::nexus-children (find-node 349))
  (list
    (p4::make-applied-op-node 
        :name 350 
        :parent (find-node 349)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 350))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p4))))

(setf (p4::a-or-b-node-applied (find-node 350))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 350))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p2))))))
 
(setf (p4::nexus-children (find-node 350))
  (list
    (p4::make-applied-op-node 
        :name 351 
        :parent (find-node 350)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 351))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-11)
          :binding-node-back-pointer (find-node 144)
          :precond 
            (p4::instantiate-consed-literal '(p11))))

(setf (p4::a-or-b-node-applied (find-node 351))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 351))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g11)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p4))))))
