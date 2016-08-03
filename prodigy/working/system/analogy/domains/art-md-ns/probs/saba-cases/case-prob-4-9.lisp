 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g14))
              (p4::instantiate-consed-literal '(g4))
              (p4::instantiate-consed-literal '(g5))
              (p4::instantiate-consed-literal '(g13)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g14))
              (p4::instantiate-consed-literal '(g4))
              (p4::instantiate-consed-literal '(g5))
              (p4::instantiate-consed-literal '(g13)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(g14)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator a2-14))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p14))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-14)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p14))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(p14)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator a1-14))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i14))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-14)
          :binding-node-back-pointer (find-node 10)
          :precond 
            (p4::instantiate-consed-literal '(i14))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-goal-node 
        :name 11 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(g4)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-operator-node 
        :name 12 
        :parent (find-node 11) 
        :operator (p4::get-operator a2-4))))
 
(setf (p4::nexus-children (find-node 12))
  (list
    (p4::make-binding-node 
        :name 13 
        :parent (find-node 12)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 13))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 13)
          :precond 
            (p4::instantiate-consed-literal '(p4))))
 
(setf (p4::nexus-children (find-node 13))
  (list
    (p4::make-goal-node 
        :name 14 
        :parent (find-node 13) 
        :goal 
            (p4::instantiate-consed-literal '(p4)) 
        :introducing-operators (list (find-node 13) )))) 
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-operator-node 
        :name 15 
        :parent (find-node 14) 
        :operator (p4::get-operator a1-4))))
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-binding-node 
        :name 16 
        :parent (find-node 15)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 16))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 16)
          :precond 
            (p4::instantiate-consed-literal '(i4))))
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-goal-node 
        :name 17 
        :parent (find-node 16) 
        :goal 
            (p4::instantiate-consed-literal '(g5)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 17))
  (list
    (p4::make-operator-node 
        :name 18 
        :parent (find-node 17) 
        :operator (p4::get-operator a2-5))))
 
(setf (p4::nexus-children (find-node 18))
  (list
    (p4::make-binding-node 
        :name 19 
        :parent (find-node 18)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p5))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 19))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-5)
          :binding-node-back-pointer (find-node 19)
          :precond 
            (p4::instantiate-consed-literal '(p5))))
 
(setf (p4::nexus-children (find-node 19))
  (list
    (p4::make-goal-node 
        :name 20 
        :parent (find-node 19) 
        :goal 
            (p4::instantiate-consed-literal '(p5)) 
        :introducing-operators (list (find-node 19) )))) 
 
(setf (p4::nexus-children (find-node 20))
  (list
    (p4::make-operator-node 
        :name 21 
        :parent (find-node 20) 
        :operator (p4::get-operator a1-5))))
 
(setf (p4::nexus-children (find-node 21))
  (list
    (p4::make-binding-node 
        :name 22 
        :parent (find-node 21)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i5))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 22))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-5)
          :binding-node-back-pointer (find-node 22)
          :precond 
            (p4::instantiate-consed-literal '(i5))))
 
(setf (p4::nexus-children (find-node 22))
  (list
    (p4::make-goal-node 
        :name 23 
        :parent (find-node 22) 
        :goal 
            (p4::instantiate-consed-literal '(g13)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 23))
  (list
    (p4::make-operator-node 
        :name 24 
        :parent (find-node 23) 
        :operator (p4::get-operator a2-13))))
 
(setf (p4::nexus-children (find-node 24))
  (list
    (p4::make-binding-node 
        :name 25 
        :parent (find-node 24)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p13))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 25))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-13)
          :binding-node-back-pointer (find-node 25)
          :precond 
            (p4::instantiate-consed-literal '(p13))))
 
(setf (p4::nexus-children (find-node 25))
  (list
    (p4::make-goal-node 
        :name 26 
        :parent (find-node 25) 
        :goal 
            (p4::instantiate-consed-literal '(p13)) 
        :introducing-operators (list (find-node 25) )))) 
 
(setf (p4::nexus-children (find-node 26))
  (list
    (p4::make-operator-node 
        :name 27 
        :parent (find-node 26) 
        :operator (p4::get-operator a1-13))))
 
(setf (p4::nexus-children (find-node 27))
  (list
    (p4::make-binding-node 
        :name 28 
        :parent (find-node 27)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i13))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 28))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-13)
          :binding-node-back-pointer (find-node 28)
          :precond 
            (p4::instantiate-consed-literal '(i13))))
 
(setf (p4::nexus-children (find-node 28))
  (list
    (p4::make-applied-op-node 
        :name 29 
        :parent (find-node 28)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 16)
          :precond 
            (p4::instantiate-consed-literal '(i4))))

(setf (p4::a-or-b-node-applied (find-node 29))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 29))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))
                 (p4::instantiate-consed-literal '(i2))
                 (p4::instantiate-consed-literal '(i3))))))
 
(setf (p4::nexus-children (find-node 29))
  (list
    (p4::make-applied-op-node 
        :name 30 
        :parent (find-node 29)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 30))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-5)
          :binding-node-back-pointer (find-node 22)
          :precond 
            (p4::instantiate-consed-literal '(i5))))

(setf (p4::a-or-b-node-applied (find-node 30))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 30))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p5)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i4))))))
 
