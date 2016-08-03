 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at hammer locb)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at hammer locb)))))
 
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
              (p4::instantiate-consed-literal '(inside hammer apollo))
              (p4::instantiate-consed-literal '(at apollo locb)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator unload-rocket)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'hammer *current-problem-space*)
                    (p4::object-name-to-object 'locb *current-problem-space*)
                    (p4::object-name-to-object 'apollo *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside hammer apollo))
              (p4::instantiate-consed-literal '(at apollo locb)))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(inside hammer apollo)) 
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
              (p4::instantiate-consed-literal '(at apollo loca))
              (p4::instantiate-consed-literal '(at hammer loca)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator load-rocket)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'hammer *current-problem-space*)
                    (p4::object-name-to-object 'loca *current-problem-space*)
                    (p4::object-name-to-object 'apollo *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at apollo loca))
              (p4::instantiate-consed-literal '(at hammer loca)))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-goal-node 
        :name 11 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(at apollo locb)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-operator-node 
        :name 12 
        :parent (find-node 11) 
        :operator (p4::get-operator move-rocket))))
 
(setf (p4::nexus-children (find-node 12))
  (list
    (p4::make-binding-node 
        :name 13 
        :parent (find-node 12)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(at apollo loca))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 13))
      (p4::make-instantiated-op
          :op (p4::get-operator move-rocket)
          :binding-node-back-pointer (find-node 13)
          :values (list 
                    (p4::object-name-to-object 'apollo *current-problem-space*))
          :precond 
            (p4::instantiate-consed-literal '(at apollo loca))))
 
(setf (p4::nexus-children (find-node 13))
  (list
    (p4::make-applied-op-node 
        :name 14 
        :parent (find-node 13)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 14))
      (p4::make-instantiated-op
          :op (p4::get-operator load-rocket)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'hammer *current-problem-space*)
                    (p4::object-name-to-object 'loca *current-problem-space*)
                    (p4::object-name-to-object 'apollo *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at apollo loca))
              (p4::instantiate-consed-literal '(at hammer loca)))))

(setf (p4::a-or-b-node-applied (find-node 14))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 14))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(inside hammer apollo)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at hammer loca))))))
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-applied-op-node 
        :name 15 
        :parent (find-node 14)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 15))
      (p4::make-instantiated-op
          :op (p4::get-operator move-rocket)
          :binding-node-back-pointer (find-node 13)
          :values (list 
                    (p4::object-name-to-object 'apollo *current-problem-space*))
          :precond 
            (p4::instantiate-consed-literal '(at apollo loca))))

(setf (p4::a-or-b-node-applied (find-node 15))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 15))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at apollo locb)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at apollo loca))))))
 
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
                    (p4::object-name-to-object 'apollo *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside hammer apollo))
              (p4::instantiate-consed-literal '(at apollo locb)))))

(setf (p4::a-or-b-node-applied (find-node 16))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 16))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at hammer locb)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(inside hammer apollo))))))
