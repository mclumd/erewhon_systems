 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(holding alienbody))
              (p4::instantiate-consed-literal '(holding jfksbrain))
              (p4::instantiate-consed-literal '(at roswell)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(holding alienbody))
              (p4::instantiate-consed-literal '(holding jfksbrain))
              (p4::instantiate-consed-literal '(at roswell)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(holding alienbody)) 
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
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51))
              (p4::instantiate-consed-literal '(stored alienbody area51)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator steal)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'alienbody *current-problem-space*)
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51))
              (p4::instantiate-consed-literal '(stored alienbody area51)))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(holding jfksbrain)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator steal))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51))
              (p4::instantiate-consed-literal '(stored jfksbrain area51)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator steal)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'jfksbrain *current-problem-space*)
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51))
              (p4::instantiate-consed-literal '(stored jfksbrain area51)))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-goal-node 
        :name 11 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(inside area51)) 
        :introducing-operators (list (find-node 10) (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-operator-node 
        :name 12 
        :parent (find-node 11) 
        :operator (p4::get-operator break-in))))
 
(setf (p4::nexus-children (find-node 12))
  (list
    (p4::make-binding-node 
        :name 13 
        :parent (find-node 12)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(insecure area51)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 13))
      (p4::make-instantiated-op
          :op (p4::get-operator break-in)
          :binding-node-back-pointer (find-node 13)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(insecure area51)))))
 
(setf (p4::nexus-children (find-node 13))
  (list
    (p4::make-applied-op-node 
        :name 14 
        :parent (find-node 13)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 14))
      (p4::make-instantiated-op
          :op (p4::get-operator break-in)
          :binding-node-back-pointer (find-node 13)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(insecure area51)))))

(setf (p4::a-or-b-node-applied (find-node 14))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 14))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(inside area51)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(insecure area51))
                 (p4::instantiate-consed-literal '(at area51))))))
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-applied-op-node 
        :name 15 
        :parent (find-node 14)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 15))
      (p4::make-instantiated-op
          :op (p4::get-operator steal)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'jfksbrain *current-problem-space*)
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51))
              (p4::instantiate-consed-literal '(stored jfksbrain area51)))))

(setf (p4::a-or-b-node-applied (find-node 15))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 15))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding jfksbrain)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(stored jfksbrain area51))))))
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-applied-op-node 
        :name 16 
        :parent (find-node 15)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 16))
      (p4::make-instantiated-op
          :op (p4::get-operator steal)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'alienbody *current-problem-space*)
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51))
              (p4::instantiate-consed-literal '(stored alienbody area51)))))

(setf (p4::a-or-b-node-applied (find-node 16))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 16))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding alienbody)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(stored alienbody area51))))))
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-goal-node 
        :name 17 
        :parent (find-node 16) 
        :goal 
            (p4::instantiate-consed-literal '(at roswell)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 17))
  (list
    (p4::make-operator-node 
        :name 18 
        :parent (find-node 17) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 18))
  (list
    (p4::make-binding-node 
        :name 19 
        :parent (find-node 18)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(pass area51 roswell)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 19))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 19)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*)
                    (p4::object-name-to-object 'roswell *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(pass area51 roswell)))))
 
(setf (p4::nexus-children (find-node 19))
  (list
    (p4::make-goal-node 
        :name 20 
        :parent (find-node 19) 
        :goal 
            (p4::instantiate-consed-literal '(at area51)) 
        :introducing-operators (list (find-node 19) )))) 
 
(setf (p4::nexus-children (find-node 20))
  (list
    (p4::make-operator-node 
        :name 23 
        :parent (find-node 20) 
        :operator (p4::get-operator escape))))
 
(setf (p4::nexus-children (find-node 23))
  (list
    (p4::make-binding-node 
        :name 24 
        :parent (find-node 23)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 24))
      (p4::make-instantiated-op
          :op (p4::get-operator escape)
          :binding-node-back-pointer (find-node 24)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51)))))
 
(setf (p4::nexus-children (find-node 24))
  (list
    (p4::make-applied-op-node 
        :name 25 
        :parent (find-node 24)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 25))
      (p4::make-instantiated-op
          :op (p4::get-operator escape)
          :binding-node-back-pointer (find-node 24)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside area51)))))

(setf (p4::a-or-b-node-applied (find-node 25))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 25))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at area51))
                 (p4::instantiate-consed-literal '(secure area51)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(inside area51))))))
 
(setf (p4::nexus-children (find-node 25))
  (list
    (p4::make-applied-op-node 
        :name 26 
        :parent (find-node 25)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 26))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 19)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*)
                    (p4::object-name-to-object 'roswell *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(pass area51 roswell)))))

(setf (p4::a-or-b-node-applied (find-node 26))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 26))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at roswell)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(pass area51 roswell))
                 (p4::instantiate-consed-literal '(at area51))))))
