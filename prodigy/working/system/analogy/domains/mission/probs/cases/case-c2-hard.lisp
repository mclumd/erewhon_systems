 
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
            (p4::instantiate-consed-literal '(holding noc-list)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator steal))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 83 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51))
              (p4::instantiate-consed-literal '(stored noc-list area51)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 83))
      (p4::make-instantiated-op
          :op (p4::get-operator steal)
          :binding-node-back-pointer (find-node 83)
          :values (list 
                    (p4::object-name-to-object 'noc-list *current-problem-space*)
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51))
              (p4::instantiate-consed-literal '(stored noc-list area51)))))
 
(setf (p4::nexus-children (find-node 83))
  (list
    (p4::make-goal-node 
        :name 84 
        :parent (find-node 83) 
        :goal 
            (p4::instantiate-consed-literal '(inside area51)) 
        :introducing-operators (list (find-node 83) )))) 
 
(setf (p4::nexus-children (find-node 84))
  (list
    (p4::make-operator-node 
        :name 85 
        :parent (find-node 84) 
        :operator (p4::get-operator break-in))))
 
(setf (p4::nexus-children (find-node 85))
  (list
    (p4::make-binding-node 
        :name 86 
        :parent (find-node 85)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(insecure area51)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 86))
      (p4::make-instantiated-op
          :op (p4::get-operator break-in)
          :binding-node-back-pointer (find-node 86)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(insecure area51)))))
 
(setf (p4::nexus-children (find-node 86))
  (list
    (p4::make-goal-node 
        :name 87 
        :parent (find-node 86) 
        :goal 
            (p4::instantiate-consed-literal '(at area51)) 
        :introducing-operators (list (find-node 86) )))) 
 
(setf (p4::nexus-children (find-node 87))
  (list
    (p4::make-operator-node 
        :name 88 
        :parent (find-node 87) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 88))
  (list
    (p4::make-binding-node 
        :name 89 
        :parent (find-node 88)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley area51)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 89))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 89)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*)
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley area51)))))
 
(setf (p4::nexus-children (find-node 89))
  (list
    (p4::make-applied-op-node 
        :name 90 
        :parent (find-node 89)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 90))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 89)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*)
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley area51)))))

(setf (p4::a-or-b-node-applied (find-node 90))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 90))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at area51)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(pass langley area51))
                 (p4::instantiate-consed-literal '(at langley))))))
 
(setf (p4::nexus-children (find-node 90))
  (list
    (p4::make-applied-op-node 
        :name 91 
        :parent (find-node 90)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 91))
      (p4::make-instantiated-op
          :op (p4::get-operator break-in)
          :binding-node-back-pointer (find-node 86)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(insecure area51)))))

(setf (p4::a-or-b-node-applied (find-node 91))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 91))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(inside area51)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(insecure area51))
                 (p4::instantiate-consed-literal '(at area51))))))
 
(setf (p4::nexus-children (find-node 91))
  (list
    (p4::make-applied-op-node 
        :name 92 
        :parent (find-node 91)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 92))
      (p4::make-instantiated-op
          :op (p4::get-operator steal)
          :binding-node-back-pointer (find-node 83)
          :values (list 
                    (p4::object-name-to-object 'noc-list *current-problem-space*)
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51))
              (p4::instantiate-consed-literal '(stored noc-list area51)))))

(setf (p4::a-or-b-node-applied (find-node 92))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 92))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding noc-list)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(stored noc-list area51))))))
 
(setf (p4::nexus-children (find-node 92))
  (list
    (p4::make-goal-node 
        :name 93 
        :parent (find-node 92) 
        :goal 
            (p4::instantiate-consed-literal '(at london)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 93))
  (list
    (p4::make-operator-node 
        :name 94 
        :parent (find-node 93) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 94))
  (list
    (p4::make-binding-node 
        :name 95 
        :parent (find-node 94)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(pass area51 london)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 95))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 95)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(pass area51 london)))))
 
(setf (p4::nexus-children (find-node 95))
  (list
    (p4::make-goal-node 
        :name 96 
        :parent (find-node 95) 
        :goal 
            (p4::instantiate-consed-literal '(at area51)) 
        :introducing-operators (list (find-node 95) )))) 
 
(setf (p4::nexus-children (find-node 96))
  (list
    (p4::make-operator-node 
        :name 114 
        :parent (find-node 96) 
        :operator (p4::get-operator escape))))
 
(setf (p4::nexus-children (find-node 114))
  (list
    (p4::make-binding-node 
        :name 115 
        :parent (find-node 114)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 115))
      (p4::make-instantiated-op
          :op (p4::get-operator escape)
          :binding-node-back-pointer (find-node 115)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51)))))
 
(setf (p4::nexus-children (find-node 115))
  (list
    (p4::make-applied-op-node 
        :name 116 
        :parent (find-node 115)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 116))
      (p4::make-instantiated-op
          :op (p4::get-operator escape)
          :binding-node-back-pointer (find-node 115)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51)))))

(setf (p4::a-or-b-node-applied (find-node 116))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 116))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at area51))
                 (p4::instantiate-consed-literal '(secure area51)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(inside area51))))))
 
(setf (p4::nexus-children (find-node 116))
  (list
    (p4::make-applied-op-node 
        :name 117 
        :parent (find-node 116)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 117))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 95)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(pass area51 london)))))

(setf (p4::a-or-b-node-applied (find-node 117))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 117))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at london)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(pass area51 london))
                 (p4::instantiate-consed-literal '(at area51))))))
