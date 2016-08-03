 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g1))
              (p4::instantiate-consed-literal '(g2))
              (p4::instantiate-consed-literal '(g3)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g1))
              (p4::instantiate-consed-literal '(g2))
              (p4::instantiate-consed-literal '(g3)))))
 
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
        :name 3533 
        :parent (find-node 2770) 
        :goal 
            (p4::instantiate-consed-literal '(g2)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 3533))
  (list
    (p4::make-operator-node 
        :name 3534 
        :parent (find-node 3533) 
        :operator (p4::get-operator a2-2))))
 
(setf (p4::nexus-children (find-node 3534))
  (list
    (p4::make-binding-node 
        :name 3535 
        :parent (find-node 3534)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3535))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 3535)
          :precond 
            (p4::instantiate-consed-literal '(p2))))
 
(setf (p4::nexus-children (find-node 3535))
  (list
    (p4::make-goal-node 
        :name 3781 
        :parent (find-node 3535) 
        :goal 
            (p4::instantiate-consed-literal '(g1)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 3781))
  (list
    (p4::make-operator-node 
        :name 3782 
        :parent (find-node 3781) 
        :operator (p4::get-operator a2-1))))
 
(setf (p4::nexus-children (find-node 3782))
  (list
    (p4::make-binding-node 
        :name 3783 
        :parent (find-node 3782)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3783))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 3783)
          :precond 
            (p4::instantiate-consed-literal '(p1))))
 
(setf (p4::nexus-children (find-node 3783))
  (list
    (p4::make-goal-node 
        :name 3784 
        :parent (find-node 3783) 
        :goal 
            (p4::instantiate-consed-literal '(p1)) 
        :introducing-operators (list (find-node 3783) )))) 
 
(setf (p4::nexus-children (find-node 3784))
  (list
    (p4::make-operator-node 
        :name 3785 
        :parent (find-node 3784) 
        :operator (p4::get-operator a1-1))))
 
(setf (p4::nexus-children (find-node 3785))
  (list
    (p4::make-binding-node 
        :name 3786 
        :parent (find-node 3785)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3786))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 3786)
          :precond 
            (p4::instantiate-consed-literal '(i1))))
 
(setf (p4::nexus-children (find-node 3786))
  (list
    (p4::make-applied-op-node 
        :name 3787 
        :parent (find-node 3786)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3787))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 3786)
          :precond 
            (p4::instantiate-consed-literal '(i1))))

(setf (p4::a-or-b-node-applied (find-node 3787))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3787))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 3787))
  (list
    (p4::make-goal-node 
        :name 3795 
        :parent (find-node 3787) 
        :goal 
            (p4::instantiate-consed-literal '(p2)) 
        :introducing-operators (list (find-node 3535) )))) 
 
(setf (p4::nexus-children (find-node 3795))
  (list
    (p4::make-operator-node 
        :name 3796 
        :parent (find-node 3795) 
        :operator (p4::get-operator a1-2))))
 
(setf (p4::nexus-children (find-node 3796))
  (list
    (p4::make-binding-node 
        :name 3797 
        :parent (find-node 3796)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3797))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 3797)
          :precond 
            (p4::instantiate-consed-literal '(i2))))
 
(setf (p4::nexus-children (find-node 3797))
  (list
    (p4::make-applied-op-node 
        :name 3798 
        :parent (find-node 3797)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3798))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 3797)
          :precond 
            (p4::instantiate-consed-literal '(i2))))

(setf (p4::a-or-b-node-applied (find-node 3798))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3798))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))))))
 
(setf (p4::nexus-children (find-node 3798))
  (list
    (p4::make-goal-node 
        :name 3807 
        :parent (find-node 3798) 
        :goal 
            (p4::instantiate-consed-literal '(p3)) 
        :introducing-operators (list (find-node 2770) )))) 
 
(setf (p4::nexus-children (find-node 3807))
  (list
    (p4::make-operator-node 
        :name 3808 
        :parent (find-node 3807) 
        :operator (p4::get-operator a1-3))))
 
(setf (p4::nexus-children (find-node 3808))
  (list
    (p4::make-binding-node 
        :name 3809 
        :parent (find-node 3808)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3809))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 3809)
          :precond 
            (p4::instantiate-consed-literal '(i3))))
 
(setf (p4::nexus-children (find-node 3809))
  (list
    (p4::make-applied-op-node 
        :name 3810 
        :parent (find-node 3809)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3810))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 3809)
          :precond 
            (p4::instantiate-consed-literal '(i3))))

(setf (p4::a-or-b-node-applied (find-node 3810))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3810))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i2))))))
 
(setf (p4::nexus-children (find-node 3810))
  (list
    (p4::make-applied-op-node 
        :name 3811 
        :parent (find-node 3810)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3811))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 3783)
          :precond 
            (p4::instantiate-consed-literal '(p1))))

(setf (p4::a-or-b-node-applied (find-node 3811))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3811))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i3))))))
 
(setf (p4::nexus-children (find-node 3811))
  (list
    (p4::make-applied-op-node 
        :name 3812 
        :parent (find-node 3811)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3812))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 3535)
          :precond 
            (p4::instantiate-consed-literal '(p2))))

(setf (p4::a-or-b-node-applied (find-node 3812))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3812))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 3812))
  (list
    (p4::make-applied-op-node 
        :name 3813 
        :parent (find-node 3812)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3813))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 2770)
          :precond 
            (p4::instantiate-consed-literal '(p3))))

(setf (p4::a-or-b-node-applied (find-node 3813))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 3813))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p2))))))
