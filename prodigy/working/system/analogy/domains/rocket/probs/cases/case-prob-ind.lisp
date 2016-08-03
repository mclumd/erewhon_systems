 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at hammer locb))
              (p4::instantiate-consed-literal '(at robot locb)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at hammer locb))
              (p4::instantiate-consed-literal '(at robot locb)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(at hammer locb)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator unload-rocket))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside hammer r2))
              (p4::instantiate-consed-literal '(at r2 locb)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator unload-rocket)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'hammer *current-problem-space*)
                    (p4::object-name-to-object 'locb *current-problem-space*)
                    (p4::object-name-to-object 'r2 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside hammer r2))
              (p4::instantiate-consed-literal '(at r2 locb)))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(inside hammer r2)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator load-rocket))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at r2 loca))
              (p4::instantiate-consed-literal '(at hammer loca)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator load-rocket)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'hammer *current-problem-space*)
                    (p4::object-name-to-object 'loca *current-problem-space*)
                    (p4::object-name-to-object 'r2 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at r2 loca))
              (p4::instantiate-consed-literal '(at hammer loca)))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-applied-op-node 
        :name 11 
        :parent (find-node 10)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 11))
      (p4::make-instantiated-op
          :op (p4::get-operator load-rocket)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'hammer *current-problem-space*)
                    (p4::object-name-to-object 'loca *current-problem-space*)
                    (p4::object-name-to-object 'r2 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at r2 loca))
              (p4::instantiate-consed-literal '(at hammer loca)))))

(setf (p4::a-or-b-node-applied (find-node 11))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 11))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(inside hammer r2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at hammer loca))))))
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-goal-node 
        :name 12 
        :parent (find-node 11) 
        :goal 
            (p4::instantiate-consed-literal '(at r2 locb)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 12))
  (list
    (p4::make-operator-node 
        :name 13 
        :parent (find-node 12) 
        :operator (p4::get-operator move-rocket))))
 
(setf (p4::nexus-children (find-node 13))
  (list
    (p4::make-binding-node 
        :name 14 
        :parent (find-node 13)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(at r2 loca))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 14))
      (p4::make-instantiated-op
          :op (p4::get-operator move-rocket)
          :binding-node-back-pointer (find-node 14)
          :values (list 
                    (p4::object-name-to-object 'r2 *current-problem-space*))
          :precond 
            (p4::instantiate-consed-literal '(at r2 loca))))
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-applied-op-node 
        :name 15 
        :parent (find-node 14)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 15))
      (p4::make-instantiated-op
          :op (p4::get-operator move-rocket)
          :binding-node-back-pointer (find-node 14)
          :values (list 
                    (p4::object-name-to-object 'r2 *current-problem-space*))
          :precond 
            (p4::instantiate-consed-literal '(at r2 loca))))

(setf (p4::a-or-b-node-applied (find-node 15))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 15))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at r2 locb)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at r2 loca))))))
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-applied-op-node 
        :name 16 
        :parent (find-node 15)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 16))
      (p4::make-instantiated-op
          :op (p4::get-operator unload-rocket)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'hammer *current-problem-space*)
                    (p4::object-name-to-object 'locb *current-problem-space*)
                    (p4::object-name-to-object 'r2 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside hammer r2))
              (p4::instantiate-consed-literal '(at r2 locb)))))

(setf (p4::a-or-b-node-applied (find-node 16))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 16))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at hammer locb)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(inside hammer r2))))))
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-goal-node 
        :name 17 
        :parent (find-node 16) 
        :goal 
            (p4::instantiate-consed-literal '(at robot locb)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 17))
  (list
    (p4::make-operator-node 
        :name 18 
        :parent (find-node 17) 
        :operator (p4::get-operator unload-rocket))))
 
