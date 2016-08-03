 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher convention))
              (p4::instantiate-consed-literal '(holding researcher akr)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher convention))
              (p4::instantiate-consed-literal '(holding researcher akr)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher convention)) 
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
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l convention washington))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'convention *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l convention washington))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles)))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(in-city-p researcher washington)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator fly))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(can-fly researcher atlanta washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-city-l dulles washington)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator fly)
          :binding-node-back-pointer (find-node 10)
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
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-goal-node 
        :name 11 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(can-fly researcher atlanta washington)) 
        :introducing-operators (list (find-node 10) )))) 
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-operator-node 
        :name 12 
        :parent (find-node 11) 
        :operator (p4::get-operator can-fly-domestic))))
 
(setf (p4::nexus-children (find-node 12))
  (list
    (p4::make-binding-node 
        :name 13 
        :parent (find-node 12)
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

(setf (p4::a-or-b-node-instantiated-op (find-node 13))
      (p4::make-instantiated-op
          :op (p4::get-operator can-fly-domestic)
          :binding-node-back-pointer (find-node 13)
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
 
(setf (p4::nexus-children (find-node 13))
  (list
    (p4::make-goal-node 
        :name 14 
        :parent (find-node 13) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)) 
        :introducing-operators (list (find-node 13) (find-node 10) )))) 
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-operator-node 
        :name 15 
        :parent (find-node 14) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-binding-node 
        :name 16 
        :parent (find-node 15)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 16))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 16)
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
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-applied-op-node 
        :name 17 
        :parent (find-node 16)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 17))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 16)
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

(setf (p4::a-or-b-node-applied (find-node 17))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 17))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(can-fly researcher atlanta washington))))))
 
(setf (p4::nexus-children (find-node 17))
  (list
    (p4::make-applied-op-node 
        :name 18 
        :parent (find-node 17)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 18))
      (p4::make-instantiated-op
          :op (p4::get-operator fly)
          :binding-node-back-pointer (find-node 10)
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

(setf (p4::a-or-b-node-applied (find-node 18))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 18))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(in-city-p researcher washington))
                 (p4::instantiate-consed-literal '(at-loc-p researcher dulles)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
                 (p4::instantiate-consed-literal '(can-fly researcher atlanta washington))
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))))))
 
(setf (p4::nexus-children (find-node 18))
  (list
    (p4::make-applied-op-node 
        :name 19 
        :parent (find-node 18)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 19))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'convention *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l convention washington))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles)))))

(setf (p4::a-or-b-node-applied (find-node 19))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 19))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher convention)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher dulles))))))
 
(setf (p4::nexus-children (find-node 19))
  (list
    (p4::make-goal-node 
        :name 20 
        :parent (find-node 19) 
        :goal 
            (p4::instantiate-consed-literal '(holding researcher akr)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 20))
  (list
    (p4::make-operator-node 
        :name 21 
        :parent (find-node 20) 
        :operator (p4::get-operator pick-up))))
 
(setf (p4::nexus-children (find-node 21))
  (list
    (p4::make-binding-node 
        :name 26 
        :parent (find-node 21)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher kinkos))
              (p4::instantiate-consed-literal '(at-loc-o akr kinkos))
              (list '~ (p4::instantiate-consed-literal '(immobile akr))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 26))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 26)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'akr *current-problem-space*)
                    (p4::object-name-to-object 'kinkos *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher kinkos))
              (p4::instantiate-consed-literal '(at-loc-o akr kinkos))
              (list '~ (p4::instantiate-consed-literal '(immobile akr))))))
 
