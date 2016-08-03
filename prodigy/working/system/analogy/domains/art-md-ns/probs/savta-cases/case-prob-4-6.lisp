 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g3))
              (p4::instantiate-consed-literal '(g15))
              (p4::instantiate-consed-literal '(g9))
              (p4::instantiate-consed-literal '(g1)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g3))
              (p4::instantiate-consed-literal '(g15))
              (p4::instantiate-consed-literal '(g9))
              (p4::instantiate-consed-literal '(g1)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(g3)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator a2-3))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p3))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(p3)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator a1-3))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 10)
          :precond 
            (p4::instantiate-consed-literal '(i3))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-goal-node 
        :name 2650 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(g15)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 2650))
  (list
    (p4::make-operator-node 
        :name 2651 
        :parent (find-node 2650) 
        :operator (p4::get-operator a2-15))))
 
(setf (p4::nexus-children (find-node 2651))
  (list
    (p4::make-binding-node 
        :name 2652 
        :parent (find-node 2651)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p15))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2652))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-15)
          :binding-node-back-pointer (find-node 2652)
          :precond 
            (p4::instantiate-consed-literal '(p15))))
 
(setf (p4::nexus-children (find-node 2652))
  (list
    (p4::make-goal-node 
        :name 3776 
        :parent (find-node 2652) 
        :goal 
            (p4::instantiate-consed-literal '(p15)) 
        :introducing-operators (list (find-node 2652) )))) 
 
(setf (p4::nexus-children (find-node 3776))
  (list
    (p4::make-operator-node 
        :name 3777 
        :parent (find-node 3776) 
        :operator (p4::get-operator a1-15))))
 
(setf (p4::nexus-children (find-node 3777))
  (list
    (p4::make-binding-node 
        :name 3778 
        :parent (find-node 3777)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i15))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3778))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-15)
          :binding-node-back-pointer (find-node 3778)
          :precond 
            (p4::instantiate-consed-literal '(i15))))
 
(setf (p4::nexus-children (find-node 3778))
  (list
    (p4::make-goal-node 
        :name 4162 
        :parent (find-node 3778) 
        :goal 
            (p4::instantiate-consed-literal '(g9)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 4162))
  (list
    (p4::make-operator-node 
        :name 4163 
        :parent (find-node 4162) 
        :operator (p4::get-operator a2-9))))
 
(setf (p4::nexus-children (find-node 4163))
  (list
    (p4::make-binding-node 
        :name 4164 
        :parent (find-node 4163)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p9))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4164))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-9)
          :binding-node-back-pointer (find-node 4164)
          :precond 
            (p4::instantiate-consed-literal '(p9))))
 
(setf (p4::nexus-children (find-node 4164))
  (list
    (p4::make-goal-node 
        :name 4447 
        :parent (find-node 4164) 
        :goal 
            (p4::instantiate-consed-literal '(p9)) 
        :introducing-operators (list (find-node 4164) )))) 
 
(setf (p4::nexus-children (find-node 4447))
  (list
    (p4::make-operator-node 
        :name 4448 
        :parent (find-node 4447) 
        :operator (p4::get-operator a1-9))))
 
(setf (p4::nexus-children (find-node 4448))
  (list
    (p4::make-binding-node 
        :name 4449 
        :parent (find-node 4448)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i9))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4449))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-9)
          :binding-node-back-pointer (find-node 4449)
          :precond 
            (p4::instantiate-consed-literal '(i9))))
 
(setf (p4::nexus-children (find-node 4449))
  (list
    (p4::make-goal-node 
        :name 4683 
        :parent (find-node 4449) 
        :goal 
            (p4::instantiate-consed-literal '(g1)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 4683))
  (list
    (p4::make-operator-node 
        :name 4684 
        :parent (find-node 4683) 
        :operator (p4::get-operator a2-1))))
 
(setf (p4::nexus-children (find-node 4684))
  (list
    (p4::make-binding-node 
        :name 4685 
        :parent (find-node 4684)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4685))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 4685)
          :precond 
            (p4::instantiate-consed-literal '(p1))))
 
(setf (p4::nexus-children (find-node 4685))
  (list
    (p4::make-goal-node 
        :name 4790 
        :parent (find-node 4685) 
        :goal 
            (p4::instantiate-consed-literal '(p1)) 
        :introducing-operators (list (find-node 4685) )))) 
 
(setf (p4::nexus-children (find-node 4790))
  (list
    (p4::make-operator-node 
        :name 4791 
        :parent (find-node 4790) 
        :operator (p4::get-operator a1-1))))
 
(setf (p4::nexus-children (find-node 4791))
  (list
    (p4::make-binding-node 
        :name 4792 
        :parent (find-node 4791)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4792))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 4792)
          :precond 
            (p4::instantiate-consed-literal '(i1))))
 
(setf (p4::nexus-children (find-node 4792))
  (list
    (p4::make-applied-op-node 
        :name 4793 
        :parent (find-node 4792)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4793))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 4792)
          :precond 
            (p4::instantiate-consed-literal '(i1))))

(setf (p4::a-or-b-node-applied (find-node 4793))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4793))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 4793))
  (list
    (p4::make-applied-op-node 
        :name 4794 
        :parent (find-node 4793)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4794))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 10)
          :precond 
            (p4::instantiate-consed-literal '(i3))))

(setf (p4::a-or-b-node-applied (find-node 4794))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4794))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))
                 (p4::instantiate-consed-literal '(i2))))))
 
(setf (p4::nexus-children (find-node 4794))
  (list
    (p4::make-applied-op-node 
        :name 4795 
        :parent (find-node 4794)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4795))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-9)
          :binding-node-back-pointer (find-node 4449)
          :precond 
            (p4::instantiate-consed-literal '(i9))))

(setf (p4::a-or-b-node-applied (find-node 4795))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4795))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p9)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i3))
                 (p4::instantiate-consed-literal '(i4))
                 (p4::instantiate-consed-literal '(i5))
                 (p4::instantiate-consed-literal '(i6))
                 (p4::instantiate-consed-literal '(i7))
                 (p4::instantiate-consed-literal '(i8))))))
 
(setf (p4::nexus-children (find-node 4795))
  (list
    (p4::make-applied-op-node 
        :name 4796 
        :parent (find-node 4795)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4796))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-15)
          :binding-node-back-pointer (find-node 3778)
          :precond 
            (p4::instantiate-consed-literal '(i15))))

(setf (p4::a-or-b-node-applied (find-node 4796))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4796))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p15)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i9))
                 (p4::instantiate-consed-literal '(i10))
                 (p4::instantiate-consed-literal '(i11))
                 (p4::instantiate-consed-literal '(i12))
                 (p4::instantiate-consed-literal '(i13))
                 (p4::instantiate-consed-literal '(i14))))))
 
(setf (p4::nexus-children (find-node 4796))
  (list
    (p4::make-applied-op-node 
        :name 4797 
        :parent (find-node 4796)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4797))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 4685)
          :precond 
            (p4::instantiate-consed-literal '(p1))))

(setf (p4::a-or-b-node-applied (find-node 4797))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4797))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i15))))))
 
(setf (p4::nexus-children (find-node 4797))
  (list
    (p4::make-applied-op-node 
        :name 4798 
        :parent (find-node 4797)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4798))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p3))))

(setf (p4::a-or-b-node-applied (find-node 4798))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4798))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 4798))
  (list
    (p4::make-applied-op-node 
        :name 4799 
        :parent (find-node 4798)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4799))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-9)
          :binding-node-back-pointer (find-node 4164)
          :precond 
            (p4::instantiate-consed-literal '(p9))))

(setf (p4::a-or-b-node-applied (find-node 4799))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4799))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g9)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p3))))))
 
(setf (p4::nexus-children (find-node 4799))
  (list
    (p4::make-applied-op-node 
        :name 4800 
        :parent (find-node 4799)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4800))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-15)
          :binding-node-back-pointer (find-node 2652)
          :precond 
            (p4::instantiate-consed-literal '(p15))))

(setf (p4::a-or-b-node-applied (find-node 4800))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4800))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g15)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p9))))))
