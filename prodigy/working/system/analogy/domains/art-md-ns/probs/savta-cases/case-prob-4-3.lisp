 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g5))
              (p4::instantiate-consed-literal '(g12))
              (p4::instantiate-consed-literal '(g3))
              (p4::instantiate-consed-literal '(g11)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g5))
              (p4::instantiate-consed-literal '(g12))
              (p4::instantiate-consed-literal '(g3))
              (p4::instantiate-consed-literal '(g11)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(g5)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator a2-5))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p5))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-5)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p5))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(p5)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator a1-5))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i5))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-5)
          :binding-node-back-pointer (find-node 10)
          :precond 
            (p4::instantiate-consed-literal '(i5))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-goal-node 
        :name 2650 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(g12)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 2650))
  (list
    (p4::make-operator-node 
        :name 2651 
        :parent (find-node 2650) 
        :operator (p4::get-operator a2-12))))
 
(setf (p4::nexus-children (find-node 2651))
  (list
    (p4::make-binding-node 
        :name 2652 
        :parent (find-node 2651)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p12))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 2652))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-12)
          :binding-node-back-pointer (find-node 2652)
          :precond 
            (p4::instantiate-consed-literal '(p12))))
 
(setf (p4::nexus-children (find-node 2652))
  (list
    (p4::make-goal-node 
        :name 3776 
        :parent (find-node 2652) 
        :goal 
            (p4::instantiate-consed-literal '(p12)) 
        :introducing-operators (list (find-node 2652) )))) 
 
(setf (p4::nexus-children (find-node 3776))
  (list
    (p4::make-operator-node 
        :name 3777 
        :parent (find-node 3776) 
        :operator (p4::get-operator a1-12))))
 
(setf (p4::nexus-children (find-node 3777))
  (list
    (p4::make-binding-node 
        :name 3778 
        :parent (find-node 3777)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i12))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 3778))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-12)
          :binding-node-back-pointer (find-node 3778)
          :precond 
            (p4::instantiate-consed-literal '(i12))))
 
(setf (p4::nexus-children (find-node 3778))
  (list
    (p4::make-goal-node 
        :name 4162 
        :parent (find-node 3778) 
        :goal 
            (p4::instantiate-consed-literal '(g3)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 4162))
  (list
    (p4::make-operator-node 
        :name 4163 
        :parent (find-node 4162) 
        :operator (p4::get-operator a2-3))))
 
(setf (p4::nexus-children (find-node 4163))
  (list
    (p4::make-binding-node 
        :name 4164 
        :parent (find-node 4163)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4164))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 4164)
          :precond 
            (p4::instantiate-consed-literal '(p3))))
 
(setf (p4::nexus-children (find-node 4164))
  (list
    (p4::make-goal-node 
        :name 4197 
        :parent (find-node 4164) 
        :goal 
            (p4::instantiate-consed-literal '(p3)) 
        :introducing-operators (list (find-node 4164) )))) 
 
(setf (p4::nexus-children (find-node 4197))
  (list
    (p4::make-operator-node 
        :name 4198 
        :parent (find-node 4197) 
        :operator (p4::get-operator a1-3))))
 
(setf (p4::nexus-children (find-node 4198))
  (list
    (p4::make-binding-node 
        :name 4199 
        :parent (find-node 4198)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4199))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 4199)
          :precond 
            (p4::instantiate-consed-literal '(i3))))
 
(setf (p4::nexus-children (find-node 4199))
  (list
    (p4::make-applied-op-node 
        :name 4200 
        :parent (find-node 4199)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4200))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 4199)
          :precond 
            (p4::instantiate-consed-literal '(i3))))

(setf (p4::a-or-b-node-applied (find-node 4200))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4200))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))
                 (p4::instantiate-consed-literal '(i2))))))
 
(setf (p4::nexus-children (find-node 4200))
  (list
    (p4::make-applied-op-node 
        :name 4201 
        :parent (find-node 4200)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4201))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-5)
          :binding-node-back-pointer (find-node 10)
          :precond 
            (p4::instantiate-consed-literal '(i5))))

(setf (p4::a-or-b-node-applied (find-node 4201))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4201))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p5)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i3))
                 (p4::instantiate-consed-literal '(i4))))))
 
(setf (p4::nexus-children (find-node 4201))
  (list
    (p4::make-goal-node 
        :name 4297 
        :parent (find-node 4201) 
        :goal 
            (p4::instantiate-consed-literal '(g11)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 4297))
  (list
    (p4::make-operator-node 
        :name 4298 
        :parent (find-node 4297) 
        :operator (p4::get-operator a2-11))))
 
(setf (p4::nexus-children (find-node 4298))
  (list
    (p4::make-binding-node 
        :name 4299 
        :parent (find-node 4298)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p11))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4299))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-11)
          :binding-node-back-pointer (find-node 4299)
          :precond 
            (p4::instantiate-consed-literal '(p11))))
 
(setf (p4::nexus-children (find-node 4299))
  (list
    (p4::make-goal-node 
        :name 4344 
        :parent (find-node 4299) 
        :goal 
            (p4::instantiate-consed-literal '(p11)) 
        :introducing-operators (list (find-node 4299) )))) 
 
(setf (p4::nexus-children (find-node 4344))
  (list
    (p4::make-operator-node 
        :name 4345 
        :parent (find-node 4344) 
        :operator (p4::get-operator a1-11))))
 
(setf (p4::nexus-children (find-node 4345))
  (list
    (p4::make-binding-node 
        :name 4346 
        :parent (find-node 4345)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i11))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4346))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-11)
          :binding-node-back-pointer (find-node 4346)
          :precond 
            (p4::instantiate-consed-literal '(i11))))
 
(setf (p4::nexus-children (find-node 4346))
  (list
    (p4::make-applied-op-node 
        :name 4347 
        :parent (find-node 4346)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4347))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-11)
          :binding-node-back-pointer (find-node 4346)
          :precond 
            (p4::instantiate-consed-literal '(i11))))

(setf (p4::a-or-b-node-applied (find-node 4347))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4347))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p11)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i5))
                 (p4::instantiate-consed-literal '(i6))
                 (p4::instantiate-consed-literal '(i7))
                 (p4::instantiate-consed-literal '(i8))
                 (p4::instantiate-consed-literal '(i9))
                 (p4::instantiate-consed-literal '(i10))))))
 
(setf (p4::nexus-children (find-node 4347))
  (list
    (p4::make-applied-op-node 
        :name 4348 
        :parent (find-node 4347)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4348))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-12)
          :binding-node-back-pointer (find-node 3778)
          :precond 
            (p4::instantiate-consed-literal '(i12))))

(setf (p4::a-or-b-node-applied (find-node 4348))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4348))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p12)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i11))))))
 
(setf (p4::nexus-children (find-node 4348))
  (list
    (p4::make-applied-op-node 
        :name 4349 
        :parent (find-node 4348)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4349))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 4164)
          :precond 
            (p4::instantiate-consed-literal '(p3))))

(setf (p4::a-or-b-node-applied (find-node 4349))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4349))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i12))
                 (p4::instantiate-consed-literal '(i13))
                 (p4::instantiate-consed-literal '(i14))
                 (p4::instantiate-consed-literal '(i15))))))
 
(setf (p4::nexus-children (find-node 4349))
  (list
    (p4::make-applied-op-node 
        :name 4350 
        :parent (find-node 4349)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4350))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-5)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p5))))

(setf (p4::a-or-b-node-applied (find-node 4350))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4350))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g5)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p3))))))
 
(setf (p4::nexus-children (find-node 4350))
  (list
    (p4::make-applied-op-node 
        :name 4351 
        :parent (find-node 4350)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4351))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-11)
          :binding-node-back-pointer (find-node 4299)
          :precond 
            (p4::instantiate-consed-literal '(p11))))

(setf (p4::a-or-b-node-applied (find-node 4351))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4351))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g11)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p5))))))
 
(setf (p4::nexus-children (find-node 4351))
  (list
    (p4::make-applied-op-node 
        :name 4352 
        :parent (find-node 4351)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4352))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-12)
          :binding-node-back-pointer (find-node 2652)
          :precond 
            (p4::instantiate-consed-literal '(p12))))

(setf (p4::a-or-b-node-applied (find-node 4352))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 4352))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g12)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p11))))))
