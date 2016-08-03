 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside-truck package1 pgh-truck)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside-truck package1 pgh-truck)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(inside-truck package1 pgh-truck)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator load-truck))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 16 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at-obj package1 pgh-po))
              (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-po)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 16))
      (p4::make-instantiated-op
          :op (p4::get-operator load-truck)
          :binding-node-back-pointer (find-node 16)
          :values (list 
                    (p4::object-name-to-object 'package1 *current-problem-space*)
                    (p4::object-name-to-object 'pgh-truck *current-problem-space*)
                    (p4::object-name-to-object 'pgh-po *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-obj package1 pgh-po))
              (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-po)))))
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-goal-node 
        :name 17 
        :parent (find-node 16) 
        :goal 
            (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-po)) 
        :introducing-operators (list (find-node 16) )))) 
 
(setf (p4::nexus-children (find-node 17))
  (list
    (p4::make-operator-node 
        :name 18 
        :parent (find-node 17) 
        :operator (p4::get-operator drive-truck))))
 
(setf (p4::nexus-children (find-node 18))
  (list
    (p4::make-binding-node 
        :name 19 
        :parent (find-node 18)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(same-city pgh-airport pgh-po))
              (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-airport)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 19))
      (p4::make-instantiated-op
          :op (p4::get-operator drive-truck)
          :binding-node-back-pointer (find-node 19)
          :values (list 
                    (p4::object-name-to-object 'pgh-truck *current-problem-space*)
                    (p4::object-name-to-object 'pgh-airport *current-problem-space*)
                    (p4::object-name-to-object 'pgh-po *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(same-city pgh-airport pgh-po))
              (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-airport)))))
 
(setf (p4::nexus-children (find-node 19))
  (list
    (p4::make-applied-op-node 
        :name 20 
        :parent (find-node 19)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 20))
      (p4::make-instantiated-op
          :op (p4::get-operator drive-truck)
          :binding-node-back-pointer (find-node 19)
          :values (list 
                    (p4::object-name-to-object 'pgh-truck *current-problem-space*)
                    (p4::object-name-to-object 'pgh-airport *current-problem-space*)
                    (p4::object-name-to-object 'pgh-po *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(same-city pgh-airport pgh-po))
              (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-airport)))))

(setf (p4::a-or-b-node-applied (find-node 20))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 20))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-po)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-airport))))))
 
(setf (p4::nexus-children (find-node 20))
  (list
    (p4::make-applied-op-node 
        :name 21 
        :parent (find-node 20)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 21))
      (p4::make-instantiated-op
          :op (p4::get-operator load-truck)
          :binding-node-back-pointer (find-node 16)
          :values (list 
                    (p4::object-name-to-object 'package1 *current-problem-space*)
                    (p4::object-name-to-object 'pgh-truck *current-problem-space*)
                    (p4::object-name-to-object 'pgh-po *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-obj package1 pgh-po))
              (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-po)))))

(setf (p4::a-or-b-node-applied (find-node 21))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 21))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(inside-truck package1 pgh-truck)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-obj package1 pgh-po))))))
