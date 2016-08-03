 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(holding researcher stinger1))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(holding researcher stinger1))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(holding researcher stinger1)) 
        :introducing-operators (list (find-node 4) )))) 

(setf (p4::literal-neg-goal-p
       (p4::goal-node-goal (find-node 5)
       '(#<can-fly-domestic [<person> researcher] [<nationality> usa] [<start-airport> airbase] [<start-city> whitesands] [<dest-airport> hartsfield] [<dest-city> atlanta]>))))
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator pick-up))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher airbase))
              (p4::instantiate-consed-literal '(at-loc-o stinger1 airbase))
              (list '~ (p4::instantiate-consed-literal '(immobile stinger1))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'stinger1 *current-problem-space*)
                    (p4::object-name-to-object 'airbase *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher airbase))
              (p4::instantiate-consed-literal '(at-loc-o stinger1 airbase))
              (list '~ (p4::instantiate-consed-literal '(immobile stinger1))))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-applied-op-node 
        :name 8 
        :parent (find-node 7)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 8))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'stinger1 *current-problem-space*)
                    (p4::object-name-to-object 'airbase *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher airbase))
              (p4::instantiate-consed-literal '(at-loc-o stinger1 airbase))
              (list '~ (p4::instantiate-consed-literal '(immobile stinger1))))))

(setf (p4::a-or-b-node-applied (find-node 8))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 8))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding researcher stinger1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-o stinger1 airbase))))))
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-goal-node 
        :name 9 
        :parent (find-node 8) 
        :goal 
            (p4::instantiate-consed-literal '(in-city-p researcher atlanta)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-operator-node 
        :name 10 
        :parent (find-node 9) 
        :operator (p4::get-operator fly))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-binding-node 
        :name 11 
        :parent (find-node 10)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(can-fly researcher whitesands atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher airbase))
              (p4::instantiate-consed-literal '(in-city-l airbase whitesands))
              (p4::instantiate-consed-literal '(in-city-p researcher whitesands))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 11))
      (p4::make-instantiated-op
          :op (p4::get-operator fly)
          :binding-node-back-pointer (find-node 11)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'airbase *current-problem-space*)
                    (p4::object-name-to-object 'whitesands *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(can-fly researcher whitesands atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher airbase))
              (p4::instantiate-consed-literal '(in-city-l airbase whitesands))
              (p4::instantiate-consed-literal '(in-city-p researcher whitesands))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta)))))
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-goal-node 
        :name 12 
        :parent (find-node 11) 
        :goal 
            (p4::instantiate-consed-literal '(can-fly researcher whitesands atlanta)) 
        :introducing-operators (list (find-node 11) )))) 
 
(setf (p4::nexus-children (find-node 12))
  (list
    (p4::make-operator-node 
        :name 13 
        :parent (find-node 12) 
        :operator (p4::get-operator can-fly-domestic))))
 
(setf (p4::nexus-children (find-node 13))
  (list
    (p4::make-binding-node 
        :name 16 
        :parent (find-node 13)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher airbase))
              (p4::instantiate-consed-literal '(in-city-l airbase whitesands))
              (p4::instantiate-consed-literal '(in-city-p researcher whitesands))
              (p4::instantiate-consed-literal '(in-country whitesands usa))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (list 'or 
                (list '~ (p4::instantiate-consed-literal '(air-security usa high)))
                (list '~ (p4::instantiate-consed-literal '(exists ((<missile> missile)) (holding <person> <missile>))))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 16))
      (p4::make-instantiated-op
          :op (p4::get-operator can-fly-domestic)
          :binding-node-back-pointer (find-node 16)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'airbase *current-problem-space*)
                    (p4::object-name-to-object 'whitesands *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher airbase))
              (p4::instantiate-consed-literal '(in-city-l airbase whitesands))
              (p4::instantiate-consed-literal '(in-city-p researcher whitesands))
              (p4::instantiate-consed-literal '(in-country whitesands usa))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (list 'or 
                (list '~ (p4::instantiate-consed-literal '(air-security usa high)))
                (list '~ (p4::instantiate-consed-literal '(exists ((<missile> missile)) (holding <person> <missile>))))))))
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-goal-node 
        :name 17 
        :parent (find-node 16) 
        :goal 
            (p4::instantiate-consed-literal '(holding researcher stinger1)) 
        :introducing-operators (list (find-node 16) )))) 

(setf (p4::literal-neg-goal-p
       (p4::goal-node-goal (find-node 17)
       '(#<can-fly-domestic [<person> researcher] [<nationality> usa] [<start-airport> airbase] [<start-city> whitesands] [<dest-airport> hartsfield] [<dest-city> atlanta]>))))
 
(setf (p4::nexus-children (find-node 17))
  (list
    (p4::make-operator-node 
        :name 18 
        :parent (find-node 17) 
        :operator (p4::get-operator put-in))))
 
(setf (p4::nexus-children (find-node 18))
  (list
    (p4::make-binding-node 
        :name 19 
        :parent (find-node 18)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(holding researcher stinger1))
              (p4::instantiate-consed-literal '(holding researcher luggage1)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 19))
      (p4::make-instantiated-op
          :op (p4::get-operator put-in)
          :binding-node-back-pointer (find-node 19)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'stinger1 *current-problem-space*)
                    (p4::object-name-to-object 'luggage1 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(holding researcher stinger1))
              (p4::instantiate-consed-literal '(holding researcher luggage1)))))
 
(setf (p4::nexus-children (find-node 19))
  (list
    (p4::make-goal-node 
        :name 20 
        :parent (find-node 19) 
        :goal 
            (p4::instantiate-consed-literal '(holding researcher luggage1)) 
        :introducing-operators (list (find-node 19) )))) 
 
(setf (p4::nexus-children (find-node 20))
  (list
    (p4::make-operator-node 
        :name 21 
        :parent (find-node 20) 
        :operator (p4::get-operator pick-up))))
 
(setf (p4::nexus-children (find-node 21))
  (list
    (p4::make-binding-node 
        :name 22 
        :parent (find-node 21)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher airbase))
              (p4::instantiate-consed-literal '(at-loc-o luggage1 airbase))
              (list '~ (p4::instantiate-consed-literal '(immobile luggage1))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 22))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 22)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'luggage1 *current-problem-space*)
                    (p4::object-name-to-object 'airbase *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher airbase))
              (p4::instantiate-consed-literal '(at-loc-o luggage1 airbase))
              (list '~ (p4::instantiate-consed-literal '(immobile luggage1))))))
 
(setf (p4::nexus-children (find-node 22))
  (list
    (p4::make-applied-op-node 
        :name 23 
        :parent (find-node 22)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 23))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 22)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'luggage1 *current-problem-space*)
                    (p4::object-name-to-object 'airbase *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher airbase))
              (p4::instantiate-consed-literal '(at-loc-o luggage1 airbase))
              (list '~ (p4::instantiate-consed-literal '(immobile luggage1))))))

(setf (p4::a-or-b-node-applied (find-node 23))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 23))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding researcher luggage1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-o luggage1 airbase))))))
 
