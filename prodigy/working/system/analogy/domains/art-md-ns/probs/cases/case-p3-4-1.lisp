 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g3))
              (p4::instantiate-consed-literal '(g4))
              (p4::instantiate-consed-literal '(g1)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g3))
              (p4::instantiate-consed-literal '(g4))
              (p4::instantiate-consed-literal '(g1)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 946 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(g4)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 946))
  (list
    (p4::make-operator-node 
        :name 947 
        :parent (find-node 946) 
        :operator (p4::get-operator a2-4))))
 
(setf (p4::nexus-children (find-node 947))
  (list
    (p4::make-binding-node 
        :name 948 
        :parent (find-node 947)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 948))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 948)
          :precond 
            (p4::instantiate-consed-literal '(p4))))
 
(setf (p4::nexus-children (find-node 948))
  (list
    (p4::make-goal-node 
        :name 1109 
        :parent (find-node 948) 
        :goal 
            (p4::instantiate-consed-literal '(g3)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 1109))
  (list
    (p4::make-operator-node 
        :name 1110 
        :parent (find-node 1109) 
        :operator (p4::get-operator a2-3))))
 
(setf (p4::nexus-children (find-node 1110))
  (list
    (p4::make-binding-node 
        :name 1111 
        :parent (find-node 1110)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1111))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 1111)
          :precond 
            (p4::instantiate-consed-literal '(p3))))
 
(setf (p4::nexus-children (find-node 1111))
  (list
    (p4::make-goal-node 
        :name 1285 
        :parent (find-node 1111) 
        :goal 
            (p4::instantiate-consed-literal '(g1)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 1285))
  (list
    (p4::make-operator-node 
        :name 1286 
        :parent (find-node 1285) 
        :operator (p4::get-operator a2-1))))
 
(setf (p4::nexus-children (find-node 1286))
  (list
    (p4::make-binding-node 
        :name 1287 
        :parent (find-node 1286)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1287))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 1287)
          :precond 
            (p4::instantiate-consed-literal '(p1))))
 
(setf (p4::nexus-children (find-node 1287))
  (list
    (p4::make-goal-node 
        :name 1288 
        :parent (find-node 1287) 
        :goal 
            (p4::instantiate-consed-literal '(p1)) 
        :introducing-operators (list (find-node 1287) )))) 
 
(setf (p4::nexus-children (find-node 1288))
  (list
    (p4::make-operator-node 
        :name 1289 
        :parent (find-node 1288) 
        :operator (p4::get-operator a1-1))))
 
(setf (p4::nexus-children (find-node 1289))
  (list
    (p4::make-binding-node 
        :name 1290 
        :parent (find-node 1289)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1290))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 1290)
          :precond 
            (p4::instantiate-consed-literal '(i1))))
 
(setf (p4::nexus-children (find-node 1290))
  (list
    (p4::make-applied-op-node 
        :name 1291 
        :parent (find-node 1290)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1291))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 1290)
          :precond 
            (p4::instantiate-consed-literal '(i1))))

(setf (p4::a-or-b-node-applied (find-node 1291))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 1291))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 1291))
  (list
    (p4::make-goal-node 
        :name 1296 
        :parent (find-node 1291) 
        :goal 
            (p4::instantiate-consed-literal '(p3)) 
        :introducing-operators (list (find-node 1111) )))) 
 
(setf (p4::nexus-children (find-node 1296))
  (list
    (p4::make-operator-node 
        :name 1297 
        :parent (find-node 1296) 
        :operator (p4::get-operator a1-3))))
 
(setf (p4::nexus-children (find-node 1297))
  (list
    (p4::make-binding-node 
        :name 1298 
        :parent (find-node 1297)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1298))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 1298)
          :precond 
            (p4::instantiate-consed-literal '(i3))))
 
(setf (p4::nexus-children (find-node 1298))
  (list
    (p4::make-applied-op-node 
        :name 1299 
        :parent (find-node 1298)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1299))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 1298)
          :precond 
            (p4::instantiate-consed-literal '(i3))))

(setf (p4::a-or-b-node-applied (find-node 1299))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 1299))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))
                 (p4::instantiate-consed-literal '(i2))))))
 
(setf (p4::nexus-children (find-node 1299))
  (list
    (p4::make-goal-node 
        :name 1308 
        :parent (find-node 1299) 
        :goal 
            (p4::instantiate-consed-literal '(p4)) 
        :introducing-operators (list (find-node 948) )))) 
 
(setf (p4::nexus-children (find-node 1308))
  (list
    (p4::make-operator-node 
        :name 1309 
        :parent (find-node 1308) 
        :operator (p4::get-operator a1-4))))
 
(setf (p4::nexus-children (find-node 1309))
  (list
    (p4::make-binding-node 
        :name 1310 
        :parent (find-node 1309)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1310))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 1310)
          :precond 
            (p4::instantiate-consed-literal '(i4))))
 
(setf (p4::nexus-children (find-node 1310))
  (list
    (p4::make-applied-op-node 
        :name 1311 
        :parent (find-node 1310)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1311))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 1310)
          :precond 
            (p4::instantiate-consed-literal '(i4))))

(setf (p4::a-or-b-node-applied (find-node 1311))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 1311))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i3))))))
 
(setf (p4::nexus-children (find-node 1311))
  (list
    (p4::make-applied-op-node 
        :name 1312 
        :parent (find-node 1311)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1312))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 1287)
          :precond 
            (p4::instantiate-consed-literal '(p1))))

(setf (p4::a-or-b-node-applied (find-node 1312))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 1312))
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
 
(setf (p4::nexus-children (find-node 1312))
  (list
    (p4::make-applied-op-node 
        :name 1313 
        :parent (find-node 1312)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1313))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 1111)
          :precond 
            (p4::instantiate-consed-literal '(p3))))

(setf (p4::a-or-b-node-applied (find-node 1313))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 1313))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 1313))
  (list
    (p4::make-applied-op-node 
        :name 1314 
        :parent (find-node 1313)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1314))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 948)
          :precond 
            (p4::instantiate-consed-literal '(p4))))

(setf (p4::a-or-b-node-applied (find-node 1314))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 1314))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p3))))))
