 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(holding researcher akr)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(holding researcher akr)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(in-city-p researcher washington)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator fly))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(can-fly researcher atlanta washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-city-l dulles washington)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator fly)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(can-fly researcher atlanta washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-city-l dulles washington)))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(can-fly researcher atlanta washington)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator can-fly-domestic))))
 
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
              (p4::instantiate-consed-literal '(in-country washington usa))
              (list 'or 
                (list '~ (p4::instantiate-consed-literal '(air-security usa high)))
                (list '~ (p4::instantiate-consed-literal '(exists ((<missile> missile)) (holding <person> <missile>))))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator can-fly-domestic)
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
              (p4::instantiate-consed-literal '(in-country washington usa))
              (list 'or 
                (list '~ (p4::instantiate-consed-literal '(air-security usa high)))
                (list '~ (p4::instantiate-consed-literal '(exists ((<missile> missile)) (holding <person> <missile>))))))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-goal-node 
        :name 11 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)) 
        :introducing-operators (list (find-node 10) (find-node 7) )))) 
 
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
                 (p4::instantiate-consed-literal '(can-fly researcher atlanta washington))))))
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-applied-op-node 
        :name 15 
        :parent (find-node 14)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 15))
      (p4::make-instantiated-op
          :op (p4::get-operator fly)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(can-fly researcher atlanta washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-city-l dulles washington)))))

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
                 (p4::instantiate-consed-literal '(can-fly researcher atlanta washington))
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))))))
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-goal-node 
        :name 16 
        :parent (find-node 15) 
        :goal 
            (p4::instantiate-consed-literal '(holding researcher akr)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-operator-node 
        :name 17 
        :parent (find-node 16) 
        :operator (p4::get-operator pick-up))))
 
(setf (p4::nexus-children (find-node 17))
  (list
    (p4::make-binding-node 
        :name 22 
        :parent (find-node 17)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher kinkos))
              (p4::instantiate-consed-literal '(at-loc-o akr kinkos))
              (list '~ (p4::instantiate-consed-literal '(immobile akr))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 22))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 22)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'akr *current-problem-space*)
                    (p4::object-name-to-object 'kinkos *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher kinkos))
              (p4::instantiate-consed-literal '(at-loc-o akr kinkos))
              (list '~ (p4::instantiate-consed-literal '(immobile akr))))))
 
(setf (p4::nexus-children (find-node 22))
  (list
    (p4::make-goal-node 
        :name 23 
        :parent (find-node 22) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher kinkos)) 
        :introducing-operators (list (find-node 22) )))) 
 
(setf (p4::nexus-children (find-node 23))
  (list
    (p4::make-operator-node 
        :name 24 
        :parent (find-node 23) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 24))
  (list
    (p4::make-binding-node 
        :name 25 
        :parent (find-node 24)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l kinkos atlanta))
              (p4::instantiate-consed-literal '(in-city-l kingstavern atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 25))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 25)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'kingstavern *current-problem-space*)
                    (p4::object-name-to-object 'kinkos *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l kinkos atlanta))
              (p4::instantiate-consed-literal '(in-city-l kingstavern atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern)))))
 
(setf (p4::nexus-children (find-node 25))
  (list
    (p4::make-goal-node 
        :name 26 
        :parent (find-node 25) 
        :goal 
            (p4::instantiate-consed-literal '(in-city-p researcher atlanta)) 
        :introducing-operators (list (find-node 25) )))) 
 
(setf (p4::nexus-children (find-node 26))
  (list
    (p4::make-operator-node 
        :name 27 
        :parent (find-node 26) 
        :operator (p4::get-operator fly))))
 
(setf (p4::nexus-children (find-node 27))
  (list
    (p4::make-binding-node 
        :name 28 
        :parent (find-node 27)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(can-fly researcher washington atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 28))
      (p4::make-instantiated-op
          :op (p4::get-operator fly)
          :binding-node-back-pointer (find-node 28)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(can-fly researcher washington atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta)))))
 
(setf (p4::nexus-children (find-node 28))
  (list
    (p4::make-goal-node 
        :name 29 
        :parent (find-node 28) 
        :goal 
            (p4::instantiate-consed-literal '(can-fly researcher washington atlanta)) 
        :introducing-operators (list (find-node 28) )))) 
 
(setf (p4::nexus-children (find-node 29))
  (list
    (p4::make-operator-node 
        :name 30 
        :parent (find-node 29) 
        :operator (p4::get-operator can-fly-domestic))))
 
(setf (p4::nexus-children (find-node 30))
  (list
    (p4::make-binding-node 
        :name 31 
        :parent (find-node 30)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(in-country washington usa))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (list 'or 
                (list '~ (p4::instantiate-consed-literal '(air-security usa high)))
                (list '~ (p4::instantiate-consed-literal '(exists ((<missile> missile)) (holding <person> <missile>))))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 31))
      (p4::make-instantiated-op
          :op (p4::get-operator can-fly-domestic)
          :binding-node-back-pointer (find-node 31)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(in-country washington usa))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (list 'or 
                (list '~ (p4::instantiate-consed-literal '(air-security usa high)))
                (list '~ (p4::instantiate-consed-literal '(exists ((<missile> missile)) (holding <person> <missile>))))))))
 
(setf (p4::nexus-children (find-node 31))
  (list
    (p4::make-applied-op-node 
        :name 32 
        :parent (find-node 31)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 32))
      (p4::make-instantiated-op
          :op (p4::get-operator fly)
          :binding-node-back-pointer (find-node 28)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(can-fly researcher washington atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta)))))

