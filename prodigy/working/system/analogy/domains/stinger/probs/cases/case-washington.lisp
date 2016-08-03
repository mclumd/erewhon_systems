 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(destroyed monument)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(destroyed monument)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(destroyed monument)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator launch))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-o monument mall))
              (list 'and 
                (p4::instantiate-consed-literal '(at-loc-p researcher dulles))
                (p4::instantiate-consed-literal '(holding researcher stinger1))
                (p4::instantiate-consed-literal '(in-city-l dulles washington))
                (p4::instantiate-consed-literal '(in-city-l mall washington))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator launch)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'stinger1 *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'mall *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*)
                    (p4::object-name-to-object 'monument *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-o monument mall))
              (list 'and 
                (p4::instantiate-consed-literal '(at-loc-p researcher dulles))
                (p4::instantiate-consed-literal '(holding researcher stinger1))
                (p4::instantiate-consed-literal '(in-city-l dulles washington))
                (p4::instantiate-consed-literal '(in-city-l mall washington))))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher dulles)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator fly-domestic))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-country washington usa)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-country washington usa)))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-goal-node 
        :name 11 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)) 
        :introducing-operators (list (find-node 10) )))) 
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-operator-node 
        :name 12 
        :parent (find-node 11) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 12))
  (list
    (p4::make-binding-node 
        :name 13 
        :parent (find-node 12)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 13))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 13)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'georgiatech *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech)))))
 
(setf (p4::nexus-children (find-node 13))
  (list
    (p4::make-applied-op-node 
        :name 14 
        :parent (find-node 13)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 14))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 13)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'georgiatech *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech)))))

(setf (p4::a-or-b-node-applied (find-node 14))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 14))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech))))))
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-applied-op-node 
        :name 15 
        :parent (find-node 14)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 15))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-country washington usa)))))

(setf (p4::a-or-b-node-applied (find-node 15))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 15))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(in-city-p researcher washington))
                 (p4::instantiate-consed-literal '(at-loc-p researcher dulles)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))))))
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-applied-op-node 
        :name 16 
        :parent (find-node 15)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 16))
      (p4::make-instantiated-op
          :op (p4::get-operator launch)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'stinger1 *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'mall *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*)
                    (p4::object-name-to-object 'monument *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-o monument mall))
              (list 'and 
                (p4::instantiate-consed-literal '(at-loc-p researcher dulles))
                (p4::instantiate-consed-literal '(holding researcher stinger1))
                (p4::instantiate-consed-literal '(in-city-l dulles washington))
                (p4::instantiate-consed-literal '(in-city-l mall washington))))))

(setf (p4::a-or-b-node-applied (find-node 16))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 16))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(destroyed stinger1))
                 (p4::instantiate-consed-literal '(destroyed monument)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(holding researcher stinger1))))))
