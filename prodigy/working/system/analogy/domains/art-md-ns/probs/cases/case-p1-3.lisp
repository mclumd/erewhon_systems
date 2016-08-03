 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g1))
              (p4::instantiate-consed-literal '(g3)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g1))
              (p4::instantiate-consed-literal '(g3)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 81 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(g3)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 81))
  (list
    (p4::make-operator-node 
        :name 82 
        :parent (find-node 81) 
        :operator (p4::get-operator a2-3))))
 
(setf (p4::nexus-children (find-node 82))
  (list
    (p4::make-binding-node 
        :name 83 
        :parent (find-node 82)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 83))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 83)
          :precond 
            (p4::instantiate-consed-literal '(p3))))
 
(setf (p4::nexus-children (find-node 83))
  (list
    (p4::make-goal-node 
        :name 110 
        :parent (find-node 83) 
        :goal 
            (p4::instantiate-consed-literal '(g1)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 110))
  (list
    (p4::make-operator-node 
        :name 111 
        :parent (find-node 110) 
        :operator (p4::get-operator a2-1))))
 
(setf (p4::nexus-children (find-node 111))
  (list
    (p4::make-binding-node 
        :name 112 
        :parent (find-node 111)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 112))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 112)
          :precond 
            (p4::instantiate-consed-literal '(p1))))
 
(setf (p4::nexus-children (find-node 112))
  (list
    (p4::make-goal-node 
        :name 113 
        :parent (find-node 112) 
        :goal 
            (p4::instantiate-consed-literal '(p1)) 
        :introducing-operators (list (find-node 112) )))) 
 
(setf (p4::nexus-children (find-node 113))
  (list
    (p4::make-operator-node 
        :name 114 
        :parent (find-node 113) 
        :operator (p4::get-operator a1-1))))
 
(setf (p4::nexus-children (find-node 114))
  (list
    (p4::make-binding-node 
        :name 115 
        :parent (find-node 114)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 115))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 115)
          :precond 
            (p4::instantiate-consed-literal '(i1))))
 
(setf (p4::nexus-children (find-node 115))
  (list
    (p4::make-applied-op-node 
        :name 116 
        :parent (find-node 115)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 116))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 115)
          :precond 
            (p4::instantiate-consed-literal '(i1))))

(setf (p4::a-or-b-node-applied (find-node 116))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 116))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 116))
  (list
    (p4::make-goal-node 
        :name 121 
        :parent (find-node 116) 
        :goal 
            (p4::instantiate-consed-literal '(p3)) 
        :introducing-operators (list (find-node 83) )))) 
 
(setf (p4::nexus-children (find-node 121))
  (list
    (p4::make-operator-node 
        :name 122 
        :parent (find-node 121) 
        :operator (p4::get-operator a1-3))))
 
(setf (p4::nexus-children (find-node 122))
  (list
    (p4::make-binding-node 
        :name 123 
        :parent (find-node 122)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 123))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 123)
          :precond 
            (p4::instantiate-consed-literal '(i3))))
 
(setf (p4::nexus-children (find-node 123))
  (list
    (p4::make-applied-op-node 
        :name 124 
        :parent (find-node 123)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 124))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 123)
          :precond 
            (p4::instantiate-consed-literal '(i3))))

(setf (p4::a-or-b-node-applied (find-node 124))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 124))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))
                 (p4::instantiate-consed-literal '(i2))))))
 
(setf (p4::nexus-children (find-node 124))
  (list
    (p4::make-applied-op-node 
        :name 125 
        :parent (find-node 124)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 125))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 112)
          :precond 
            (p4::instantiate-consed-literal '(p1))))

(setf (p4::a-or-b-node-applied (find-node 125))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 125))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i3))
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
 
(setf (p4::nexus-children (find-node 125))
  (list
    (p4::make-applied-op-node 
        :name 126 
        :parent (find-node 125)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 126))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 83)
          :precond 
            (p4::instantiate-consed-literal '(p3))))

(setf (p4::a-or-b-node-applied (find-node 126))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 126))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p1))))))