(setf (p4::a-or-b-node-applied (find-node 32))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 32))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(in-city-p researcher washington))
                 (p4::instantiate-consed-literal '(can-fly researcher washington atlanta))
                 (p4::instantiate-consed-literal '(at-loc-p researcher dulles))))))
 
(setf (p4::nexus-children (find-node 32))
  (list
    (p4::make-goal-node 
        :name 33 
        :parent (find-node 32) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern)) 
        :introducing-operators (list (find-node 25) )))) 
 
(setf (p4::nexus-children (find-node 33))
  (list
    (p4::make-operator-node 
        :name 34 
        :parent (find-node 33) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 34))
  (list
    (p4::make-binding-node 
        :name 35 
        :parent (find-node 34)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l kingstavern atlanta))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 35))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 35)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'kingstavern *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l kingstavern atlanta))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))))
 
(setf (p4::nexus-children (find-node 35))
  (list
    (p4::make-applied-op-node 
        :name 36 
        :parent (find-node 35)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 36))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 35)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'kingstavern *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l kingstavern atlanta))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))))

(setf (p4::a-or-b-node-applied (find-node 36))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 36))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))))))
 
(setf (p4::nexus-children (find-node 36))
  (list
    (p4::make-applied-op-node 
        :name 37 
        :parent (find-node 36)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 37))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 25)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'kingstavern *current-problem-space*)
                    (p4::object-name-to-object 'kinkos *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l kinkos atlanta))
              (p4::instantiate-consed-literal '(in-city-l kingstavern atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern)))))

(setf (p4::a-or-b-node-applied (find-node 37))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 37))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher kinkos)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern))))))
 
(setf (p4::nexus-children (find-node 37))
  (list
    (p4::make-applied-op-node 
        :name 38 
        :parent (find-node 37)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 38))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 22)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'akr *current-problem-space*)
                    (p4::object-name-to-object 'kinkos *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher kinkos))
              (p4::instantiate-consed-literal '(at-loc-o akr kinkos))
              (list '~ (p4::instantiate-consed-literal '(immobile akr))))))

(setf (p4::a-or-b-node-applied (find-node 38))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 38))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding researcher akr)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-o akr kinkos))))))
 
(setf (p4::nexus-children (find-node 38))
  (list
    (p4::make-goal-node 
        :name 39 
        :parent (find-node 38) 
        :goal 
            (p4::instantiate-consed-literal '(in-city-p researcher washington)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 39))
  (list
    (p4::make-operator-node 
        :name 40 
        :parent (find-node 39) 
        :operator (p4::get-operator fly))))
 
(setf (p4::nexus-children (find-node 40))
  (list
    (p4::make-binding-node 
        :name 41 
        :parent (find-node 40)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(can-fly researcher atlanta washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-city-l dulles washington)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 41))
      (p4::make-instantiated-op
          :op (p4::get-operator fly)
          :binding-node-back-pointer (find-node 41)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(can-fly researcher atlanta washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-city-l dulles washington)))))
 
(setf (p4::nexus-children (find-node 41))
  (list
    (p4::make-goal-node 
        :name 42 
        :parent (find-node 41) 
        :goal 
            (p4::instantiate-consed-literal '(can-fly researcher atlanta washington)) 
        :introducing-operators (list (find-node 41) )))) 
 
(setf (p4::nexus-children (find-node 42))
  (list
    (p4::make-operator-node 
        :name 43 
        :parent (find-node 42) 
        :operator (p4::get-operator can-fly-domestic))))
 
(setf (p4::nexus-children (find-node 43))
  (list
    (p4::make-binding-node 
        :name 44 
        :parent (find-node 43)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-country washington usa))
              (list 'or 
                (list '~ (p4::instantiate-consed-literal '(air-security usa high)))
                (list '~ (p4::instantiate-consed-literal '(exists ((<missile> missile)) (holding <person> <missile>))))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 44))
      (p4::make-instantiated-op
          :op (p4::get-operator can-fly-domestic)
          :binding-node-back-pointer (find-node 44)
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
              (p4::instantiate-consed-literal '(in-country washington usa))
              (list 'or 
                (list '~ (p4::instantiate-consed-literal '(air-security usa high)))
                (list '~ (p4::instantiate-consed-literal '(exists ((<missile> missile)) (holding <person> <missile>))))))))
 
(setf (p4::nexus-children (find-node 44))
  (list
    (p4::make-goal-node 
        :name 45 
        :parent (find-node 44) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)) 
        :introducing-operators (list (find-node 44) (find-node 41) )))) 
 
(setf (p4::nexus-children (find-node 45))
  (list
    (p4::make-operator-node 
        :name 46 
        :parent (find-node 45) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 46))
  (list
    (p4::make-binding-node 
        :name 47 
        :parent (find-node 46)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-l kinkos atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher kinkos)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 47))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 47)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'kinkos *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-l kinkos atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher kinkos)))))
 
(setf (p4::nexus-children (find-node 47))
  (list
    (p4::make-applied-op-node 
        :name 48 
        :parent (find-node 47)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 48))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 47)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'kinkos *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-l kinkos atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher kinkos)))))

(setf (p4::a-or-b-node-applied (find-node 48))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 48))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(can-fly researcher atlanta washington))))))
 
(setf (p4::nexus-children (find-node 48))
  (list
    (p4::make-applied-op-node 
        :name 49 
        :parent (find-node 48)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 49))
      (p4::make-instantiated-op
          :op (p4::get-operator fly)
          :binding-node-back-pointer (find-node 41)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(can-fly researcher atlanta washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-city-l dulles washington)))))

(setf (p4::a-or-b-node-applied (find-node 49))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 49))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(in-city-p researcher washington))
                 (p4::instantiate-consed-literal '(at-loc-p researcher dulles)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
                 (p4::instantiate-consed-literal '(can-fly researcher atlanta washington))
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))))))