(setf (p4::nexus-children (find-node 18))
  (list
    (p4::make-binding-node 
        :name 26 
        :parent (find-node 18)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside robot r1))
              (p4::instantiate-consed-literal '(at r1 locb)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 26))
      (p4::make-instantiated-op
          :op (p4::get-operator unload-rocket)
          :binding-node-back-pointer (find-node 26)
          :values (list 
                    (p4::object-name-to-object 'robot *current-problem-space*)
                    (p4::object-name-to-object 'locb *current-problem-space*)
                    (p4::object-name-to-object 'r1 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside robot r1))
              (p4::instantiate-consed-literal '(at r1 locb)))))
 
(setf (p4::nexus-children (find-node 26))
  (list
    (p4::make-goal-node 
        :name 27 
        :parent (find-node 26) 
        :goal 
            (p4::instantiate-consed-literal '(inside robot r1)) 
        :introducing-operators (list (find-node 26) )))) 
 
(setf (p4::nexus-children (find-node 27))
  (list
    (p4::make-operator-node 
        :name 28 
        :parent (find-node 27) 
        :operator (p4::get-operator load-rocket))))
 
(setf (p4::nexus-children (find-node 28))
  (list
    (p4::make-binding-node 
        :name 29 
        :parent (find-node 28)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at r1 loca))
              (p4::instantiate-consed-literal '(at robot loca)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29))
      (p4::make-instantiated-op
          :op (p4::get-operator load-rocket)
          :binding-node-back-pointer (find-node 29)
          :values (list 
                    (p4::object-name-to-object 'robot *current-problem-space*)
                    (p4::object-name-to-object 'loca *current-problem-space*)
                    (p4::object-name-to-object 'r1 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at r1 loca))
              (p4::instantiate-consed-literal '(at robot loca)))))
 
(setf (p4::nexus-children (find-node 29))
  (list
    (p4::make-applied-op-node 
        :name 30 
        :parent (find-node 29)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 30))
      (p4::make-instantiated-op
          :op (p4::get-operator load-rocket)
          :binding-node-back-pointer (find-node 29)
          :values (list 
                    (p4::object-name-to-object 'robot *current-problem-space*)
                    (p4::object-name-to-object 'loca *current-problem-space*)
                    (p4::object-name-to-object 'r1 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at r1 loca))
              (p4::instantiate-consed-literal '(at robot loca)))))

(setf (p4::a-or-b-node-applied (find-node 30))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 30))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(inside robot r1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at robot loca))))))
 
(setf (p4::nexus-children (find-node 30))
  (list
    (p4::make-goal-node 
        :name 31 
        :parent (find-node 30) 
        :goal 
            (p4::instantiate-consed-literal '(at r1 locb)) 
        :introducing-operators (list (find-node 26) )))) 
 
(setf (p4::nexus-children (find-node 31))
  (list
    (p4::make-operator-node 
        :name 32 
        :parent (find-node 31) 
        :operator (p4::get-operator move-rocket))))
 
(setf (p4::nexus-children (find-node 32))
  (list
    (p4::make-binding-node 
        :name 33 
        :parent (find-node 32)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(at r1 loca))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 33))
      (p4::make-instantiated-op
          :op (p4::get-operator move-rocket)
          :binding-node-back-pointer (find-node 33)
          :values (list 
                    (p4::object-name-to-object 'r1 *current-problem-space*))
          :precond 
            (p4::instantiate-consed-literal '(at r1 loca))))
 
(setf (p4::nexus-children (find-node 33))
  (list
    (p4::make-applied-op-node 
        :name 34 
        :parent (find-node 33)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 34))
      (p4::make-instantiated-op
          :op (p4::get-operator move-rocket)
          :binding-node-back-pointer (find-node 33)
          :values (list 
                    (p4::object-name-to-object 'r1 *current-problem-space*))
          :precond 
            (p4::instantiate-consed-literal '(at r1 loca))))

(setf (p4::a-or-b-node-applied (find-node 34))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 34))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at r1 locb)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at r1 loca))))))
 
(setf (p4::nexus-children (find-node 34))
  (list
    (p4::make-applied-op-node 
        :name 35 
        :parent (find-node 34)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 35))
      (p4::make-instantiated-op
          :op (p4::get-operator unload-rocket)
          :binding-node-back-pointer (find-node 26)
          :values (list 
                    (p4::object-name-to-object 'robot *current-problem-space*)
                    (p4::object-name-to-object 'locb *current-problem-space*)
                    (p4::object-name-to-object 'r1 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside robot r1))
              (p4::instantiate-consed-literal '(at r1 locb)))))

(setf (p4::a-or-b-node-applied (find-node 35))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 35))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at robot locb)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(inside robot r1))))))
