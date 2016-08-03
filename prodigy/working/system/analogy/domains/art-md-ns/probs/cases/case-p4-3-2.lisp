 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g4))
              (p4::instantiate-consed-literal '(g3))
              (p4::instantiate-consed-literal '(g2)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g4))
              (p4::instantiate-consed-literal '(g3))
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
        :name 179 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(g3)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 179))
  (list
    (p4::make-operator-node 
        :name 180 
        :parent (find-node 179) 
        :operator (p4::get-operator a2-3))))
 
(setf (p4::nexus-children (find-node 180))
  (list
    (p4::make-binding-node 
        :name 181 
        :parent (find-node 180)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 181))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 181)
          :precond 
            (p4::instantiate-consed-literal '(p3))))
 
(setf (p4::nexus-children (find-node 181))
  (list
    (p4::make-goal-node 
        :name 355 
        :parent (find-node 181) 
        :goal 
            (p4::instantiate-consed-literal '(g2)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 355))
  (list
    (p4::make-operator-node 
        :name 356 
        :parent (find-node 355) 
        :operator (p4::get-operator a2-2))))
 
(setf (p4::nexus-children (find-node 356))
  (list
    (p4::make-binding-node 
        :name 357 
        :parent (find-node 356)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 357))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 357)
          :precond 
            (p4::instantiate-consed-literal '(p2))))
 
(setf (p4::nexus-children (find-node 357))
  (list
    (p4::make-goal-node 
        :name 358 
        :parent (find-node 357) 
        :goal 
            (p4::instantiate-consed-literal '(p2)) 
        :introducing-operators (list (find-node 357) )))) 
 
(setf (p4::nexus-children (find-node 358))
  (list
    (p4::make-operator-node 
        :name 359 
        :parent (find-node 358) 
        :operator (p4::get-operator a1-2))))
 
(setf (p4::nexus-children (find-node 359))
  (list
    (p4::make-binding-node 
        :name 360 
        :parent (find-node 359)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 360))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 360)
          :precond 
            (p4::instantiate-consed-literal '(i2))))
 
(setf (p4::nexus-children (find-node 360))
  (list
    (p4::make-applied-op-node 
        :name 361 
        :parent (find-node 360)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 361))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 360)
          :precond 
            (p4::instantiate-consed-literal '(i2))))

(setf (p4::a-or-b-node-applied (find-node 361))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 361))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))))))
 
(setf (p4::nexus-children (find-node 361))
  (list
    (p4::make-goal-node 
        :name 366 
        :parent (find-node 361) 
        :goal 
            (p4::instantiate-consed-literal '(p3)) 
        :introducing-operators (list (find-node 181) )))) 
 
(setf (p4::nexus-children (find-node 366))
  (list
    (p4::make-operator-node 
        :name 367 
        :parent (find-node 366) 
        :operator (p4::get-operator a1-3))))
 
(setf (p4::nexus-children (find-node 367))
  (list
    (p4::make-binding-node 
        :name 368 
        :parent (find-node 367)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 368))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 368)
          :precond 
            (p4::instantiate-consed-literal '(i3))))
 
(setf (p4::nexus-children (find-node 368))
  (list
    (p4::make-applied-op-node 
        :name 369 
        :parent (find-node 368)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 369))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 368)
          :precond 
            (p4::instantiate-consed-literal '(i3))))

(setf (p4::a-or-b-node-applied (find-node 369))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 369))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i2))))))
 
(setf (p4::nexus-children (find-node 369))
  (list
    (p4::make-goal-node 
        :name 378 
        :parent (find-node 369) 
        :goal 
            (p4::instantiate-consed-literal '(p4)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 378))
  (list
    (p4::make-operator-node 
        :name 379 
        :parent (find-node 378) 
        :operator (p4::get-operator a1-4))))
 
(setf (p4::nexus-children (find-node 379))
  (list
    (p4::make-binding-node 
        :name 380 
        :parent (find-node 379)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 380))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 380)
          :precond 
            (p4::instantiate-consed-literal '(i4))))
 
(setf (p4::nexus-children (find-node 380))
  (list
    (p4::make-applied-op-node 
        :name 381 
        :parent (find-node 380)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 381))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 380)
          :precond 
            (p4::instantiate-consed-literal '(i4))))

(setf (p4::a-or-b-node-applied (find-node 381))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 381))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i3))))))
 
(setf (p4::nexus-children (find-node 381))
  (list
    (p4::make-applied-op-node 
        :name 382 
        :parent (find-node 381)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 382))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 357)
          :precond 
            (p4::instantiate-consed-literal '(p2))))

(setf (p4::a-or-b-node-applied (find-node 382))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 382))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i4))
                 (p4::instantiate-consed-literal '(i5))
                 (p4::instantiate-consed-literal '(i6))
                 (p4::instantiate-consed-literal '(i7))
                 (p4::instantiate-consed-literal '(i8))
                 (p4::instantiate-consed-literal '(i9))
                 (p4::instantiate-consed-literal '(i10))
                 (p4::instantiate-consed-literal '(i11))
                 (p4::instantiate-consed-literal '(i12))
                 (p4::instantiate-consed-literal '(i13))
                 (p4::instantiate-consed-literal '(i14))
                 (p4::instantiate-consed-literal '(i15))))))
 
(setf (p4::nexus-children (find-node 382))
  (list
    (p4::make-applied-op-node 
        :name 383 
        :parent (find-node 382)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 383))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 181)
          :precond 
            (p4::instantiate-consed-literal '(p3))))

(setf (p4::a-or-b-node-applied (find-node 383))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 383))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p2))))))
 
(setf (p4::nexus-children (find-node 383))
  (list
    (p4::make-applied-op-node 
        :name 384 
        :parent (find-node 383)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 384))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p4))))

(setf (p4::a-or-b-node-applied (find-node 384))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 384))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p3))))))
