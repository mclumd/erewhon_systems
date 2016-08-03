 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g13))
              (p4::instantiate-consed-literal '(g12)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g13))
              (p4::instantiate-consed-literal '(g12)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(g13)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator a2-13))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p13))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-13)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p13))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 35 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(g12)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 35))
  (list
    (p4::make-operator-node 
        :name 36 
        :parent (find-node 35) 
        :operator (p4::get-operator a2-12))))
 
(setf (p4::nexus-children (find-node 36))
  (list
    (p4::make-binding-node 
        :name 37 
        :parent (find-node 36)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p12))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 37))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-12)
          :binding-node-back-pointer (find-node 37)
          :precond 
            (p4::instantiate-consed-literal '(p12))))
 
(setf (p4::nexus-children (find-node 37))
  (list
    (p4::make-goal-node 
        :name 38 
        :parent (find-node 37) 
        :goal 
            (p4::instantiate-consed-literal '(p12)) 
        :introducing-operators (list (find-node 37) )))) 
 
(setf (p4::nexus-children (find-node 38))
  (list
    (p4::make-operator-node 
        :name 39 
        :parent (find-node 38) 
        :operator (p4::get-operator a1-12))))
 
(setf (p4::nexus-children (find-node 39))
  (list
    (p4::make-binding-node 
        :name 40 
        :parent (find-node 39)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i12))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 40))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-12)
          :binding-node-back-pointer (find-node 40)
          :precond 
            (p4::instantiate-consed-literal '(i12))))
 
(setf (p4::nexus-children (find-node 40))
  (list
    (p4::make-applied-op-node 
        :name 41 
        :parent (find-node 40)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 41))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-12)
          :binding-node-back-pointer (find-node 40)
          :precond 
            (p4::instantiate-consed-literal '(i12))))

(setf (p4::a-or-b-node-applied (find-node 41))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 41))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p12)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))
                 (p4::instantiate-consed-literal '(i2))
                 (p4::instantiate-consed-literal '(i3))
                 (p4::instantiate-consed-literal '(i4))
                 (p4::instantiate-consed-literal '(i5))
                 (p4::instantiate-consed-literal '(i6))
                 (p4::instantiate-consed-literal '(i7))
                 (p4::instantiate-consed-literal '(i8))
                 (p4::instantiate-consed-literal '(i9))
                 (p4::instantiate-consed-literal '(i10))
                 (p4::instantiate-consed-literal '(i11))))))
 
(setf (p4::nexus-children (find-node 41))
  (list
    (p4::make-goal-node 
        :name 46 
        :parent (find-node 41) 
        :goal 
            (p4::instantiate-consed-literal '(p13)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 46))
  (list
    (p4::make-operator-node 
        :name 47 
        :parent (find-node 46) 
        :operator (p4::get-operator a1-13))))
 
(setf (p4::nexus-children (find-node 47))
  (list
    (p4::make-binding-node 
        :name 48 
        :parent (find-node 47)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i13))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 48))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-13)
          :binding-node-back-pointer (find-node 48)
          :precond 
            (p4::instantiate-consed-literal '(i13))))
 
(setf (p4::nexus-children (find-node 48))
  (list
    (p4::make-applied-op-node 
        :name 49 
        :parent (find-node 48)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 49))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-13)
          :binding-node-back-pointer (find-node 48)
          :precond 
            (p4::instantiate-consed-literal '(i13))))

(setf (p4::a-or-b-node-applied (find-node 49))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 49))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p13)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i12))))))
 
(setf (p4::nexus-children (find-node 49))
  (list
    (p4::make-applied-op-node 
        :name 50 
        :parent (find-node 49)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 50))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-12)
          :binding-node-back-pointer (find-node 37)
          :precond 
            (p4::instantiate-consed-literal '(p12))))

(setf (p4::a-or-b-node-applied (find-node 50))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 50))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g12)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i13))
                 (p4::instantiate-consed-literal '(i14))
                 (p4::instantiate-consed-literal '(i15))))))
 
(setf (p4::nexus-children (find-node 50))
  (list
    (p4::make-applied-op-node 
        :name 51 
        :parent (find-node 50)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 51))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-13)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p13))))

(setf (p4::a-or-b-node-applied (find-node 51))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 51))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g13)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p12))))))
