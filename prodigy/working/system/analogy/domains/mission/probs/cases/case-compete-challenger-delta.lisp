 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(dropped alienbody roswell))
              (p4::instantiate-consed-literal '(dropped jfksbrain roswell)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(dropped alienbody roswell))
              (p4::instantiate-consed-literal '(dropped jfksbrain roswell)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(dropped alienbody roswell)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator drop-off))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at roswell))
              (p4::instantiate-consed-literal '(holding alienbody)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator drop-off)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'alienbody *current-problem-space*)
                    (p4::object-name-to-object 'roswell *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at roswell))
              (p4::instantiate-consed-literal '(holding alienbody)))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-applied-op-node 
        :name 8 
        :parent (find-node 7)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 8))
      (p4::make-instantiated-op
          :op (p4::get-operator drop-off)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'alienbody *current-problem-space*)
                    (p4::object-name-to-object 'roswell *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at roswell))
              (p4::instantiate-consed-literal '(holding alienbody)))))

(setf (p4::a-or-b-node-applied (find-node 8))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 8))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(dropped alienbody roswell)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(holding alienbody))))))
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-goal-node 
        :name 9 
        :parent (find-node 8) 
        :goal 
            (p4::instantiate-consed-literal '(dropped jfksbrain roswell)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-operator-node 
        :name 10 
        :parent (find-node 9) 
        :operator (p4::get-operator drop-off))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-binding-node 
        :name 11 
        :parent (find-node 10)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at roswell))
              (p4::instantiate-consed-literal '(holding jfksbrain)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 11))
      (p4::make-instantiated-op
          :op (p4::get-operator drop-off)
          :binding-node-back-pointer (find-node 11)
          :values (list 
                    (p4::object-name-to-object 'jfksbrain *current-problem-space*)
                    (p4::object-name-to-object 'roswell *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at roswell))
              (p4::instantiate-consed-literal '(holding jfksbrain)))))
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-applied-op-node 
        :name 12 
        :parent (find-node 11)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 12))
      (p4::make-instantiated-op
          :op (p4::get-operator drop-off)
          :binding-node-back-pointer (find-node 11)
          :values (list 
                    (p4::object-name-to-object 'jfksbrain *current-problem-space*)
                    (p4::object-name-to-object 'roswell *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at roswell))
              (p4::instantiate-consed-literal '(holding jfksbrain)))))

(setf (p4::a-or-b-node-applied (find-node 12))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 12))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(dropped jfksbrain roswell)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(holding jfksbrain))))))
