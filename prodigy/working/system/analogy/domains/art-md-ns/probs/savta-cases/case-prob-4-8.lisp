 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g7))
              (p4::instantiate-consed-literal '(g8))
              (p4::instantiate-consed-literal '(g4))
              (p4::instantiate-consed-literal '(g11)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g7))
              (p4::instantiate-consed-literal '(g8))
              (p4::instantiate-consed-literal '(g4))
              (p4::instantiate-consed-literal '(g11)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(g7)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator a2-7))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p7))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-7)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p7))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(p7)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator a1-7))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i7))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-7)
          :binding-node-back-pointer (find-node 10)
          :precond 
            (p4::instantiate-consed-literal '(i7))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-goal-node 
        :name 2650 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(g8)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 2650))
  (list
    (p4::make-operator-node 
        :name 2651 
        :parent (find-node 2650) 
        :operator (p4::get-operator a2-8))))
 
(setf (p4::nexus-children (find-node 2651))
  (list
    (p4::make-binding-node 
        :name 2652 
        :parent (find-node 2651)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p8))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2652))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-8)
          :binding-node-back-pointer (find-node 2652)
          :precond 
            (p4::instantiate-consed-literal '(p8))))
 
(setf (p4::nexus-children (find-node 2652))
  (list
    (p4::make-goal-node 
        :name 4098 
        :parent (find-node 2652) 
        :goal 
            (p4::instantiate-consed-literal '(p8)) 
        :introducing-operators (list (find-node 2652) )))) 
 
(setf (p4::nexus-children (find-node 4098))
  (list
    (p4::make-operator-node 
        :name 4099 
        :parent (find-node 4098) 
        :operator (p4::get-operator a1-8))))
 
(setf (p4::nexus-children (find-node 4099))
  (list
    (p4::make-binding-node 
        :name 4100 
        :parent (find-node 4099)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i8))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4100))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-8)
          :binding-node-back-pointer (find-node 4100)
          :precond 
            (p4::instantiate-consed-literal '(i8))))
 
(setf (p4::nexus-children (find-node 4100))
  (list
    (p4::make-goal-node 
        :name 4806 
        :parent (find-node 4100) 
        :goal 
            (p4::instantiate-consed-literal '(g4)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 4806))
  (list
    (p4::make-operator-node 
        :name 4807 
        :parent (find-node 4806) 
        :operator (p4::get-operator a2-4))))
 
(setf (p4::nexus-children (find-node 4807))
  (list
    (p4::make-binding-node 
        :name 4808 
        :parent (find-node 4807)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4808))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 4808)
          :precond 
            (p4::instantiate-consed-literal '(p4))))
 
(setf (p4::nexus-children (find-node 4808))
  (list
    (p4::make-goal-node 
        :name 4841 
        :parent (find-node 4808) 
        :goal 
            (p4::instantiate-consed-literal '(p4)) 
        :introducing-operators (list (find-node 4808) )))) 
 
(setf (p4::nexus-children (find-node 4841))
  (list
    (p4::make-operator-node 
        :name 4842 
        :parent (find-node 4841) 
        :operator (p4::get-operator a1-4))))
 
(setf (p4::nexus-children (find-node 4842))
  (list
    (p4::make-binding-node 
        :name 4843 
        :parent (find-node 4842)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4843))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 4843)
          :precond 
            (p4::instantiate-consed-literal '(i4))))
 
(setf (p4::nexus-children (find-node 4843))
  (list
    (p4::make-applied-op-node 
        :name 4844 
        :parent (find-node 4843)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4844))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 4843)
          :precond 
            (p4::instantiate-consed-literal '(i4))))

(setf (p4::a-or-b-node-applied (find-node 4844))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4844))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))
                 (p4::instantiate-consed-literal '(i2))
                 (p4::instantiate-consed-literal '(i3))))))
 
(setf (p4::nexus-children (find-node 4844))
  (list
    (p4::make-applied-op-node 
        :name 4845 
        :parent (find-node 4844)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4845))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-7)
          :binding-node-back-pointer (find-node 10)
          :precond 
            (p4::instantiate-consed-literal '(i7))))

(setf (p4::a-or-b-node-applied (find-node 4845))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4845))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p7)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i4))
                 (p4::instantiate-consed-literal '(i5))
                 (p4::instantiate-consed-literal '(i6))))))
 
(setf (p4::nexus-children (find-node 4845))
  (list
    (p4::make-applied-op-node 
        :name 4846 
        :parent (find-node 4845)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4846))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-8)
          :binding-node-back-pointer (find-node 4100)
          :precond 
            (p4::instantiate-consed-literal '(i8))))

(setf (p4::a-or-b-node-applied (find-node 4846))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4846))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p8)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i7))))))
 
(setf (p4::nexus-children (find-node 4846))
  (list
    (p4::make-goal-node 
        :name 4900 
        :parent (find-node 4846) 
        :goal 
            (p4::instantiate-consed-literal '(g11)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 4900))
  (list
    (p4::make-operator-node 
        :name 4901 
        :parent (find-node 4900) 
        :operator (p4::get-operator a2-11))))
 
(setf (p4::nexus-children (find-node 4901))
  (list
    (p4::make-binding-node 
        :name 4902 
        :parent (find-node 4901)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p11))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4902))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-11)
          :binding-node-back-pointer (find-node 4902)
          :precond 
            (p4::instantiate-consed-literal '(p11))))
 
(setf (p4::nexus-children (find-node 4902))
  (list
    (p4::make-goal-node 
        :name 4931 
        :parent (find-node 4902) 
        :goal 
            (p4::instantiate-consed-literal '(p11)) 
        :introducing-operators (list (find-node 4902) )))) 
 
(setf (p4::nexus-children (find-node 4931))
  (list
    (p4::make-operator-node 
        :name 4932 
        :parent (find-node 4931) 
        :operator (p4::get-operator a1-11))))
 
(setf (p4::nexus-children (find-node 4932))
  (list
    (p4::make-binding-node 
        :name 4933 
        :parent (find-node 4932)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i11))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4933))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-11)
          :binding-node-back-pointer (find-node 4933)
          :precond 
            (p4::instantiate-consed-literal '(i11))))
 
(setf (p4::nexus-children (find-node 4933))
  (list
    (p4::make-applied-op-node 
        :name 4934 
        :parent (find-node 4933)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4934))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-11)
          :binding-node-back-pointer (find-node 4933)
          :precond 
            (p4::instantiate-consed-literal '(i11))))

(setf (p4::a-or-b-node-applied (find-node 4934))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4934))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p11)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i8))
                 (p4::instantiate-consed-literal '(i9))
                 (p4::instantiate-consed-literal '(i10))))))
 
(setf (p4::nexus-children (find-node 4934))
  (list
    (p4::make-applied-op-node 
        :name 4935 
        :parent (find-node 4934)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4935))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 4808)
          :precond 
            (p4::instantiate-consed-literal '(p4))))

(setf (p4::a-or-b-node-applied (find-node 4935))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4935))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i11))
                 (p4::instantiate-consed-literal '(i12))
                 (p4::instantiate-consed-literal '(i13))
                 (p4::instantiate-consed-literal '(i14))
                 (p4::instantiate-consed-literal '(i15))))))
 
(setf (p4::nexus-children (find-node 4935))
  (list
    (p4::make-applied-op-node 
        :name 4936 
        :parent (find-node 4935)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4936))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-7)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p7))))

(setf (p4::a-or-b-node-applied (find-node 4936))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4936))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g7)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p4))))))
 
(setf (p4::nexus-children (find-node 4936))
  (list
    (p4::make-applied-op-node 
        :name 4937 
        :parent (find-node 4936)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4937))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-8)
          :binding-node-back-pointer (find-node 2652)
          :precond 
            (p4::instantiate-consed-literal '(p8))))

(setf (p4::a-or-b-node-applied (find-node 4937))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4937))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g8)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p7))))))
 
(setf (p4::nexus-children (find-node 4937))
  (list
    (p4::make-applied-op-node 
        :name 4938 
        :parent (find-node 4937)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4938))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-11)
          :binding-node-back-pointer (find-node 4902)
          :precond 
            (p4::instantiate-consed-literal '(p11))))

(setf (p4::a-or-b-node-applied (find-node 4938))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4938))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g11)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p8))))))