(setf (p4::nexus-children (find-node 26))
  (list
    (p4::make-goal-node 
        :name 27 
        :parent (find-node 26) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher kinkos)) 
        :introducing-operators (list (find-node 26) )))) 
 
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
              (p4::instantiate-consed-literal '(in-city-l kinkos atlanta))
              (p4::instantiate-consed-literal '(in-city-l kingstavern atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 29)
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
 
(setf (p4::nexus-children (find-node 29))
  (list
    (p4::make-goal-node 
        :name 30 
        :parent (find-node 29) 
        :goal 
            (p4::instantiate-consed-literal '(in-city-p researcher atlanta)) 
        :introducing-operators (list (find-node 29) )))) 
 
(setf (p4::nexus-children (find-node 30))
  (list
    (p4::make-operator-node 
        :name 31 
        :parent (find-node 30) 
        :operator (p4::get-operator fly))))
 
(setf (p4::nexus-children (find-node 31))
  (list
    (p4::make-binding-node 
        :name 32 
        :parent (find-node 31)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(can-fly researcher washington atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 32))
      (p4::make-instantiated-op
          :op (p4::get-operator fly)
          :binding-node-back-pointer (find-node 32)
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
 
(setf (p4::nexus-children (find-node 32))
  (list
    (p4::make-goal-node 
        :name 33 
        :parent (find-node 32) 
        :goal 
            (p4::instantiate-consed-literal '(can-fly researcher washington atlanta)) 
        :introducing-operators (list (find-node 32) )))) 
 
(setf (p4::nexus-children (find-node 33))
  (list
    (p4::make-operator-node 
        :name 34 
        :parent (find-node 33) 
        :operator (p4::get-operator can-fly-domestic))))
 
(setf (p4::nexus-children (find-node 34))
  (list
    (p4::make-binding-node 
        :name 35 
        :parent (find-node 34)
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

(setf (p4::a-or-b-node-instantiated-op (find-node 35))
      (p4::make-instantiated-op
          :op (p4::get-operator can-fly-domestic)
          :binding-node-back-pointer (find-node 35)
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
 
(setf (p4::nexus-children (find-node 35))
  (list
    (p4::make-goal-node 
        :name 36 
        :parent (find-node 35) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher dulles)) 
        :introducing-operators (list (find-node 35) (find-node 32) )))) 
 
(setf (p4::nexus-children (find-node 36))
  (list
    (p4::make-operator-node 
        :name 37 
        :parent (find-node 36) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 37))
  (list
    (p4::make-binding-node 
        :name 38 
        :parent (find-node 37)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-l convention washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher convention)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 38))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 38)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'convention *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-l convention washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher convention)))))
 
(setf (p4::nexus-children (find-node 38))
  (list
    (p4::make-applied-op-node 
        :name 39 
        :parent (find-node 38)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 39))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 38)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'convention *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-l convention washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher convention)))))

(setf (p4::a-or-b-node-applied (find-node 39))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 39))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(can-fly researcher washington atlanta))))))
 
(setf (p4::nexus-children (find-node 39))
  (list
    (p4::make-applied-op-node 
        :name 40 
        :parent (find-node 39)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 40))
      (p4::make-instantiated-op
          :op (p4::get-operator fly)
          :binding-node-back-pointer (find-node 32)
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

(setf (p4::a-or-b-node-applied (find-node 40))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 40))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(in-city-p researcher washington))
                 (p4::instantiate-consed-literal '(can-fly researcher washington atlanta))
                 (p4::instantiate-consed-literal '(at-loc-p researcher dulles))))))
 
(setf (p4::nexus-children (find-node 40))
  (list
    (p4::make-goal-node 
        :name 41 
        :parent (find-node 40) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern)) 
        :introducing-operators (list (find-node 29) )))) 
 
(setf (p4::nexus-children (find-node 41))
  (list
    (p4::make-operator-node 
        :name 42 
        :parent (find-node 41) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 42))
  (list
    (p4::make-binding-node 
        :name 43 
        :parent (find-node 42)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l kingstavern atlanta))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 43))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 43)
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
 
(setf (p4::nexus-children (find-node 43))
  (list
    (p4::make-applied-op-node 
        :name 44 
        :parent (find-node 43)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 44))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 43)
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

(setf (p4::a-or-b-node-applied (find-node 44))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 44))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))))))
 
(setf (p4::nexus-children (find-node 44))
  (list
    (p4::make-applied-op-node 
        :name 45 
        :parent (find-node 44)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 45))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 29)
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

(setf (p4::a-or-b-node-applied (find-node 45))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 45))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher kinkos)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern))))))
 
(setf (p4::nexus-children (find-node 45))
  (list
    (p4::make-applied-op-node 
        :name 46 
        :parent (find-node 45)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 46))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 26)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'akr *current-problem-space*)
                    (p4::object-name-to-object 'kinkos *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher kinkos))
              (p4::instantiate-consed-literal '(at-loc-o akr kinkos))
              (list '~ (p4::instantiate-consed-literal '(immobile akr))))))

