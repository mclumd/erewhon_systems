 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(on blocka blockb))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator p4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (p4::instantiate-consed-literal '(on blocka blockb))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(on blocka blockb)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator stack))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(clear blockb))
              (p4::instantiate-consed-literal '(holding blocka)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator stack)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'blocka *current-problem-space*)
                    (p4::object-name-to-object 'blockb *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(clear blockb))
              (p4::instantiate-consed-literal '(holding blocka)))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(holding blocka)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator pick-up))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(clear blocka))
              (p4::instantiate-consed-literal '(on-table blocka))
              (p4::instantiate-consed-literal '(arm-empty)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'blocka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(clear blocka))
              (p4::instantiate-consed-literal '(on-table blocka))
              (p4::instantiate-consed-literal '(arm-empty)))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-applied-op-node 
        :name 11 
        :parent (find-node 10)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 11))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'blocka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(clear blocka))
              (p4::instantiate-consed-literal '(on-table blocka))
              (p4::instantiate-consed-literal '(arm-empty)))))

(setf (p4::a-or-b-node-applied (find-node 11))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 11))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding blocka)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(arm-empty))
                 (p4::instantiate-consed-literal '(clear blocka))
                 (p4::instantiate-consed-literal '(on-table blocka))))))
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-applied-op-node 
        :name 12 
        :parent (find-node 11)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 12))
      (p4::make-instantiated-op
          :op (p4::get-operator stack)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'blocka *current-problem-space*)
                    (p4::object-name-to-object 'blockb *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(clear blockb))
              (p4::instantiate-consed-literal '(holding blocka)))))

(setf (p4::a-or-b-node-applied (find-node 12))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 12))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(on blocka blockb))
                 (p4::instantiate-consed-literal '(arm-empty))
                 (p4::instantiate-consed-literal '(clear blocka)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(clear blockb))
                 (p4::instantiate-consed-literal '(holding blocka))))))
