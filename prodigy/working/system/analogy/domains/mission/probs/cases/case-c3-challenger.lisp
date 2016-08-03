 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(holding noc-list))
              (p4::instantiate-consed-literal '(at london)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(holding noc-list))
              (p4::instantiate-consed-literal '(at london)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(at london)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 12 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(pass area51 london)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 12))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 12)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(pass area51 london)))))
 
(setf (p4::nexus-children (find-node 12))
  (list
    (p4::make-goal-node 
        :name 13 
        :parent (find-node 12) 
        :goal 
            (p4::instantiate-consed-literal '(holding noc-list)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 13))
  (list
    (p4::make-operator-node 
        :name 14 
        :parent (find-node 13) 
        :operator (p4::get-operator steal))))
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-binding-node 
        :name 15 
        :parent (find-node 14)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51))
              (p4::instantiate-consed-literal '(stored noc-list area51)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 15))
      (p4::make-instantiated-op
          :op (p4::get-operator steal)
          :binding-node-back-pointer (find-node 15)
          :values (list 
                    (p4::object-name-to-object 'noc-list *current-problem-space*)
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51))
              (p4::instantiate-consed-literal '(stored noc-list area51)))))
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-goal-node 
        :name 16 
        :parent (find-node 15) 
        :goal 
            (p4::instantiate-consed-literal '(at area51)) 
        :introducing-operators (list (find-node 12) )))) 
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-operator-node 
        :name 17 
        :parent (find-node 16) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 17))
  (list
    (p4::make-binding-node 
        :name 23 
        :parent (find-node 17)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley area51)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 23))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 23)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*)
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley area51)))))
 
(setf (p4::nexus-children (find-node 23))
  (list
    (p4::make-goal-node 
        :name 24 
        :parent (find-node 23) 
        :goal 
            (p4::instantiate-consed-literal '(inside area51)) 
        :introducing-operators (list (find-node 15) )))) 
 
(setf (p4::nexus-children (find-node 24))
  (list
    (p4::make-operator-node 
        :name 25 
        :parent (find-node 24) 
        :operator (p4::get-operator break-in))))
 
(setf (p4::nexus-children (find-node 25))
  (list
    (p4::make-binding-node 
        :name 26 
        :parent (find-node 25)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(insecure area51)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 26))
      (p4::make-instantiated-op
          :op (p4::get-operator break-in)
          :binding-node-back-pointer (find-node 26)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(insecure area51)))))
 
(setf (p4::nexus-children (find-node 26))
  (list
    (p4::make-goal-node 
        :name 27 
        :parent (find-node 26) 
        :goal 
            (p4::instantiate-consed-literal '(at langley)) 
        :introducing-operators (list (find-node 23) )))) 
 
(setf (p4::nexus-children (find-node 27))
  (list
    (p4::make-operator-node 
        :name 28 
        :parent (find-node 27) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 28))
  (list
    (p4::make-binding-node 
        :name 29 
        :parent (find-node 28)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at roswell))
              (p4::instantiate-consed-literal '(pass roswell langley)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 29)
          :values (list 
                    (p4::object-name-to-object 'roswell *current-problem-space*)
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at roswell))
              (p4::instantiate-consed-literal '(pass roswell langley)))))
 
(setf (p4::nexus-children (find-node 29))
  (list
    (p4::make-applied-op-node 
        :name 30 
        :parent (find-node 29)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 30))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 29)
          :values (list 
                    (p4::object-name-to-object 'roswell *current-problem-space*)
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at roswell))
              (p4::instantiate-consed-literal '(pass roswell langley)))))

(setf (p4::a-or-b-node-applied (find-node 30))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 30))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at langley)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(pass roswell langley))
                 (p4::instantiate-consed-literal '(at roswell))))))
 
(setf (p4::nexus-children (find-node 30))
  (list
    (p4::make-applied-op-node 
        :name 31 
        :parent (find-node 30)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 31))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 23)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*)
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley area51)))))

(setf (p4::a-or-b-node-applied (find-node 31))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 31))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at area51)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(pass langley area51))
                 (p4::instantiate-consed-literal '(at langley))))))
 
(setf (p4::nexus-children (find-node 31))
  (list
    (p4::make-applied-op-node 
        :name 32 
        :parent (find-node 31)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 32))
      (p4::make-instantiated-op
          :op (p4::get-operator break-in)
          :binding-node-back-pointer (find-node 26)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(insecure area51)))))

(setf (p4::a-or-b-node-applied (find-node 32))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 32))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(inside area51)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(insecure area51))
                 (p4::instantiate-consed-literal '(at area51))))))
 
(setf (p4::nexus-children (find-node 32))
  (list
    (p4::make-goal-node 
        :name 33 
        :parent (find-node 32) 
        :goal 
            (p4::instantiate-consed-literal '(at area51)) 
        :introducing-operators (list (find-node 12) )))) 
 
(setf (p4::nexus-children (find-node 33))
  (list
    (p4::make-operator-node 
        :name 39 
        :parent (find-node 33) 
        :operator (p4::get-operator escape))))
 
(setf (p4::nexus-children (find-node 39))
  (list
    (p4::make-binding-node 
        :name 40 
        :parent (find-node 39)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 40))
      (p4::make-instantiated-op
          :op (p4::get-operator escape)
          :binding-node-back-pointer (find-node 40)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51)))))
 
(setf (p4::nexus-children (find-node 40))
  (list
    (p4::make-applied-op-node 
        :name 41 
        :parent (find-node 40)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 41))
      (p4::make-instantiated-op
          :op (p4::get-operator steal)
          :binding-node-back-pointer (find-node 15)
          :values (list 
                    (p4::object-name-to-object 'noc-list *current-problem-space*)
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51))
              (p4::instantiate-consed-literal '(stored noc-list area51)))))

(setf (p4::a-or-b-node-applied (find-node 41))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 41))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding noc-list)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(stored noc-list area51))))))
 
(setf (p4::nexus-children (find-node 41))
  (list
    (p4::make-applied-op-node 
        :name 42 
        :parent (find-node 41)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 42))
      (p4::make-instantiated-op
          :op (p4::get-operator escape)
          :binding-node-back-pointer (find-node 40)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51)))))

(setf (p4::a-or-b-node-applied (find-node 42))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 42))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at area51))
                 (p4::instantiate-consed-literal '(secure area51)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(inside area51))))))
 
(setf (p4::nexus-children (find-node 42))
  (list
    (p4::make-applied-op-node 
        :name 43 
        :parent (find-node 42)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 43))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 12)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(pass area51 london)))))

(setf (p4::a-or-b-node-applied (find-node 43))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 43))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at london)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(pass area51 london))
                 (p4::instantiate-consed-literal '(at area51))))))
