 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g12))
              (p4::instantiate-consed-literal '(g3))
              (p4::instantiate-consed-literal '(g11))
              (p4::instantiate-consed-literal '(g9)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g12))
              (p4::instantiate-consed-literal '(g3))
              (p4::instantiate-consed-literal '(g11))
              (p4::instantiate-consed-literal '(g9)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(g12)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator a2-12))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p12))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-12)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p12))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(p12)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator a1-12))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i12))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-12)
          :binding-node-back-pointer (find-node 10)
          :precond 
            (p4::instantiate-consed-literal '(i12))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-goal-node 
        :name 85 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(g3)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 85))
  (list
    (p4::make-operator-node 
        :name 86 
        :parent (find-node 85) 
        :operator (p4::get-operator a2-3))))
 
(setf (p4::nexus-children (find-node 86))
  (list
    (p4::make-binding-node 
        :name 87 
        :parent (find-node 86)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 87))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 87)
          :precond 
            (p4::instantiate-consed-literal '(p3))))
 
(setf (p4::nexus-children (find-node 87))
  (list
    (p4::make-goal-node 
        :name 96 
        :parent (find-node 87) 
        :goal 
            (p4::instantiate-consed-literal '(p3)) 
        :introducing-operators (list (find-node 87) )))) 
 
(setf (p4::nexus-children (find-node 96))
  (list
    (p4::make-operator-node 
        :name 97 
        :parent (find-node 96) 
        :operator (p4::get-operator a1-3))))
 
(setf (p4::nexus-children (find-node 97))
  (list
    (p4::make-binding-node 
        :name 98 
        :parent (find-node 97)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 98))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 98)
          :precond 
            (p4::instantiate-consed-literal '(i3))))
 
(setf (p4::nexus-children (find-node 98))
  (list
    (p4::make-applied-op-node 
        :name 99 
        :parent (find-node 98)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 99))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 98)
          :precond 
            (p4::instantiate-consed-literal '(i3))))

(setf (p4::a-or-b-node-applied (find-node 99))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 99))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))
                 (p4::instantiate-consed-literal '(i2))))))
 
(setf (p4::nexus-children (find-node 99))
  (list
    (p4::make-goal-node 
        :name 177 
        :parent (find-node 99) 
        :goal 
            (p4::instantiate-consed-literal '(g11)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 177))
  (list
    (p4::make-operator-node 
        :name 178 
        :parent (find-node 177) 
        :operator (p4::get-operator a2-11))))
 
(setf (p4::nexus-children (find-node 178))
  (list
    (p4::make-binding-node 
        :name 179 
        :parent (find-node 178)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p11))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 179))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-11)
          :binding-node-back-pointer (find-node 179)
          :precond 
            (p4::instantiate-consed-literal '(p11))))
 
(setf (p4::nexus-children (find-node 179))
  (list
    (p4::make-goal-node 
        :name 200 
        :parent (find-node 179) 
        :goal 
            (p4::instantiate-consed-literal '(p11)) 
        :introducing-operators (list (find-node 179) )))) 
 
(setf (p4::nexus-children (find-node 200))
  (list
    (p4::make-operator-node 
        :name 201 
        :parent (find-node 200) 
        :operator (p4::get-operator a1-11))))
 
(setf (p4::nexus-children (find-node 201))
  (list
    (p4::make-binding-node 
        :name 202 
        :parent (find-node 201)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i11))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 202))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-11)
          :binding-node-back-pointer (find-node 202)
          :precond 
            (p4::instantiate-consed-literal '(i11))))
 
(setf (p4::nexus-children (find-node 202))
  (list
    (p4::make-goal-node 
        :name 355 
        :parent (find-node 202) 
        :goal 
            (p4::instantiate-consed-literal '(g9)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 355))
  (list
    (p4::make-operator-node 
        :name 356 
        :parent (find-node 355) 
        :operator (p4::get-operator a2-9))))
 
(setf (p4::nexus-children (find-node 356))
  (list
    (p4::make-binding-node 
        :name 357 
        :parent (find-node 356)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p9))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 357))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-9)
          :binding-node-back-pointer (find-node 357)
          :precond 
            (p4::instantiate-consed-literal '(p9))))
 
(setf (p4::nexus-children (find-node 357))
  (list
    (p4::make-goal-node 
        :name 426 
        :parent (find-node 357) 
        :goal 
            (p4::instantiate-consed-literal '(p9)) 
        :introducing-operators (list (find-node 357) )))) 
 
(setf (p4::nexus-children (find-node 426))
  (list
    (p4::make-operator-node 
        :name 427 
        :parent (find-node 426) 
        :operator (p4::get-operator a1-9))))
 
(setf (p4::nexus-children (find-node 427))
  (list
    (p4::make-binding-node 
        :name 428 
        :parent (find-node 427)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i9))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 428))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-9)
          :binding-node-back-pointer (find-node 428)
          :precond 
            (p4::instantiate-consed-literal '(i9))))
 
(setf (p4::nexus-children (find-node 428))
  (list
    (p4::make-applied-op-node 
        :name 429 
        :parent (find-node 428)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 429))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-9)
          :binding-node-back-pointer (find-node 428)
          :precond 
            (p4::instantiate-consed-literal '(i9))))

(setf (p4::a-or-b-node-applied (find-node 429))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 429))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p9)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i3))
                 (p4::instantiate-consed-literal '(i4))
                 (p4::instantiate-consed-literal '(i5))
                 (p4::instantiate-consed-literal '(i6))
                 (p4::instantiate-consed-literal '(i7))
                 (p4::instantiate-consed-literal '(i8))))))
 
(setf (p4::nexus-children (find-node 429))
  (list
    (p4::make-applied-op-node 
        :name 430 
        :parent (find-node 429)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 430))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-11)
          :binding-node-back-pointer (find-node 202)
          :precond 
            (p4::instantiate-consed-literal '(i11))))

(setf (p4::a-or-b-node-applied (find-node 430))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 430))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p11)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i9))
                 (p4::instantiate-consed-literal '(i10))))))
 
(setf (p4::nexus-children (find-node 430))
  (list
    (p4::make-applied-op-node 
        :name 431 
        :parent (find-node 430)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 431))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-12)
          :binding-node-back-pointer (find-node 10)
          :precond 
            (p4::instantiate-consed-literal '(i12))))

(setf (p4::a-or-b-node-applied (find-node 431))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 431))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p12)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i11))))))
 
(setf (p4::nexus-children (find-node 431))
  (list
    (p4::make-applied-op-node 
        :name 432 
        :parent (find-node 431)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 432))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 87)
          :precond 
            (p4::instantiate-consed-literal '(p3))))

(setf (p4::a-or-b-node-applied (find-node 432))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 432))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i12))
                 (p4::instantiate-consed-literal '(i13))
                 (p4::instantiate-consed-literal '(i14))
                 (p4::instantiate-consed-literal '(i15))))))
 
(setf (p4::nexus-children (find-node 432))
  (list
    (p4::make-applied-op-node 
        :name 433 
        :parent (find-node 432)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 433))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-9)
          :binding-node-back-pointer (find-node 357)
          :precond 
            (p4::instantiate-consed-literal '(p9))))

(setf (p4::a-or-b-node-applied (find-node 433))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 433))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g9)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p3))))))
 
(setf (p4::nexus-children (find-node 433))
  (list
    (p4::make-applied-op-node 
        :name 434 
        :parent (find-node 433)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 434))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-11)
          :binding-node-back-pointer (find-node 179)
          :precond 
            (p4::instantiate-consed-literal '(p11))))

(setf (p4::a-or-b-node-applied (find-node 434))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 434))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g11)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p9))))))
 
(setf (p4::nexus-children (find-node 434))
  (list
    (p4::make-applied-op-node 
        :name 435 
        :parent (find-node 434)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 435))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-12)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p12))))

(setf (p4::a-or-b-node-applied (find-node 435))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 435))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g12)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p11))))))
