 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at-obj package1 bos-airport)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-obj package1 bos-airport)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(at-obj package1 bos-airport)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 7 
        :parent (find-node 5) 
        :operator (p4::get-operator unload-airplane))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-binding-node 
        :name 8 
        :parent (find-node 7)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside-airplane package1 airplane1))
              (p4::instantiate-consed-literal '(at-airplane airplane1 bos-airport)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 8))
      (p4::make-instantiated-op
          :op (p4::get-operator unload-airplane)
          :binding-node-back-pointer (find-node 8)
          :values (list 
                    (p4::object-name-to-object 'package1 *current-problem-space*)
                    (p4::object-name-to-object 'airplane1 *current-problem-space*)
                    (p4::object-name-to-object 'bos-airport *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside-airplane package1 airplane1))
              (p4::instantiate-consed-literal '(at-airplane airplane1 bos-airport)))))
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-goal-node 
        :name 9 
        :parent (find-node 8) 
        :goal 
            (p4::instantiate-consed-literal '(inside-airplane package1 airplane1)) 
        :introducing-operators (list (find-node 8) )))) 
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-operator-node 
        :name 10 
        :parent (find-node 9) 
        :operator (p4::get-operator load-airplane))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-binding-node 
        :name 11 
        :parent (find-node 10)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at-obj package1 pgh-airport))
              (p4::instantiate-consed-literal '(at-airplane airplane1 pgh-airport)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 11))
      (p4::make-instantiated-op
          :op (p4::get-operator load-airplane)
          :binding-node-back-pointer (find-node 11)
          :values (list 
                    (p4::object-name-to-object 'package1 *current-problem-space*)
                    (p4::object-name-to-object 'airplane1 *current-problem-space*)
                    (p4::object-name-to-object 'pgh-airport *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-obj package1 pgh-airport))
              (p4::instantiate-consed-literal '(at-airplane airplane1 pgh-airport)))))
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-goal-node 
        :name 12 
        :parent (find-node 11) 
        :goal 
            (p4::instantiate-consed-literal '(at-obj package1 pgh-airport)) 
        :introducing-operators (list (find-node 11) )))) 
 
(setf (p4::nexus-children (find-node 12))
  (list
    (p4::make-operator-node 
        :name 13 
        :parent (find-node 12) 
        :operator (p4::get-operator unload-truck))))
 
(setf (p4::nexus-children (find-node 13))
  (list
    (p4::make-binding-node 
        :name 14 
        :parent (find-node 13)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside-truck package1 pgh-truck))
              (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-airport)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 14))
      (p4::make-instantiated-op
          :op (p4::get-operator unload-truck)
          :binding-node-back-pointer (find-node 14)
          :values (list 
                    (p4::object-name-to-object 'package1 *current-problem-space*)
                    (p4::object-name-to-object 'pgh-truck *current-problem-space*)
                    (p4::object-name-to-object 'pgh-airport *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside-truck package1 pgh-truck))
              (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-airport)))))
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-goal-node 
        :name 15 
        :parent (find-node 14) 
        :goal 
            (p4::instantiate-consed-literal '(inside-truck package1 pgh-truck)) 
        :introducing-operators (list (find-node 14) )))) 
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-operator-node 
        :name 16 
        :parent (find-node 15) 
        :operator (p4::get-operator load-truck))))
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-binding-node 
        :name 17 
        :parent (find-node 16)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at-obj package1 pgh-po))
              (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-po)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 17))
      (p4::make-instantiated-op
          :op (p4::get-operator load-truck)
          :binding-node-back-pointer (find-node 17)
          :values (list 
                    (p4::object-name-to-object 'package1 *current-problem-space*)
                    (p4::object-name-to-object 'pgh-truck *current-problem-space*)
                    (p4::object-name-to-object 'pgh-po *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-obj package1 pgh-po))
              (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-po)))))
 
(setf (p4::nexus-children (find-node 17))
  (list
    (p4::make-applied-op-node 
        :name 18 
        :parent (find-node 17)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 18))
      (p4::make-instantiated-op
          :op (p4::get-operator load-truck)
          :binding-node-back-pointer (find-node 17)
          :values (list 
                    (p4::object-name-to-object 'package1 *current-problem-space*)
                    (p4::object-name-to-object 'pgh-truck *current-problem-space*)
                    (p4::object-name-to-object 'pgh-po *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-obj package1 pgh-po))
              (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-po)))))

(setf (p4::a-or-b-node-applied (find-node 18))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 18))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(inside-truck package1 pgh-truck)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-obj package1 pgh-po))))))
 
