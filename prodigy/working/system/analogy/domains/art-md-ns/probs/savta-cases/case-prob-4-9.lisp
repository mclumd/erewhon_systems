 
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
        :name 85 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(g4)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 85))
  (list
    (p4::make-operator-node 
        :name 86 
        :parent (find-node 85) 
        :operator (p4::get-operator a2-4))))
 
(setf (p4::nexus-children (find-node 86))
  (list
    (p4::make-binding-node 
        :name 87 
        :parent (find-node 86)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 87))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 87)
          :precond 
            (p4::instantiate-consed-literal '(p4))))
 
(setf (p4::nexus-children (find-node 87))
  (list
    (p4::make-goal-node 
        :name 96 
        :parent (find-node 87) 
        :goal 
            (p4::instantiate-consed-literal '(p4)) 
        :introducing-operators (list (find-node 87) )))) 
 
(setf (p4::nexus-children (find-node 96))
  (list
    (p4::make-operator-node 
        :name 97 
        :parent (find-node 96) 
        :operator (p4::get-operator a1-4))))
 
(setf (p4::nexus-children (find-node 97))
  (list
    (p4::make-binding-node 
        :name 98 
        :parent (find-node 97)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 98))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 98)
          :precond 
            (p4::instantiate-consed-literal '(i4))))
 
(setf (p4::nexus-children (find-node 98))
  (list
    (p4::make-applied-op-node 
        :name 99 
        :parent (find-node 98)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 99))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 98)
          :precond 
            (p4::instantiate-consed-literal '(i4))))

(setf (p4::a-or-b-node-applied (find-node 99))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 99))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))
                 (p4::instantiate-consed-literal '(i2))
                 (p4::instantiate-consed-literal '(i3))))))
 
(setf (p4::nexus-children (find-node 99))
  (list
    (p4::make-goal-node 
        :name 177 
        :parent (find-node 99) 
        :goal 
            (p4::instantiate-consed-literal '(g5)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 177))
  (list
    (p4::make-operator-node 
        :name 178 
        :parent (find-node 177) 
        :operator (p4::get-operator a2-5))))
 
(setf (p4::nexus-children (find-node 178))
  (list
    (p4::make-binding-node 
        :name 179 
        :parent (find-node 178)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p5))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 179))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-5)
          :binding-node-back-pointer (find-node 179)
          :precond 
            (p4::instantiate-consed-literal '(p5))))
 
(setf (p4::nexus-children (find-node 179))
  (list
    (p4::make-goal-node 
        :name 200 
        :parent (find-node 179) 
        :goal 
            (p4::instantiate-consed-literal '(p5)) 
        :introducing-operators (list (find-node 179) )))) 
 
(setf (p4::nexus-children (find-node 200))
  (list
    (p4::make-operator-node 
        :name 201 
        :parent (find-node 200) 
        :operator (p4::get-operator a1-5))))
 
(setf (p4::nexus-children (find-node 201))
  (list
    (p4::make-binding-node 
        :name 202 
        :parent (find-node 201)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i5))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 202))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-5)
          :binding-node-back-pointer (find-node 202)
          :precond 
            (p4::instantiate-consed-literal '(i5))))
 
(setf (p4::nexus-children (find-node 202))
  (list
    (p4::make-applied-op-node 
        :name 203 
        :parent (find-node 202)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 203))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-5)
          :binding-node-back-pointer (find-node 202)
          :precond 
            (p4::instantiate-consed-literal '(i5))))

(setf (p4::a-or-b-node-applied (find-node 203))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 203))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p5)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i4))))))
 
(setf (p4::nexus-children (find-node 203))
  (list
    (p4::make-goal-node 
        :name 299 
        :parent (find-node 203) 
        :goal 
            (p4::instantiate-consed-literal '(g13)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 299))
  (list
    (p4::make-operator-node 
        :name 300 
        :parent (find-node 299) 
        :operator (p4::get-operator a2-13))))
 
(setf (p4::nexus-children (find-node 300))
  (list
    (p4::make-binding-node 
        :name 301 
        :parent (find-node 300)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p13))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 301))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-13)
          :binding-node-back-pointer (find-node 301)
          :precond 
            (p4::instantiate-consed-literal '(p13))))
 
(setf (p4::nexus-children (find-node 301))
  (list
    (p4::make-goal-node 
        :name 346 
        :parent (find-node 301) 
        :goal 
            (p4::instantiate-consed-literal '(p13)) 
        :introducing-operators (list (find-node 301) )))) 
 
(setf (p4::nexus-children (find-node 346))
  (list
    (p4::make-operator-node 
        :name 347 
        :parent (find-node 346) 
        :operator (p4::get-operator a1-13))))
 
(setf (p4::nexus-children (find-node 347))
  (list
    (p4::make-binding-node 
        :name 348 
        :parent (find-node 347)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i13))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 348))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-13)
          :binding-node-back-pointer (find-node 348)
          :precond 
            (p4::instantiate-consed-literal '(i13))))
 
(setf (p4::nexus-children (find-node 348))
  (list
    (p4::make-applied-op-node 
        :name 349 
        :parent (find-node 348)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 349))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-13)
          :binding-node-back-pointer (find-node 348)
          :precond 
            (p4::instantiate-consed-literal '(i13))))

(setf (p4::a-or-b-node-applied (find-node 349))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 349))
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
 
(setf (p4::nexus-children (find-node 349))
  (list
    (p4::make-applied-op-node 
        :name 350 
        :parent (find-node 349)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 350))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-14)
          :binding-node-back-pointer (find-node 10)
          :precond 
            (p4::instantiate-consed-literal '(i14))))

(setf (p4::a-or-b-node-applied (find-node 350))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 350))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p14)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i13))))))
 
(setf (p4::nexus-children (find-node 350))
  (list
    (p4::make-applied-op-node 
        :name 351 
        :parent (find-node 350)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 351))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 87)
          :precond 
            (p4::instantiate-consed-literal '(p4))))

(setf (p4::a-or-b-node-applied (find-node 351))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 351))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i14))
                 (p4::instantiate-consed-literal '(i15))))))
 
(setf (p4::nexus-children (find-node 351))
  (list
    (p4::make-applied-op-node 
        :name 352 
        :parent (find-node 351)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 352))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-5)
          :binding-node-back-pointer (find-node 179)
          :precond 
            (p4::instantiate-consed-literal '(p5))))

(setf (p4::a-or-b-node-applied (find-node 352))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 352))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g5)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p4))))))
 
(setf (p4::nexus-children (find-node 352))
  (list
    (p4::make-applied-op-node 
        :name 353 
        :parent (find-node 352)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 353))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-13)
          :binding-node-back-pointer (find-node 301)
          :precond 
            (p4::instantiate-consed-literal '(p13))))

(setf (p4::a-or-b-node-applied (find-node 353))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 353))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g13)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p5))))))
 
(setf (p4::nexus-children (find-node 353))
  (list
    (p4::make-applied-op-node 
        :name 354 
        :parent (find-node 353)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 354))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-14)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p14))))

(setf (p4::a-or-b-node-applied (find-node 354))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 354))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g14)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p13))))))
