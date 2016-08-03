 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g11))
              (p4::instantiate-consed-literal '(g13))
              (p4::instantiate-consed-literal '(g2))
              (p4::instantiate-consed-literal '(g10)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g11))
              (p4::instantiate-consed-literal '(g13))
              (p4::instantiate-consed-literal '(g2))
              (p4::instantiate-consed-literal '(g10)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(g11)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator a2-11))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p11))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-11)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p11))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(p11)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator a1-11))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i11))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-11)
          :binding-node-back-pointer (find-node 10)
          :precond 
            (p4::instantiate-consed-literal '(i11))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-goal-node 
        :name 247 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(g13)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 247))
  (list
    (p4::make-operator-node 
        :name 248 
        :parent (find-node 247) 
        :operator (p4::get-operator a2-13))))
 
(setf (p4::nexus-children (find-node 248))
  (list
    (p4::make-binding-node 
        :name 249 
        :parent (find-node 248)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p13))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 249))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-13)
          :binding-node-back-pointer (find-node 249)
          :precond 
            (p4::instantiate-consed-literal '(p13))))
 
(setf (p4::nexus-children (find-node 249))
  (list
    (p4::make-goal-node 
        :name 407 
        :parent (find-node 249) 
        :goal 
            (p4::instantiate-consed-literal '(p13)) 
        :introducing-operators (list (find-node 249) )))) 
 
(setf (p4::nexus-children (find-node 407))
  (list
    (p4::make-operator-node 
        :name 408 
        :parent (find-node 407) 
        :operator (p4::get-operator a1-13))))
 
(setf (p4::nexus-children (find-node 408))
  (list
    (p4::make-binding-node 
        :name 409 
        :parent (find-node 408)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i13))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 409))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-13)
          :binding-node-back-pointer (find-node 409)
          :precond 
            (p4::instantiate-consed-literal '(i13))))
 
(setf (p4::nexus-children (find-node 409))
  (list
    (p4::make-goal-node 
        :name 543 
        :parent (find-node 409) 
        :goal 
            (p4::instantiate-consed-literal '(g2)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 543))
  (list
    (p4::make-operator-node 
        :name 544 
        :parent (find-node 543) 
        :operator (p4::get-operator a2-2))))
 
(setf (p4::nexus-children (find-node 544))
  (list
    (p4::make-binding-node 
        :name 545 
        :parent (find-node 544)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 545))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 545)
          :precond 
            (p4::instantiate-consed-literal '(p2))))
 
(setf (p4::nexus-children (find-node 545))
  (list
    (p4::make-goal-node 
        :name 578 
        :parent (find-node 545) 
        :goal 
            (p4::instantiate-consed-literal '(p2)) 
        :introducing-operators (list (find-node 545) )))) 
 
(setf (p4::nexus-children (find-node 578))
  (list
    (p4::make-operator-node 
        :name 579 
        :parent (find-node 578) 
        :operator (p4::get-operator a1-2))))
 
(setf (p4::nexus-children (find-node 579))
  (list
    (p4::make-binding-node 
        :name 580 
        :parent (find-node 579)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 580))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 580)
          :precond 
            (p4::instantiate-consed-literal '(i2))))
 
(setf (p4::nexus-children (find-node 580))
  (list
    (p4::make-applied-op-node 
        :name 581 
        :parent (find-node 580)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 581))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 580)
          :precond 
            (p4::instantiate-consed-literal '(i2))))

(setf (p4::a-or-b-node-applied (find-node 581))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 581))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))))))
 
(setf (p4::nexus-children (find-node 581))
  (list
    (p4::make-goal-node 
        :name 734 
        :parent (find-node 581) 
        :goal 
            (p4::instantiate-consed-literal '(g10)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 734))
  (list
    (p4::make-operator-node 
        :name 735 
        :parent (find-node 734) 
        :operator (p4::get-operator a2-10))))
 
(setf (p4::nexus-children (find-node 735))
  (list
    (p4::make-binding-node 
        :name 736 
        :parent (find-node 735)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p10))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 736))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-10)
          :binding-node-back-pointer (find-node 736)
          :precond 
            (p4::instantiate-consed-literal '(p10))))
 
(setf (p4::nexus-children (find-node 736))
  (list
    (p4::make-goal-node 
        :name 805 
        :parent (find-node 736) 
        :goal 
            (p4::instantiate-consed-literal '(p10)) 
        :introducing-operators (list (find-node 736) )))) 
 
(setf (p4::nexus-children (find-node 805))
  (list
    (p4::make-operator-node 
        :name 806 
        :parent (find-node 805) 
        :operator (p4::get-operator a1-10))))
 
(setf (p4::nexus-children (find-node 806))
  (list
    (p4::make-binding-node 
        :name 807 
        :parent (find-node 806)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i10))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 807))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-10)
          :binding-node-back-pointer (find-node 807)
          :precond 
            (p4::instantiate-consed-literal '(i10))))
 
(setf (p4::nexus-children (find-node 807))
  (list
    (p4::make-applied-op-node 
        :name 808 
        :parent (find-node 807)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 808))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-10)
          :binding-node-back-pointer (find-node 807)
          :precond 
            (p4::instantiate-consed-literal '(i10))))

(setf (p4::a-or-b-node-applied (find-node 808))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 808))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p10)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i2))
                 (p4::instantiate-consed-literal '(i3))
                 (p4::instantiate-consed-literal '(i4))
                 (p4::instantiate-consed-literal '(i5))
                 (p4::instantiate-consed-literal '(i6))
                 (p4::instantiate-consed-literal '(i7))
                 (p4::instantiate-consed-literal '(i8))
                 (p4::instantiate-consed-literal '(i9))))))
 
(setf (p4::nexus-children (find-node 808))
  (list
    (p4::make-applied-op-node 
        :name 809 
        :parent (find-node 808)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 809))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-11)
          :binding-node-back-pointer (find-node 10)
          :precond 
            (p4::instantiate-consed-literal '(i11))))

(setf (p4::a-or-b-node-applied (find-node 809))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 809))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p11)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i10))))))
 
(setf (p4::nexus-children (find-node 809))
  (list
    (p4::make-applied-op-node 
        :name 810 
        :parent (find-node 809)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 810))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-13)
          :binding-node-back-pointer (find-node 409)
          :precond 
            (p4::instantiate-consed-literal '(i13))))

(setf (p4::a-or-b-node-applied (find-node 810))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 810))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p13)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i11))
                 (p4::instantiate-consed-literal '(i12))))))
 
(setf (p4::nexus-children (find-node 810))
  (list
    (p4::make-applied-op-node 
        :name 811 
        :parent (find-node 810)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 811))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 545)
          :precond 
            (p4::instantiate-consed-literal '(p2))))

(setf (p4::a-or-b-node-applied (find-node 811))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 811))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i13))
                 (p4::instantiate-consed-literal '(i14))
                 (p4::instantiate-consed-literal '(i15))))))
 
(setf (p4::nexus-children (find-node 811))
  (list
    (p4::make-applied-op-node 
        :name 812 
        :parent (find-node 811)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 812))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-10)
          :binding-node-back-pointer (find-node 736)
          :precond 
            (p4::instantiate-consed-literal '(p10))))

(setf (p4::a-or-b-node-applied (find-node 812))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 812))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g10)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p2))))))
 
(setf (p4::nexus-children (find-node 812))
  (list
    (p4::make-applied-op-node 
        :name 813 
        :parent (find-node 812)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 813))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-11)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p11))))

(setf (p4::a-or-b-node-applied (find-node 813))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 813))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g11)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p10))))))
 
(setf (p4::nexus-children (find-node 813))
  (list
    (p4::make-applied-op-node 
        :name 814 
        :parent (find-node 813)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 814))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-13)
          :binding-node-back-pointer (find-node 249)
          :precond 
            (p4::instantiate-consed-literal '(p13))))

(setf (p4::a-or-b-node-applied (find-node 814))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 814))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g13)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p11))))))
