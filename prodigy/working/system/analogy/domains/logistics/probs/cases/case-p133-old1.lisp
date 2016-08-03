 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside-airplane package1 airplane1)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside-airplane package1 airplane1)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(inside-airplane package1 airplane1)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator load-airplane))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at-obj package1 pgh-airport))
              (p4::instantiate-consed-literal '(at-airplane airplane1 pgh-airport)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator load-airplane)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'package1 *current-problem-space*)
                    (p4::object-name-to-object 'airplane1 *current-problem-space*)
                    (p4::object-name-to-object 'pgh-airport *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-obj package1 pgh-airport))
              (p4::instantiate-consed-literal '(at-airplane airplane1 pgh-airport)))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(at-airplane airplane1 pgh-airport)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator fly-airplane))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(at-airplane airplane1 bos-airport))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-airplane)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'airplane1 *current-problem-space*)
                    (p4::object-name-to-object 'bos-airport *current-problem-space*)
                    (p4::object-name-to-object 'pgh-airport *current-problem-space*))
          :precond 
            (p4::instantiate-consed-literal '(at-airplane airplane1 bos-airport))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-applied-op-node 
        :name 11 
        :parent (find-node 10)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 11))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-airplane)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'airplane1 *current-problem-space*)
                    (p4::object-name-to-object 'bos-airport *current-problem-space*)
                    (p4::object-name-to-object 'pgh-airport *current-problem-space*))
          :precond 
            (p4::instantiate-consed-literal '(at-airplane airplane1 bos-airport))))

(setf (p4::a-or-b-node-applied (find-node 11))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 11))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-airplane airplane1 pgh-airport)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-airplane airplane1 bos-airport))))))
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-applied-op-node 
        :name 12 
        :parent (find-node 11)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 12))
      (p4::make-instantiated-op
          :op (p4::get-operator load-airplane)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'package1 *current-problem-space*)
                    (p4::object-name-to-object 'airplane1 *current-problem-space*)
                    (p4::object-name-to-object 'pgh-airport *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-obj package1 pgh-airport))
              (p4::instantiate-consed-literal '(at-airplane airplane1 pgh-airport)))))

(setf (p4::a-or-b-node-applied (find-node 12))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 12))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(inside-airplane package1 airplane1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-obj package1 pgh-airport))))))
