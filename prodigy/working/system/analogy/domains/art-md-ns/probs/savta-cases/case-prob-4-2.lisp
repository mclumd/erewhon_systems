 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g3))
              (p4::instantiate-consed-literal '(g8))
              (p4::instantiate-consed-literal '(g15))
              (p4::instantiate-consed-literal '(g9)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g3))
              (p4::instantiate-consed-literal '(g8))
              (p4::instantiate-consed-literal '(g15))
              (p4::instantiate-consed-literal '(g9)))))
 
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
    (p4::make-applied-op-node 
        :name 11 
        :parent (find-node 10)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 11))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 10)
          :precond 
            (p4::instantiate-consed-literal '(i3))))

(setf (p4::a-or-b-node-applied (find-node 11))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 11))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))
                 (p4::instantiate-consed-literal '(i2))))))
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-goal-node 
        :name 55 
        :parent (find-node 11) 
        :goal 
            (p4::instantiate-consed-literal '(g8)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 55))
  (list
    (p4::make-operator-node 
        :name 56 
        :parent (find-node 55) 
        :operator (p4::get-operator a2-8))))
 
(setf (p4::nexus-children (find-node 56))
  (list
    (p4::make-binding-node 
        :name 57 
        :parent (find-node 56)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p8))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 57))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-8)
          :binding-node-back-pointer (find-node 57)
          :precond 
            (p4::instantiate-consed-literal '(p8))))
 
(setf (p4::nexus-children (find-node 57))
  (list
    (p4::make-goal-node 
        :name 62 
        :parent (find-node 57) 
        :goal 
            (p4::instantiate-consed-literal '(p8)) 
        :introducing-operators (list (find-node 57) )))) 
 
(setf (p4::nexus-children (find-node 62))
  (list
    (p4::make-operator-node 
        :name 63 
        :parent (find-node 62) 
        :operator (p4::get-operator a1-8))))
 
(setf (p4::nexus-children (find-node 63))
  (list
    (p4::make-binding-node 
        :name 64 
        :parent (find-node 63)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i8))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 64))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-8)
          :binding-node-back-pointer (find-node 64)
          :precond 
            (p4::instantiate-consed-literal '(i8))))
 
(setf (p4::nexus-children (find-node 64))
  (list
    (p4::make-applied-op-node 
        :name 65 
        :parent (find-node 64)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 65))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-8)
          :binding-node-back-pointer (find-node 64)
          :precond 
            (p4::instantiate-consed-literal '(i8))))

(setf (p4::a-or-b-node-applied (find-node 65))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 65))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p8)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i3))
                 (p4::instantiate-consed-literal '(i4))
                 (p4::instantiate-consed-literal '(i5))
                 (p4::instantiate-consed-literal '(i6))
                 (p4::instantiate-consed-literal '(i7))))))
 
(setf (p4::nexus-children (find-node 65))
  (list
    (p4::make-goal-node 
        :name 117 
        :parent (find-node 65) 
        :goal 
            (p4::instantiate-consed-literal '(g15)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 117))
  (list
    (p4::make-operator-node 
        :name 118 
        :parent (find-node 117) 
        :operator (p4::get-operator a2-15))))
 
(setf (p4::nexus-children (find-node 118))
  (list
    (p4::make-binding-node 
        :name 119 
        :parent (find-node 118)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p15))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 119))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-15)
          :binding-node-back-pointer (find-node 119)
          :precond 
            (p4::instantiate-consed-literal '(p15))))
 
(setf (p4::nexus-children (find-node 119))
  (list
    (p4::make-goal-node 
        :name 132 
        :parent (find-node 119) 
        :goal 
            (p4::instantiate-consed-literal '(p15)) 
        :introducing-operators (list (find-node 119) )))) 
 
(setf (p4::nexus-children (find-node 132))
  (list
    (p4::make-operator-node 
        :name 133 
        :parent (find-node 132) 
        :operator (p4::get-operator a1-15))))
 
(setf (p4::nexus-children (find-node 133))
  (list
    (p4::make-binding-node 
        :name 134 
        :parent (find-node 133)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i15))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 134))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-15)
          :binding-node-back-pointer (find-node 134)
          :precond 
            (p4::instantiate-consed-literal '(i15))))
 
(setf (p4::nexus-children (find-node 134))
  (list
    (p4::make-goal-node 
        :name 228 
        :parent (find-node 134) 
        :goal 
            (p4::instantiate-consed-literal '(g9)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 228))
  (list
    (p4::make-operator-node 
        :name 229 
        :parent (find-node 228) 
        :operator (p4::get-operator a2-9))))
 
(setf (p4::nexus-children (find-node 229))
  (list
    (p4::make-binding-node 
        :name 230 
        :parent (find-node 229)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p9))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 230))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-9)
          :binding-node-back-pointer (find-node 230)
          :precond 
            (p4::instantiate-consed-literal '(p9))))
 
(setf (p4::nexus-children (find-node 230))
  (list
    (p4::make-goal-node 
        :name 275 
        :parent (find-node 230) 
        :goal 
            (p4::instantiate-consed-literal '(p9)) 
        :introducing-operators (list (find-node 230) )))) 
 
(setf (p4::nexus-children (find-node 275))
  (list
    (p4::make-operator-node 
        :name 276 
        :parent (find-node 275) 
        :operator (p4::get-operator a1-9))))
 
(setf (p4::nexus-children (find-node 276))
  (list
    (p4::make-binding-node 
        :name 277 
        :parent (find-node 276)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i9))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 277))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-9)
          :binding-node-back-pointer (find-node 277)
          :precond 
            (p4::instantiate-consed-literal '(i9))))
 
(setf (p4::nexus-children (find-node 277))
  (list
    (p4::make-applied-op-node 
        :name 278 
        :parent (find-node 277)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 278))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-9)
          :binding-node-back-pointer (find-node 277)
          :precond 
            (p4::instantiate-consed-literal '(i9))))

(setf (p4::a-or-b-node-applied (find-node 278))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 278))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p9)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i8))))))
 
(setf (p4::nexus-children (find-node 278))
  (list
    (p4::make-applied-op-node 
        :name 279 
        :parent (find-node 278)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 279))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-15)
          :binding-node-back-pointer (find-node 134)
          :precond 
            (p4::instantiate-consed-literal '(i15))))

(setf (p4::a-or-b-node-applied (find-node 279))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 279))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p15)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i9))
                 (p4::instantiate-consed-literal '(i10))
                 (p4::instantiate-consed-literal '(i11))
                 (p4::instantiate-consed-literal '(i12))
                 (p4::instantiate-consed-literal '(i13))
                 (p4::instantiate-consed-literal '(i14))))))
 
(setf (p4::nexus-children (find-node 279))
  (list
    (p4::make-applied-op-node 
        :name 280 
        :parent (find-node 279)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 280))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 7)
          :precond 
            (p4::instantiate-consed-literal '(p3))))

(setf (p4::a-or-b-node-applied (find-node 280))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 280))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i15))))))
 
(setf (p4::nexus-children (find-node 280))
  (list
    (p4::make-applied-op-node 
        :name 281 
        :parent (find-node 280)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 281))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-8)
          :binding-node-back-pointer (find-node 57)
          :precond 
            (p4::instantiate-consed-literal '(p8))))

(setf (p4::a-or-b-node-applied (find-node 281))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 281))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g8)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p3))))))
 
(setf (p4::nexus-children (find-node 281))
  (list
    (p4::make-applied-op-node 
        :name 282 
        :parent (find-node 281)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 282))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-9)
          :binding-node-back-pointer (find-node 230)
          :precond 
            (p4::instantiate-consed-literal '(p9))))

(setf (p4::a-or-b-node-applied (find-node 282))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 282))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g9)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p8))))))
 
(setf (p4::nexus-children (find-node 282))
  (list
    (p4::make-applied-op-node 
        :name 283 
        :parent (find-node 282)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 283))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-15)
          :binding-node-back-pointer (find-node 119)
          :precond 
            (p4::instantiate-consed-literal '(p15))))

(setf (p4::a-or-b-node-applied (find-node 283))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 283))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g15)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p9))))))