(setf (p4::a-or-b-node-applied (find-node 46))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 46))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding researcher akr)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-o akr kinkos))))))
 
(setf (p4::nexus-children (find-node 46))
  (list
    (p4::make-goal-node 
        :name 47 
        :parent (find-node 46) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher convention)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 47))
  (list
    (p4::make-operator-node 
        :name 48 
        :parent (find-node 47) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 48))
  (list
    (p4::make-binding-node 
        :name 49 
        :parent (find-node 48)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l convention washington))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 49))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 49)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'convention *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l convention washington))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles)))))
 
(setf (p4::nexus-children (find-node 49))
  (list
    (p4::make-goal-node 
        :name 50 
        :parent (find-node 49) 
        :goal 
            (p4::instantiate-consed-literal '(in-city-p researcher washington)) 
        :introducing-operators (list (find-node 49) )))) 
 
(setf (p4::nexus-children (find-node 50))
  (list
    (p4::make-operator-node 
        :name 51 
        :parent (find-node 50) 
        :operator (p4::get-operator fly))))
 
(setf (p4::nexus-children (find-node 51))
  (list
    (p4::make-binding-node 
        :name 52 
        :parent (find-node 51)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(can-fly researcher atlanta washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-city-l dulles washington)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 52))
      (p4::make-instantiated-op
          :op (p4::get-operator fly)
          :binding-node-back-pointer (find-node 52)
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
 
(setf (p4::nexus-children (find-node 52))
  (list
    (p4::make-goal-node 
        :name 53 
        :parent (find-node 52) 
        :goal 
            (p4::instantiate-consed-literal '(can-fly researcher atlanta washington)) 
        :introducing-operators (list (find-node 52) )))) 
 
(setf (p4::nexus-children (find-node 53))
  (list
    (p4::make-operator-node 
        :name 54 
        :parent (find-node 53) 
        :operator (p4::get-operator can-fly-domestic))))
 
(setf (p4::nexus-children (find-node 54))
  (list
    (p4::make-binding-node 
        :name 55 
        :parent (find-node 54)
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

(setf (p4::a-or-b-node-instantiated-op (find-node 55))
      (p4::make-instantiated-op
          :op (p4::get-operator can-fly-domestic)
          :binding-node-back-pointer (find-node 55)
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
 
(setf (p4::nexus-children (find-node 55))
  (list
    (p4::make-goal-node 
        :name 56 
        :parent (find-node 55) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)) 
        :introducing-operators (list (find-node 55) (find-node 52) )))) 
 
(setf (p4::nexus-children (find-node 56))
  (list
    (p4::make-operator-node 
        :name 57 
        :parent (find-node 56) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 57))
  (list
    (p4::make-binding-node 
        :name 58 
        :parent (find-node 57)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-l kinkos atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher kinkos)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 58))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 58)
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
 
(setf (p4::nexus-children (find-node 58))
  (list
    (p4::make-applied-op-node 
        :name 59 
        :parent (find-node 58)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 59))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 58)
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

(setf (p4::a-or-b-node-applied (find-node 59))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 59))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(can-fly researcher atlanta washington))))))
 
(setf (p4::nexus-children (find-node 59))
  (list
    (p4::make-applied-op-node 
        :name 60 
        :parent (find-node 59)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 60))
      (p4::make-instantiated-op
          :op (p4::get-operator fly)
          :binding-node-back-pointer (find-node 52)
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

(setf (p4::a-or-b-node-applied (find-node 60))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 60))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(in-city-p researcher washington))
                 (p4::instantiate-consed-literal '(at-loc-p researcher dulles)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
                 (p4::instantiate-consed-literal '(can-fly researcher atlanta washington))
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))))))
 
(setf (p4::nexus-children (find-node 60))
  (list
    (p4::make-applied-op-node 
        :name 61 
        :parent (find-node 60)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 61))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 49)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'convention *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l convention washington))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles)))))

(setf (p4::a-or-b-node-applied (find-node 61))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 61))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher convention)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher dulles))))))
