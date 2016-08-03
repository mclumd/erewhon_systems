 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g4))
              (p4::instantiate-consed-literal '(g5))
              (p4::instantiate-consed-literal '(g14))
              (p4::instantiate-consed-literal '(g1)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g4))
              (p4::instantiate-consed-literal '(g5))
              (p4::instantiate-consed-literal '(g14))
              (p4::instantiate-consed-literal '(g1)))))
 
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
        :name 2650 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(g5)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 2650))
  (list
    (p4::make-operator-node 
        :name 2651 
        :parent (find-node 2650) 
        :operator (p4::get-operator a2-5))))
 
(setf (p4::nexus-children (find-node 2651))
  (list
    (p4::make-binding-node 
        :name 2652 
        :parent (find-node 2651)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p5))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2652))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-5)
          :binding-node-back-pointer (find-node 2652)
          :precond 
            (p4::instantiate-consed-literal '(p5))))
 
(setf (p4::nexus-children (find-node 2652))
  (list
    (p4::make-goal-node 
        :name 4098 
        :parent (find-node 2652) 
        :goal 
            (p4::instantiate-consed-literal '(p5)) 
        :introducing-operators (list (find-node 2652) )))) 
 
(setf (p4::nexus-children (find-node 4098))
  (list
    (p4::make-operator-node 
        :name 4099 
        :parent (find-node 4098) 
        :operator (p4::get-operator a1-5))))
 
(setf (p4::nexus-children (find-node 4099))
  (list
    (p4::make-binding-node 
        :name 4100 
        :parent (find-node 4099)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i5))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4100))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-5)
          :binding-node-back-pointer (find-node 4100)
          :precond 
            (p4::instantiate-consed-literal '(i5))))
 
(setf (p4::nexus-children (find-node 4100))
  (list
    (p4::make-goal-node 
        :name 4806 
        :parent (find-node 4100) 
        :goal 
            (p4::instantiate-consed-literal '(g14)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 4806))
  (list
    (p4::make-operator-node 
        :name 4807 
        :parent (find-node 4806) 
        :operator (p4::get-operator a2-14))))
 
(setf (p4::nexus-children (find-node 4807))
  (list
    (p4::make-binding-node 
        :name 4808 
        :parent (find-node 4807)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p14))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4808))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-14)
          :binding-node-back-pointer (find-node 4808)
          :precond 
            (p4::instantiate-consed-literal '(p14))))
 
(setf (p4::nexus-children (find-node 4808))
  (list
    (p4::make-goal-node 
        :name 5256 
        :parent (find-node 4808) 
        :goal 
            (p4::instantiate-consed-literal '(p14)) 
        :introducing-operators (list (find-node 4808) )))) 
 
(setf (p4::nexus-children (find-node 5256))
  (list
    (p4::make-operator-node 
        :name 5257 
        :parent (find-node 5256) 
        :operator (p4::get-operator a1-14))))
 
(setf (p4::nexus-children (find-node 5257))
  (list
    (p4::make-binding-node 
        :name 5258 
        :parent (find-node 5257)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i14))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5258))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-14)
          :binding-node-back-pointer (find-node 5258)
          :precond 
            (p4::instantiate-consed-literal '(i14))))
 
(setf (p4::nexus-children (find-node 5258))
  (list
    (p4::make-goal-node 
        :name 5492 
        :parent (find-node 5258) 
        :goal 
            (p4::instantiate-consed-literal '(g1)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5492))
  (list
    (p4::make-operator-node 
        :name 5493 
        :parent (find-node 5492) 
        :operator (p4::get-operator a2-1))))
 
(setf (p4::nexus-children (find-node 5493))
  (list
    (p4::make-binding-node 
        :name 5494 
        :parent (find-node 5493)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5494))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 5494)
          :precond 
            (p4::instantiate-consed-literal '(p1))))
 
(setf (p4::nexus-children (find-node 5494))
  (list
    (p4::make-goal-node 
        :name 5599 
        :parent (find-node 5494) 
        :goal 
            (p4::instantiate-consed-literal '(p1)) 
        :introducing-operators (list (find-node 5494) )))) 
 
(setf (p4::nexus-children (find-node 5599))
  (list
    (p4::make-operator-node 
        :name 5600 
        :parent (find-node 5599) 
        :operator (p4::get-operator a1-1))))
 
(setf (p4::nexus-children (find-node 5600))
  (list
    (p4::make-binding-node 
        :name 5601 
        :parent (find-node 5600)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5601))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 5601)
          :precond 
            (p4::instantiate-consed-literal '(i1))))
 
(setf (p4::nexus-children (find-node 5601))
  (list
    (p4::make-applied-op-node 
        :name 5602 
        :parent (find-node 5601)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5602))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 5601)
          :precond 
            (p4::instantiate-consed-literal '(i1))))

(setf (p4::a-or-b-node-applied (find-node 5602))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 5602))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 5602))
  (list
    (p4::make-applied-op-node 
        :name 5603 
        :parent (find-node 5602)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5603))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 10)
          :precond 
            (p4::instantiate-consed-literal '(i4))))

(setf (p4::a-or-b-node-applied (find-node 5603))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 5603))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))
                 (p4::instantiate-consed-literal '(i2))
                 (p4::instantiate-consed-literal '(i3))))))
 
(setf (p4::nexus-children (find-node 5603))
  (list
    (p4::make-applied-op-node 
        :name 5604 
        :parent (find-node 5603)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5604))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-5)
          :binding-node-back-pointer (find-node 4100)
          :precond 
            (p4::instantiate-consed-literal '(i5))))

(setf (p4::a-or-b-node-applied (find-node 5604))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 5604))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p5)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i4))))))
 
