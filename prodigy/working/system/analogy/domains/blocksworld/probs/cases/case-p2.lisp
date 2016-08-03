 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(holding b))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (p4::instantiate-consed-literal '(holding b))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(holding b)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator pick-up))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(clear b))
              (p4::instantiate-consed-literal '(on-table b))
              (p4::instantiate-consed-literal '(arm-empty)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'b *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(clear b))
              (p4::instantiate-consed-literal '(on-table b))
              (p4::instantiate-consed-literal '(arm-empty)))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-applied-op-node 
        :name 8 
        :parent (find-node 7)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 8))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'b *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(clear b))
              (p4::instantiate-consed-literal '(on-table b))
              (p4::instantiate-consed-literal '(arm-empty)))))

(setf (p4::a-or-b-node-applied (find-node 8))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 8))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding b)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(arm-empty))
                 (p4::instantiate-consed-literal '(clear b))
                 (p4::instantiate-consed-literal '(on-table b))))))
