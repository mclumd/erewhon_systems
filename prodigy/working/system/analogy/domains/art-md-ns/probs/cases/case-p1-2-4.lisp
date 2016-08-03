 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g1))
              (p4::instantiate-consed-literal '(g2))
              (p4::instantiate-consed-literal '(g4)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g1))
              (p4::instantiate-consed-literal '(g2))
              (p4::instantiate-consed-literal '(g4)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 2013 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(g4)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 2013))
  (list
    (p4::make-operator-node 
        :name 2014 
        :parent (find-node 2013) 
        :operator (p4::get-operator a2-4))))
 
(setf (p4::nexus-children (find-node 2014))
  (list
    (p4::make-binding-node 
        :name 2015 
        :parent (find-node 2014)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2015))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 2015)
          :precond 
            (p4::instantiate-consed-literal '(p4))))
 
(setf (p4::nexus-children (find-node 2015))
  (list
    (p4::make-goal-node 
        :name 2555 
        :parent (find-node 2015) 
        :goal 
            (p4::instantiate-consed-literal '(g2)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 2555))
  (list
    (p4::make-operator-node 
        :name 2556 
        :parent (find-node 2555) 
        :operator (p4::get-operator a2-2))))
 
(setf (p4::nexus-children (find-node 2556))
  (list
    (p4::make-binding-node 
        :name 2557 
        :parent (find-node 2556)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2557))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 2557)
          :precond 
            (p4::instantiate-consed-literal '(p2))))
 
(setf (p4::nexus-children (find-node 2557))
  (list
    (p4::make-goal-node 
        :name 2731 
        :parent (find-node 2557) 
        :goal 
            (p4::instantiate-consed-literal '(g1)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 2731))
  (list
    (p4::make-operator-node 
        :name 2732 
        :parent (find-node 2731) 
        :operator (p4::get-operator a2-1))))
 
(setf (p4::nexus-children (find-node 2732))
  (list
    (p4::make-binding-node 
        :name 2733 
        :parent (find-node 2732)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2733))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 2733)
          :precond 
            (p4::instantiate-consed-literal '(p1))))
 
(setf (p4::nexus-children (find-node 2733))
  (list
    (p4::make-goal-node 
        :name 2734 
        :parent (find-node 2733) 
        :goal 
            (p4::instantiate-consed-literal '(p1)) 
        :introducing-operators (list (find-node 2733) )))) 
 
(setf (p4::nexus-children (find-node 2734))
  (list
    (p4::make-operator-node 
        :name 2735 
        :parent (find-node 2734) 
        :operator (p4::get-operator a1-1))))
 
(setf (p4::nexus-children (find-node 2735))
  (list
    (p4::make-binding-node 
        :name 2736 
        :parent (find-node 2735)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2736))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 2736)
          :precond 
            (p4::instantiate-consed-literal '(i1))))
 
(setf (p4::nexus-children (find-node 2736))
  (list
    (p4::make-applied-op-node 
        :name 2737 
        :parent (find-node 2736)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2737))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 2736)
          :precond 
            (p4::instantiate-consed-literal '(i1))))

(setf (p4::a-or-b-node-applied (find-node 2737))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 2737))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 2737))
  (list
    (p4::make-goal-node 
        :name 2742 
        :parent (find-node 2737) 
        :goal 
            (p4::instantiate-consed-literal '(p2)) 
        :introducing-operators (list (find-node 2557) )))) 
 
(setf (p4::nexus-children (find-node 2742))
  (list
    (p4::make-operator-node 
        :name 2743 
        :parent (find-node 2742) 
        :operator (p4::get-operator a1-2))))
 
(setf (p4::nexus-children (find-node 2743))
  (list
    (p4::make-binding-node 
        :name 2744 
        :parent (find-node 2743)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2744))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 2744)
          :precond 
            (p4::instantiate-consed-literal '(i2))))
 
(setf (p4::nexus-children (find-node 2744))
  (list
    (p4::make-applied-op-node 
        :name 2745 
        :parent (find-node 2744)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2745))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 2744)
          :precond 
            (p4::instantiate-consed-literal '(i2))))

(setf (p4::a-or-b-node-applied (find-node 2745))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 2745))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))))))
 
(setf (p4::nexus-children (find-node 2745))
  (list
    (p4::make-goal-node 
        :name 2754 
        :parent (find-node 2745) 
        :goal 
            (p4::instantiate-consed-literal '(p4)) 
        :introducing-operators (list (find-node 2015) )))) 
 
(setf (p4::nexus-children (find-node 2754))
  (list
    (p4::make-operator-node 
        :name 2755 
        :parent (find-node 2754) 
        :operator (p4::get-operator a1-4))))
 
(setf (p4::nexus-children (find-node 2755))
  (list
    (p4::make-binding-node 
        :name 2756 
        :parent (find-node 2755)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2756))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 2756)
          :precond 
            (p4::instantiate-consed-literal '(i4))))
 
(setf (p4::nexus-children (find-node 2756))
  (list
    (p4::make-applied-op-node 
        :name 2757 
        :parent (find-node 2756)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2757))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 2756)
          :precond 
            (p4::instantiate-consed-literal '(i4))))

(setf (p4::a-or-b-node-applied (find-node 2757))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 2757))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i2))
                 (p4::instantiate-consed-literal '(i3))))))
 
(setf (p4::nexus-children (find-node 2757))
  (list
    (p4::make-applied-op-node 
        :name 2758 
        :parent (find-node 2757)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2758))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 2733)
          :precond 
            (p4::instantiate-consed-literal '(p1))))

(setf (p4::a-or-b-node-applied (find-node 2758))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 2758))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g1)))
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
 
(setf (p4::nexus-children (find-node 2758))
  (list
    (p4::make-applied-op-node 
        :name 2759 
        :parent (find-node 2758)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2759))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 2557)
          :precond 
            (p4::instantiate-consed-literal '(p2))))

(setf (p4::a-or-b-node-applied (find-node 2759))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 2759))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 2759))
  (list
    (p4::make-applied-op-node 
        :name 2760 
        :parent (find-node 2759)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2760))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 2015)
          :precond 
            (p4::instantiate-consed-literal '(p4))))

(setf (p4::a-or-b-node-applied (find-node 2760))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 2760))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p2))))))
