 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(on blocka blockb))
              (p4::instantiate-consed-literal '(on blockb blockc)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator p4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(on blocka blockb))
              (p4::instantiate-consed-literal '(on blockb blockc)))))
 
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
    (p4::make-goal-node 
        :name 11 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(clear blocka)) 
        :introducing-operators (list (find-node 10) )))) 
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-operator-node 
        :name 14 
        :parent (find-node 11) 
        :operator (p4::get-operator unstack))))
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-binding-node 
        :name 15 
        :parent (find-node 14)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(on blockc blocka))
              (p4::instantiate-consed-literal '(clear blockc))
              (p4::instantiate-consed-literal '(arm-empty)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 15))
      (p4::make-instantiated-op
          :op (p4::get-operator unstack)
          :binding-node-back-pointer (find-node 15)
          :values (list 
                    (p4::object-name-to-object 'blockc *current-problem-space*)
                    (p4::object-name-to-object 'blocka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(on blockc blocka))
              (p4::instantiate-consed-literal '(clear blockc))
              (p4::instantiate-consed-literal '(arm-empty)))))
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-applied-op-node 
        :name 16 
        :parent (find-node 15)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 16))
      (p4::make-instantiated-op
          :op (p4::get-operator unstack)
          :binding-node-back-pointer (find-node 15)
          :values (list 
                    (p4::object-name-to-object 'blockc *current-problem-space*)
                    (p4::object-name-to-object 'blocka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(on blockc blocka))
              (p4::instantiate-consed-literal '(clear blockc))
              (p4::instantiate-consed-literal '(arm-empty)))))

(setf (p4::a-or-b-node-applied (find-node 16))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 16))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(clear blocka))
                 (p4::instantiate-consed-literal '(holding blockc)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(arm-empty))
                 (p4::instantiate-consed-literal '(clear blockc))
                 (p4::instantiate-consed-literal '(on blockc blocka))))))
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-goal-node 
        :name 17 
        :parent (find-node 16) 
        :goal 
            (p4::instantiate-consed-literal '(arm-empty)) 
        :introducing-operators (list (find-node 10) )))) 
 
(setf (p4::nexus-children (find-node 17))
  (list
    (p4::make-operator-node 
        :name 18 
        :parent (find-node 17) 
        :operator (p4::get-operator put-down))))
 
(setf (p4::nexus-children (find-node 18))
  (list
    (p4::make-binding-node 
        :name 19 
        :parent (find-node 18)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(holding blockc))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 19))
      (p4::make-instantiated-op
          :op (p4::get-operator put-down)
          :binding-node-back-pointer (find-node 19)
          :values (list 
                    (p4::object-name-to-object 'blockc *current-problem-space*))
          :precond 
            (p4::instantiate-consed-literal '(holding blockc))))
 
(setf (p4::nexus-children (find-node 19))
  (list
    (p4::make-applied-op-node 
        :name 20 
        :parent (find-node 19)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 20))
      (p4::make-instantiated-op
          :op (p4::get-operator put-down)
          :binding-node-back-pointer (find-node 19)
          :values (list 
                    (p4::object-name-to-object 'blockc *current-problem-space*))
          :precond 
            (p4::instantiate-consed-literal '(holding blockc))))

(setf (p4::a-or-b-node-applied (find-node 20))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 20))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(on-table blockc))
                 (p4::instantiate-consed-literal '(arm-empty))
                 (p4::instantiate-consed-literal '(clear blockc)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(holding blockc))))))
 
(setf (p4::nexus-children (find-node 20))
  (list
    (p4::make-goal-node 
        :name 86 
        :parent (find-node 20) 
        :goal 
            (p4::instantiate-consed-literal '(on blockb blockc)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 86))
  (list
    (p4::make-operator-node 
        :name 87 
        :parent (find-node 86) 
        :operator (p4::get-operator stack))))
 
(setf (p4::nexus-children (find-node 87))
  (list
    (p4::make-binding-node 
        :name 88 
        :parent (find-node 87)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(clear blockc))
              (p4::instantiate-consed-literal '(holding blockb)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 88))
      (p4::make-instantiated-op
          :op (p4::get-operator stack)
          :binding-node-back-pointer (find-node 88)
          :values (list 
                    (p4::object-name-to-object 'blockb *current-problem-space*)
                    (p4::object-name-to-object 'blockc *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(clear blockc))
              (p4::instantiate-consed-literal '(holding blockb)))))
 
(setf (p4::nexus-children (find-node 88))
  (list
    (p4::make-goal-node 
        :name 89 
        :parent (find-node 88) 
        :goal 
            (p4::instantiate-consed-literal '(holding blockb)) 
        :introducing-operators (list (find-node 88) )))) 
 
(setf (p4::nexus-children (find-node 89))
  (list
    (p4::make-operator-node 
        :name 90 
        :parent (find-node 89) 
        :operator (p4::get-operator pick-up))))
 
(setf (p4::nexus-children (find-node 90))
  (list
    (p4::make-binding-node 
        :name 91 
        :parent (find-node 90)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(clear blockb))
              (p4::instantiate-consed-literal '(on-table blockb))
              (p4::instantiate-consed-literal '(arm-empty)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 91))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 91)
          :values (list 
                    (p4::object-name-to-object 'blockb *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(clear blockb))
              (p4::instantiate-consed-literal '(on-table blockb))
              (p4::instantiate-consed-literal '(arm-empty)))))
 
(setf (p4::nexus-children (find-node 91))
  (list
    (p4::make-applied-op-node 
        :name 92 
        :parent (find-node 91)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 92))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 91)
          :values (list 
                    (p4::object-name-to-object 'blockb *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(clear blockb))
              (p4::instantiate-consed-literal '(on-table blockb))
              (p4::instantiate-consed-literal '(arm-empty)))))

(setf (p4::a-or-b-node-applied (find-node 92))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 92))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding blockb)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(arm-empty))
                 (p4::instantiate-consed-literal '(clear blockb))
                 (p4::instantiate-consed-literal '(on-table blockb))))))
 
(setf (p4::nexus-children (find-node 92))
  (list
    (p4::make-applied-op-node 
        :name 93 
        :parent (find-node 92)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 93))
      (p4::make-instantiated-op
          :op (p4::get-operator stack)
          :binding-node-back-pointer (find-node 88)
          :values (list 
                    (p4::object-name-to-object 'blockb *current-problem-space*)
                    (p4::object-name-to-object 'blockc *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(clear blockc))
              (p4::instantiate-consed-literal '(holding blockb)))))

(setf (p4::a-or-b-node-applied (find-node 93))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 93))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(on blockb blockc))
                 (p4::instantiate-consed-literal '(arm-empty))
                 (p4::instantiate-consed-literal '(clear blockb)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(clear blockc))
                 (p4::instantiate-consed-literal '(holding blockb))))))
 
(setf (p4::nexus-children (find-node 93))
  (list
    (p4::make-applied-op-node 
        :name 94 
        :parent (find-node 93)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 94))
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

(setf (p4::a-or-b-node-applied (find-node 94))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 94))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding blocka)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(arm-empty))
                 (p4::instantiate-consed-literal '(clear blocka))
                 (p4::instantiate-consed-literal '(on-table blocka))))))
 
(setf (p4::nexus-children (find-node 94))
  (list
    (p4::make-applied-op-node 
        :name 95 
        :parent (find-node 94)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 95))
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

(setf (p4::a-or-b-node-applied (find-node 95))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 95))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(on blocka blockb))
                 (p4::instantiate-consed-literal '(arm-empty))
                 (p4::instantiate-consed-literal '(clear blocka)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(clear blockb))
                 (p4::instantiate-consed-literal '(holding blocka))))))