(setf (p4::nexus-children (find-node 18))
  (list
    (p4::make-goal-node 
        :name 19 
        :parent (find-node 18) 
        :goal 
            (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-airport)) 
        :introducing-operators (list (find-node 14) )))) 
 
(setf (p4::nexus-children (find-node 19))
  (list
    (p4::make-operator-node 
        :name 20 
        :parent (find-node 19) 
        :operator (p4::get-operator drive-truck))))
 
(setf (p4::nexus-children (find-node 20))
  (list
    (p4::make-binding-node 
        :name 21 
        :parent (find-node 20)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(same-city pgh-po pgh-airport))
              (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-po)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 21))
      (p4::make-instantiated-op
          :op (p4::get-operator drive-truck)
          :binding-node-back-pointer (find-node 21)
          :values (list 
                    (p4::object-name-to-object 'pgh-truck *current-problem-space*)
                    (p4::object-name-to-object 'pgh-po *current-problem-space*)
                    (p4::object-name-to-object 'pgh-airport *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(same-city pgh-po pgh-airport))
              (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-po)))))
 
(setf (p4::nexus-children (find-node 21))
  (list
    (p4::make-applied-op-node 
        :name 22 
        :parent (find-node 21)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 22))
      (p4::make-instantiated-op
          :op (p4::get-operator drive-truck)
          :binding-node-back-pointer (find-node 21)
          :values (list 
                    (p4::object-name-to-object 'pgh-truck *current-problem-space*)
                    (p4::object-name-to-object 'pgh-po *current-problem-space*)
                    (p4::object-name-to-object 'pgh-airport *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(same-city pgh-po pgh-airport))
              (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-po)))))

(setf (p4::a-or-b-node-applied (find-node 22))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 22))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-airport)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-po))))))
 
(setf (p4::nexus-children (find-node 22))
  (list
    (p4::make-applied-op-node 
        :name 23 
        :parent (find-node 22)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 23))
      (p4::make-instantiated-op
          :op (p4::get-operator unload-truck)
          :binding-node-back-pointer (find-node 14)
          :values (list 
                    (p4::object-name-to-object 'package1 *current-problem-space*)
                    (p4::object-name-to-object 'pgh-truck *current-problem-space*)
                    (p4::object-name-to-object 'pgh-airport *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside-truck package1 pgh-truck))
              (p4::instantiate-consed-literal '(at-truck pgh-truck pgh-airport)))))

(setf (p4::a-or-b-node-applied (find-node 23))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 23))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-obj package1 pgh-airport)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(inside-truck package1 pgh-truck))))))
 
