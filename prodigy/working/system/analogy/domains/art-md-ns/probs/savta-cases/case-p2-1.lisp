 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g1))
              (p4::instantiate-consed-literal '(g2)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g1))
              (p4::instantiate-consed-literal '(g2)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 86 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(g2)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 86))
  (list
    (p4::make-operator-node 
        :name 87 
        :parent (find-node 86) 
        :operator (p4::get-operator a2-2))))
 
(setf (p4::nexus-children (find-node 87))
  (list
    (p4::make-binding-node 
        :name 88 
        :parent (find-node 87)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 88))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 88)
          :precond 
            (p4::instantiate-consed-literal '(p2))))
 
(setf (p4::nexus-children (find-node 88))
  (list
    (p4::make-goal-node 
        :name 115 
        :parent (find-node 88) 
        :goal 
            (p4::instantiate-consed-literal '(g1)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 115))
  (list
    (p4::make-operator-node 
        :name 116 
        :parent (find-node 115) 
        :operator (p4::get-operator a2-1))))
 
(setf (p4::nexus-children (find-node 116))
  (list
    (p4::make-binding-node 
        :name 117 
        :parent (find-node 116)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 117))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 117)
          :precond 
            (p4::instantiate-consed-literal '(p1))))
 
(setf (p4::nexus-children (find-node 117))
  (list
    (p4::make-goal-node 
        :name 118 
        :parent (find-node 117) 
        :goal 
            (p4::instantiate-consed-literal '(p1)) 
        :introducing-operators (list (find-node 117) )))) 
 
(setf (p4::nexus-children (find-node 118))
  (list
    (p4::make-operator-node 
        :name 119 
        :parent (find-node 118) 
        :operator (p4::get-operator a1-1))))
 
(setf (p4::nexus-children (find-node 119))
  (list
    (p4::make-binding-node 
        :name 120 
        :parent (find-node 119)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 120))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 120)
          :precond 
            (p4::instantiate-consed-literal '(i1))))
 
(setf (p4::nexus-children (find-node 120))
  (list
    (p4::make-applied-op-node 
        :name 121 
        :parent (find-node 120)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 121))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 120)
          :precond 
            (p4::instantiate-consed-literal '(i1))))

(setf (p4::a-or-b-node-applied (find-node 121))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 121))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 121))
  (list
    (p4::make-goal-node 
        :name 126 
        :parent (find-node 121) 
        :goal 
            (p4::instantiate-consed-literal '(p2)) 
        :introducing-operators (list (find-node 88) )))) 
 
(setf (p4::nexus-children (find-node 126))
  (list
    (p4::make-operator-node 
        :name 127 
        :parent (find-node 126) 
        :operator (p4::get-operator a1-2))))
 
(setf (p4::nexus-children (find-node 127))
  (list
    (p4::make-binding-node 
        :name 128 
        :parent (find-node 127)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 128))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 128)
          :precond 
            (p4::instantiate-consed-literal '(i2))))
 
(setf (p4::nexus-children (find-node 128))
  (list
    (p4::make-applied-op-node 
        :name 129 
        :parent (find-node 128)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 129))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 128)
          :precond 
            (p4::instantiate-consed-literal '(i2))))

(setf (p4::a-or-b-node-applied (find-node 129))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 129))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))))))
 
(setf (p4::nexus-children (find-node 129))
  (list
    (p4::make-applied-op-node 
        :name 130 
        :parent (find-node 129)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 130))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 117)
          :precond 
            (p4::instantiate-consed-literal '(p1))))

(setf (p4::a-or-b-node-applied (find-node 130))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 130))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i2))))))
 
(setf (p4::nexus-children (find-node 130))
  (list
    (p4::make-applied-op-node 
        :name 131 
        :parent (find-node 130)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 131))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 88)
          :precond 
            (p4::instantiate-consed-literal '(p2))))

(setf (p4::a-or-b-node-applied (find-node 131))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 131))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p1))))))