(setf (p4::nexus-children (find-node 23))
  (list
    (p4::make-applied-op-node 
        :name 24 
        :parent (find-node 23)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 24))
      (p4::make-instantiated-op
          :op (p4::get-operator put-in)
          :binding-node-back-pointer (find-node 19)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'stinger1 *current-problem-space*)
                    (p4::object-name-to-object 'luggage1 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(holding researcher stinger1))
              (p4::instantiate-consed-literal '(holding researcher luggage1)))))

(setf (p4::a-or-b-node-applied (find-node 24))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 24))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(can-fly researcher whitesands atlanta))))))
 
(setf (p4::nexus-children (find-node 24))
  (list
    (p4::make-applied-op-node 
        :name 25 
        :parent (find-node 24)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 25))
      (p4::make-instantiated-op
          :op (p4::get-operator fly)
          :binding-node-back-pointer (find-node 11)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'airbase *current-problem-space*)
                    (p4::object-name-to-object 'whitesands *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(can-fly researcher whitesands atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher airbase))
              (p4::instantiate-consed-literal '(in-city-l airbase whitesands))
              (p4::instantiate-consed-literal '(in-city-p researcher whitesands))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta)))))

(setf (p4::a-or-b-node-applied (find-node 25))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 25))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(in-city-p researcher whitesands))
                 (p4::instantiate-consed-literal '(can-fly researcher whitesands atlanta))
                 (p4::instantiate-consed-literal '(at-loc-p researcher airbase))))))
 
(setf (p4::nexus-children (find-node 25))
  (list
    (p4::make-goal-node 
        :name 26 
        :parent (find-node 25) 
        :goal 
            (p4::instantiate-consed-literal '(holding researcher stinger1)) 
        :introducing-operators (list (find-node 4) )))) 

(setf (p4::literal-neg-goal-p
       (p4::goal-node-goal (find-node 26)
       '(#<can-fly-domestic [<person> researcher] [<nationality> usa] [<start-airport> airbase] [<start-city> whitesands] [<dest-airport> hartsfield] [<dest-city> atlanta]>))))
 
(setf (p4::nexus-children (find-node 26))
  (list
    (p4::make-operator-node 
        :name 27 
        :parent (find-node 26) 
        :operator (p4::get-operator take-out))))
 
(setf (p4::nexus-children (find-node 27))
  (list
    (p4::make-binding-node 
        :name 28 
        :parent (find-node 27)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(contains luggage1 stinger1))
              (p4::instantiate-consed-literal '(holding researcher luggage1)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 28))
      (p4::make-instantiated-op
          :op (p4::get-operator take-out)
          :binding-node-back-pointer (find-node 28)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'stinger1 *current-problem-space*)
                    (p4::object-name-to-object 'luggage1 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(contains luggage1 stinger1))
              (p4::instantiate-consed-literal '(holding researcher luggage1)))))
 
(setf (p4::nexus-children (find-node 28))
  (list
    (p4::make-applied-op-node 
        :name 29 
        :parent (find-node 28)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29))
      (p4::make-instantiated-op
          :op (p4::get-operator take-out)
          :binding-node-back-pointer (find-node 28)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'stinger1 *current-problem-space*)
                    (p4::object-name-to-object 'luggage1 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(contains luggage1 stinger1))
              (p4::instantiate-consed-literal '(holding researcher luggage1)))))

(setf (p4::a-or-b-node-applied (find-node 29))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 29))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding researcher stinger1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(contains luggage1 stinger1))))))