(setf (p4::nexus-children (find-node 23))
  (list
    (p4::make-goal-node 
        :name 24 
        :parent (find-node 23) 
        :goal 
            (p4::instantiate-consed-literal '(at-airplane airplane1 pgh-airport)) 
        :introducing-operators (list (find-node 11) )))) 
 
(setf (p4::nexus-children (find-node 24))
  (list
    (p4::make-operator-node 
        :name 25 
        :parent (find-node 24) 
        :operator (p4::get-operator fly-airplane))))
 
(setf (p4::nexus-children (find-node 25))
  (list
    (p4::make-binding-node 
        :name 26 
        :parent (find-node 25)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(at-airplane airplane1 bos-airport))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 26))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-airplane)
          :binding-node-back-pointer (find-node 26)
          :values (list 
                    (p4::object-name-to-object 'airplane1 *current-problem-space*)
                    (p4::object-name-to-object 'bos-airport *current-problem-space*)
                    (p4::object-name-to-object 'pgh-airport *current-problem-space*))
          :precond 
            (p4::instantiate-consed-literal '(at-airplane airplane1 bos-airport))))
 
(setf (p4::nexus-children (find-node 26))
  (list
    (p4::make-applied-op-node 
        :name 27 
        :parent (find-node 26)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 27))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-airplane)
          :binding-node-back-pointer (find-node 26)
          :values (list 
                    (p4::object-name-to-object 'airplane1 *current-problem-space*)
                    (p4::object-name-to-object 'bos-airport *current-problem-space*)
                    (p4::object-name-to-object 'pgh-airport *current-problem-space*))
          :precond 
            (p4::instantiate-consed-literal '(at-airplane airplane1 bos-airport))))

(setf (p4::a-or-b-node-applied (find-node 27))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 27))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-airplane airplane1 pgh-airport)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-airplane airplane1 bos-airport))))))
 
(setf (p4::nexus-children (find-node 27))
  (list
    (p4::make-applied-op-node 
        :name 28 
        :parent (find-node 27)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 28))
      (p4::make-instantiated-op
          :op (p4::get-operator load-airplane)
          :binding-node-back-pointer (find-node 11)
          :values (list 
                    (p4::object-name-to-object 'package1 *current-problem-space*)
                    (p4::object-name-to-object 'airplane1 *current-problem-space*)
                    (p4::object-name-to-object 'pgh-airport *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-obj package1 pgh-airport))
              (p4::instantiate-consed-literal '(at-airplane airplane1 pgh-airport)))))

(setf (p4::a-or-b-node-applied (find-node 28))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 28))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(inside-airplane package1 airplane1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-obj package1 pgh-airport))))))
 
(setf (p4::nexus-children (find-node 28))
  (list
    (p4::make-goal-node 
        :name 29 
        :parent (find-node 28) 
        :goal 
            (p4::instantiate-consed-literal '(at-airplane airplane1 bos-airport)) 
        :introducing-operators (list (find-node 8) )))) 
 
(setf (p4::nexus-children (find-node 29))
  (list
    (p4::make-operator-node 
        :name 30 
        :parent (find-node 29) 
        :operator (p4::get-operator fly-airplane))))
 
(setf (p4::nexus-children (find-node 30))
  (list
    (p4::make-binding-node 
        :name 31 
        :parent (find-node 30)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(at-airplane airplane1 pgh-airport))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 31))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-airplane)
          :binding-node-back-pointer (find-node 31)
          :values (list 
                    (p4::object-name-to-object 'airplane1 *current-problem-space*)
                    (p4::object-name-to-object 'pgh-airport *current-problem-space*)
                    (p4::object-name-to-object 'bos-airport *current-problem-space*))
          :precond 
            (p4::instantiate-consed-literal '(at-airplane airplane1 pgh-airport))))
 
(setf (p4::nexus-children (find-node 31))
  (list
    (p4::make-applied-op-node 
        :name 32 
        :parent (find-node 31)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 32))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-airplane)
          :binding-node-back-pointer (find-node 31)
          :values (list 
                    (p4::object-name-to-object 'airplane1 *current-problem-space*)
                    (p4::object-name-to-object 'pgh-airport *current-problem-space*)
                    (p4::object-name-to-object 'bos-airport *current-problem-space*))
          :precond 
            (p4::instantiate-consed-literal '(at-airplane airplane1 pgh-airport))))

(setf (p4::a-or-b-node-applied (find-node 32))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 32))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-airplane airplane1 bos-airport)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-airplane airplane1 pgh-airport))))))
 
(setf (p4::nexus-children (find-node 32))
  (list
    (p4::make-applied-op-node 
        :name 33 
        :parent (find-node 32)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 33))
      (p4::make-instantiated-op
          :op (p4::get-operator unload-airplane)
          :binding-node-back-pointer (find-node 8)
          :values (list 
                    (p4::object-name-to-object 'package1 *current-problem-space*)
                    (p4::object-name-to-object 'airplane1 *current-problem-space*)
                    (p4::object-name-to-object 'bos-airport *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside-airplane package1 airplane1))
              (p4::instantiate-consed-literal '(at-airplane airplane1 bos-airport)))))

(setf (p4::a-or-b-node-applied (find-node 33))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 33))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-obj package1 bos-airport)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(inside-airplane package1 airplane1))))))
