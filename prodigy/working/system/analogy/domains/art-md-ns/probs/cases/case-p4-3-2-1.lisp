 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g4))
              (p4::instantiate-consed-literal '(g3))
              (p4::instantiate-consed-literal '(g2))
              (p4::instantiate-consed-literal '(g1)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g4))
              (p4::instantiate-consed-literal '(g3))
              (p4::instantiate-consed-literal '(g2))
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
        :name 2867 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(g3)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 2867))
  (list
    (p4::make-operator-node 
        :name 2868 
        :parent (find-node 2867) 
        :operator (p4::get-operator a2-3))))
 
(setf (p4::nexus-children (find-node 2868))
  (list
    (p4::make-binding-node 
        :name 2869 
        :parent (find-node 2868)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2869))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 2869)
          :precond 
            (p4::instantiate-consed-literal '(p3))))
 
(setf (p4::nexus-children (find-node 2869))
  (list
    (p4::make-goal-node 
        :name 4592 
        :parent (find-node 2869) 
        :goal 
            (p4::instantiate-consed-literal '(g2)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 4592))
  (list
    (p4::make-operator-node 
        :name 4593 
        :parent (find-node 4592) 
        :operator (p4::get-operator a2-2))))
 
(setf (p4::nexus-children (find-node 4593))
  (list
    (p4::make-binding-node 
        :name 4594 
        :parent (find-node 4593)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4594))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 4594)
          :precond 
            (p4::instantiate-consed-literal '(p2))))
 
(setf (p4::nexus-children (find-node 4594))
  (list
    (p4::make-goal-node 
        :name 5687 
        :parent (find-node 4594) 
        :goal 
            (p4::instantiate-consed-literal '(g1)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5687))
  (list
    (p4::make-operator-node 
        :name 5688 
        :parent (find-node 5687) 
        :operator (p4::get-operator a2-1))))
 
(setf (p4::nexus-children (find-node 5688))
  (list
    (p4::make-binding-node 
        :name 5689 
        :parent (find-node 5688)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5689))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 5689)
          :precond 
            (p4::instantiate-consed-literal '(p1))))
 
(setf (p4::nexus-children (find-node 5689))
  (list
    (p4::make-goal-node 
        :name 5690 
        :parent (find-node 5689) 
        :goal 
            (p4::instantiate-consed-literal '(p1)) 
        :introducing-operators (list (find-node 5689) )))) 
 
(setf (p4::nexus-children (find-node 5690))
  (list
    (p4::make-operator-node 
        :name 5691 
        :parent (find-node 5690) 
        :operator (p4::get-operator a1-1))))
 
(setf (p4::nexus-children (find-node 5691))
  (list
    (p4::make-binding-node 
        :name 5692 
        :parent (find-node 5691)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5692))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 5692)
          :precond 
            (p4::instantiate-consed-literal '(i1))))
 
(setf (p4::nexus-children (find-node 5692))
  (list
    (p4::make-applied-op-node 
        :name 5693 
        :parent (find-node 5692)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5693))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 5692)
          :precond 
            (p4::instantiate-consed-literal '(i1))))

(setf (p4::a-or-b-node-applied (find-node 5693))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 5693))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 5693))
  (list
    (p4::make-goal-node 
        :name 5698 
        :parent (find-node 5693) 
        :goal 
            (p4::instantiate-consed-literal '(p2)) 
        :introducing-operators (list (find-node 4594) )))) 
 
(setf (p4::nexus-children (find-node 5698))
  (list
    (p4::make-operator-node 
        :name 5699 
        :parent (find-node 5698) 
        :operator (p4::get-operator a1-2))))
 
(setf (p4::nexus-children (find-node 5699))
  (list
    (p4::make-binding-node 
        :name 5700 
        :parent (find-node 5699)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5700))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 5700)
          :precond 
            (p4::instantiate-consed-literal '(i2))))
 
(setf (p4::nexus-children (find-node 5700))
  (list
    (p4::make-applied-op-node 
        :name 5701 
        :parent (find-node 5700)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5701))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 5700)
          :precond 
            (p4::instantiate-consed-literal '(i2))))

(setf (p4::a-or-b-node-applied (find-node 5701))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 5701))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))))))
 
(setf (p4::nexus-children (find-node 5701))
  (list
    (p4::make-goal-node 
        :name 5710 
        :parent (find-node 5701) 
        :goal 
            (p4::instantiate-consed-literal '(p3)) 
        :introducing-operators (list (find-node 2869) )))) 
 
(setf (p4::nexus-children (find-node 5710))
  (list
    (p4::make-operator-node 
        :name 5711 
        :parent (find-node 5710) 
        :operator (p4::get-operator a1-3))))
 
(setf (p4::nexus-children (find-node 5711))
  (list
    (p4::make-binding-node 
        :name 5712 
        :parent (find-node 5711)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5712))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 5712)
          :precond 
            (p4::instantiate-consed-literal '(i3))))
 
(setf (p4::nexus-children (find-node 5712))
  (list
    (p4::make-applied-op-node 
        :name 5713 
        :parent (find-node 5712)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5713))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 5712)
          :precond 
            (p4::instantiate-consed-literal '(i3))))

(setf (p4::a-or-b-node-applied (find-node 5713))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 5713))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i2))))))
 
(setf (p4::nexus-children (find-node 5713))
  (list
    (p4::make-goal-node 
        :name 5726 
        :parent (find-node 5713) 
        :goal 
            (p4::instantiate-consed-literal '(p4)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 5726))
  (list
    (p4::make-operator-node 
        :name 5727 
        :parent (find-node 5726) 
        :operator (p4::get-operator a1-4))))
 
(setf (p4::nexus-children (find-node 5727))
  (list
    (p4::make-binding-node 
        :name 5728 
        :parent (find-node 5727)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5728))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 5728)
          :precond 
            (p4::instantiate-consed-literal '(i4))))
 
(setf (p4::nexus-children (find-node 5728))
  (list
    (p4::make-applied-op-node 
        :name 5729 
        :parent (find-node 5728)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5729))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 5728)
          :precond 
            (p4::instantiate-consed-literal '(i4))))

(setf (p4::a-or-b-node-applied (find-node 5729))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 5729))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i3))))))
 
(setf (p4::nexus-children (find-node 5729))
  (list
    (p4::make-applied-op-node 
        :name 5730 
        :parent (find-node 5729)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5730))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 5689)
          :precond 
            (p4::instantiate-consed-literal '(p1))))

(setf (p4::a-or-b-node-applied (find-node 5730))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 5730))
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
 
(setf (p4::nexus-children (find-node 5730))
  (list
    (p4::make-applied-op-node 
        :name 5731 
        :parent (find-node 5730)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5731))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 4594)
          :precond 
            (p4::instantiate-consed-literal '(p2))))

(setf (p4::a-or-b-node-applied (find-node 5731))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 5731))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 5731))
  (list
    (p4::make-applied-op-node 
        :name 5732 
        :parent (find-node 5731)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5732))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 2869)
          :precond 
            (p4::instantiate-consed-literal '(p3))))

(setf (p4::a-or-b-node-applied (find-node 5732))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 5732))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p2))))))
 
(setf (p4::nexus-children (find-node 5732))
  (list
    (p4::make-applied-op-node 
        :name 5733 
        :parent (find-node 5732)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 5733))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p4))))

(setf (p4::a-or-b-node-applied (find-node 5733))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 5733))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p3))))))