(setf (p4::nexus-children (find-node 5604))
  (list
    (p4::make-applied-op-node 
        :name 5605 
        :parent (find-node 5604)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5605))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-14)
          :binding-node-back-pointer (find-node 5258)
          :precond 
            (p4::instantiate-consed-literal '(i14))))

(setf (p4::a-or-b-node-applied (find-node 5605))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 5605))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p14)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i5))
                 (p4::instantiate-consed-literal '(i6))
                 (p4::instantiate-consed-literal '(i7))
                 (p4::instantiate-consed-literal '(i8))
                 (p4::instantiate-consed-literal '(i9))
                 (p4::instantiate-consed-literal '(i10))
                 (p4::instantiate-consed-literal '(i11))
                 (p4::instantiate-consed-literal '(i12))
                 (p4::instantiate-consed-literal '(i13))))))
 
(setf (p4::nexus-children (find-node 5605))
  (list
    (p4::make-applied-op-node 
        :name 5606 
        :parent (find-node 5605)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5606))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 5494)
          :precond 
            (p4::instantiate-consed-literal '(p1))))

(setf (p4::a-or-b-node-applied (find-node 5606))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 5606))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i14))
                 (p4::instantiate-consed-literal '(i15))))))
 
(setf (p4::nexus-children (find-node 5606))
  (list
    (p4::make-applied-op-node 
        :name 5607 
        :parent (find-node 5606)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5607))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p4))))

(setf (p4::a-or-b-node-applied (find-node 5607))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 5607))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 5607))
  (list
    (p4::make-applied-op-node 
        :name 5608 
        :parent (find-node 5607)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5608))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-5)
          :binding-node-back-pointer (find-node 2652)
          :precond 
            (p4::instantiate-consed-literal '(p5))))

(setf (p4::a-or-b-node-applied (find-node 5608))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 5608))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g5)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p4))))))
 
(setf (p4::nexus-children (find-node 5608))
  (list
    (p4::make-applied-op-node 
        :name 5609 
        :parent (find-node 5608)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5609))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-14)
          :binding-node-back-pointer (find-node 4808)
          :precond 
            (p4::instantiate-consed-literal '(p14))))

(setf (p4::a-or-b-node-applied (find-node 5609))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 5609))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g14)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p5))))))