(setf (p4::nexus-children (find-node 30))
  (list
    (p4::make-applied-op-node 
        :name 31 
        :parent (find-node 30)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 31))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-13)
          :binding-node-back-pointer (find-node 28)
          :precond 
            (p4::instantiate-consed-literal '(i13))))

(setf (p4::a-or-b-node-applied (find-node 31))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 31))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p13)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i5))
                 (p4::instantiate-consed-literal '(i6))
                 (p4::instantiate-consed-literal '(i7))
                 (p4::instantiate-consed-literal '(i8))
                 (p4::instantiate-consed-literal '(i9))
                 (p4::instantiate-consed-literal '(i10))
                 (p4::instantiate-consed-literal '(i11))
                 (p4::instantiate-consed-literal '(i12))))))
 
(setf (p4::nexus-children (find-node 31))
  (list
    (p4::make-applied-op-node 
        :name 32 
        :parent (find-node 31)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 32))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-14)
          :binding-node-back-pointer (find-node 10)
          :precond 
            (p4::instantiate-consed-literal '(i14))))

(setf (p4::a-or-b-node-applied (find-node 32))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 32))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p14)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i13))))))
 
(setf (p4::nexus-children (find-node 32))
  (list
    (p4::make-applied-op-node 
        :name 33 
        :parent (find-node 32)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 33))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 13)
          :precond 
            (p4::instantiate-consed-literal '(p4))))

(setf (p4::a-or-b-node-applied (find-node 33))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 33))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i14))
                 (p4::instantiate-consed-literal '(i15))))))
 
(setf (p4::nexus-children (find-node 33))
  (list
    (p4::make-applied-op-node 
        :name 34 
        :parent (find-node 33)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 34))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-5)
          :binding-node-back-pointer (find-node 19)
          :precond 
            (p4::instantiate-consed-literal '(p5))))

(setf (p4::a-or-b-node-applied (find-node 34))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 34))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g5)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p4))))))
 
(setf (p4::nexus-children (find-node 34))
  (list
    (p4::make-applied-op-node 
        :name 35 
        :parent (find-node 34)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 35))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-13)
          :binding-node-back-pointer (find-node 25)
          :precond 
            (p4::instantiate-consed-literal '(p13))))

(setf (p4::a-or-b-node-applied (find-node 35))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 35))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g13)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p5))))))
 
(setf (p4::nexus-children (find-node 35))
  (list
    (p4::make-applied-op-node 
        :name 36 
        :parent (find-node 35)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 36))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-14)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p14))))

(setf (p4::a-or-b-node-applied (find-node 36))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 36))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g14)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p13))))))
