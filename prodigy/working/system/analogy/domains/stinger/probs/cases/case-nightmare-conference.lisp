 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-p researcher iraklion))
              (p4::instantiate-consed-literal '(holding researcher akr))
              (p4::instantiate-consed-literal '(holding researcher luggage1)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-p researcher iraklion))
              (p4::instantiate-consed-literal '(holding researcher akr))
              (p4::instantiate-consed-literal '(holding researcher luggage1)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(in-city-p researcher iraklion)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 7 
        :parent (find-node 5) 
        :operator (p4::get-operator fly-international))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-binding-node 
        :name 8 
        :parent (find-node 7)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(holding researcher passport1))
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (p4::instantiate-consed-literal '(in-city-l athensport iraklion))
              (p4::instantiate-consed-literal '(in-country iraklion greece)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 8))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-international)
          :binding-node-back-pointer (find-node 8)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'passport1 *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'athensport *current-problem-space*)
                    (p4::object-name-to-object 'iraklion *current-problem-space*)
                    (p4::object-name-to-object 'greece *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(holding researcher passport1))
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (p4::instantiate-consed-literal '(in-city-l athensport iraklion))
              (p4::instantiate-consed-literal '(in-country iraklion greece)))))
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-goal-node 
        :name 9 
        :parent (find-node 8) 
        :goal 
            (p4::instantiate-consed-literal '(holding researcher passport1)) 
        :introducing-operators (list (find-node 8) )))) 
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-operator-node 
        :name 10 
        :parent (find-node 9) 
        :operator (p4::get-operator pick-up))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-binding-node 
        :name 11 
        :parent (find-node 10)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher postoffice))
              (p4::instantiate-consed-literal '(at-loc-o passport1 postoffice))
              (list '~ (p4::instantiate-consed-literal '(immobile passport1))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 11))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 11)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'passport1 *current-problem-space*)
                    (p4::object-name-to-object 'postoffice *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher postoffice))
              (p4::instantiate-consed-literal '(at-loc-o passport1 postoffice))
              (list '~ (p4::instantiate-consed-literal '(immobile passport1))))))
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-goal-node 
        :name 12 
        :parent (find-node 11) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher postoffice)) 
        :introducing-operators (list (find-node 11) )))) 
 
(setf (p4::nexus-children (find-node 12))
  (list
    (p4::make-operator-node 
        :name 13 
        :parent (find-node 12) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 13))
  (list
    (p4::make-binding-node 
        :name 14 
        :parent (find-node 13)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l postoffice washington))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 14))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 14)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'postoffice *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l postoffice washington))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles)))))
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-goal-node 
        :name 15 
        :parent (find-node 14) 
        :goal 
            (p4::instantiate-consed-literal '(in-city-p researcher washington)) 
        :introducing-operators (list (find-node 14) )))) 
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-operator-node 
        :name 16 
        :parent (find-node 15) 
        :operator (p4::get-operator fly-domestic))))
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-binding-node 
        :name 17 
        :parent (find-node 16)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-country washington usa)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 17))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 17)
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
 
(setf (p4::nexus-children (find-node 17))
  (list
    (p4::make-goal-node 
        :name 18 
        :parent (find-node 17) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)) 
        :introducing-operators (list (find-node 17) (find-node 8) )))) 
 
(setf (p4::nexus-children (find-node 18))
  (list
    (p4::make-operator-node 
        :name 19 
        :parent (find-node 18) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 19))
  (list
    (p4::make-binding-node 
        :name 20 
        :parent (find-node 19)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 20))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 20)
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
 
(setf (p4::nexus-children (find-node 20))
  (list
    (p4::make-goal-node 
        :name 21 
        :parent (find-node 20) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher dulles)) 
        :introducing-operators (list (find-node 14) )))) 
 
(setf (p4::nexus-children (find-node 21))
  (list
    (p4::make-operator-node 
        :name 22 
        :parent (find-node 21) 
        :operator (p4::get-operator fly-domestic))))
 
(setf (p4::nexus-children (find-node 22))
  (list
    (p4::make-binding-node 
        :name 23 
        :parent (find-node 22)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-country washington usa)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 23))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 23)
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
 
(setf (p4::nexus-children (find-node 23))
  (list
    (p4::make-goal-node 
        :name 24 
        :parent (find-node 23) 
        :goal 
            (p4::instantiate-consed-literal '(holding researcher akr)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 24))
  (list
    (p4::make-operator-node 
        :name 25 
        :parent (find-node 24) 
        :operator (p4::get-operator pick-up))))
 
(setf (p4::nexus-children (find-node 25))
  (list
    (p4::make-binding-node 
        :name 26 
        :parent (find-node 25)
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
              (p4::instantiate-consed-literal '(in-city-l kinkos boston))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-city-p researcher boston))
              (p4::instantiate-consed-literal '(at-loc-p researcher bostonport)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 29)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'bostonport *current-problem-space*)
                    (p4::object-name-to-object 'kinkos *current-problem-space*)
                    (p4::object-name-to-object 'boston *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l kinkos boston))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-city-p researcher boston))
              (p4::instantiate-consed-literal '(at-loc-p researcher bostonport)))))
 
(setf (p4::nexus-children (find-node 29))
  (list
    (p4::make-goal-node 
        :name 30 
        :parent (find-node 29) 
        :goal 
            (p4::instantiate-consed-literal '(in-city-p researcher boston)) 
        :introducing-operators (list (find-node 29) )))) 
 
(setf (p4::nexus-children (find-node 30))
  (list
    (p4::make-operator-node 
        :name 31 
        :parent (find-node 30) 
        :operator (p4::get-operator fly-domestic))))
 
(setf (p4::nexus-children (find-node 31))
  (list
    (p4::make-binding-node 
        :name 32 
        :parent (find-node 31)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-country boston usa)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 32))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 32)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*)
                    (p4::object-name-to-object 'bostonport *current-problem-space*)
                    (p4::object-name-to-object 'boston *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-country boston usa)))))
 
(setf (p4::nexus-children (find-node 32))
  (list
    (p4::make-goal-node 
        :name 33 
        :parent (find-node 32) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher bostonport)) 
        :introducing-operators (list (find-node 29) )))) 
 
(setf (p4::nexus-children (find-node 33))
  (list
    (p4::make-operator-node 
        :name 34 
        :parent (find-node 33) 
        :operator (p4::get-operator fly-domestic))))
 
(setf (p4::nexus-children (find-node 34))
  (list
    (p4::make-binding-node 
        :name 35 
        :parent (find-node 34)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-country boston usa)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 35))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 35)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*)
                    (p4::object-name-to-object 'bostonport *current-problem-space*)
                    (p4::object-name-to-object 'boston *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-country boston usa)))))
 
(setf (p4::nexus-children (find-node 35))
  (list
    (p4::make-goal-node 
        :name 36 
        :parent (find-node 35) 
        :goal 
            (p4::instantiate-consed-literal '(holding researcher luggage1)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 36))
  (list
    (p4::make-operator-node 
        :name 37 
        :parent (find-node 36) 
        :operator (p4::get-operator pick-up))))
 
(setf (p4::nexus-children (find-node 37))
  (list
    (p4::make-binding-node 
        :name 38 
        :parent (find-node 37)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern))
              (p4::instantiate-consed-literal '(at-loc-o luggage1 kingstavern))
              (list '~ (p4::instantiate-consed-literal '(immobile luggage1))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 38))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 38)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'luggage1 *current-problem-space*)
                    (p4::object-name-to-object 'kingstavern *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern))
              (p4::instantiate-consed-literal '(at-loc-o luggage1 kingstavern))
              (list '~ (p4::instantiate-consed-literal '(immobile luggage1))))))
 
(setf (p4::nexus-children (find-node 38))
  (list
    (p4::make-goal-node 
        :name 39 
        :parent (find-node 38) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern)) 
        :introducing-operators (list (find-node 38) )))) 
 
(setf (p4::nexus-children (find-node 39))
  (list
    (p4::make-operator-node 
        :name 40 
        :parent (find-node 39) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 40))
  (list
    (p4::make-binding-node 
        :name 41 
        :parent (find-node 40)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l kingstavern atlanta))
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 41))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 41)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'georgiatech *current-problem-space*)
                    (p4::object-name-to-object 'kingstavern *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l kingstavern atlanta))
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech)))))
 
(setf (p4::nexus-children (find-node 41))
  (list
    (p4::make-applied-op-node 
        :name 42 
        :parent (find-node 41)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 42))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 20)
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

(setf (p4::a-or-b-node-applied (find-node 42))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 42))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech))))))
 
(setf (p4::nexus-children (find-node 42))
  (list
    (p4::make-goal-node 
        :name 43 
        :parent (find-node 42) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech)) 
        :introducing-operators (list (find-node 41) )))) 
 
(setf (p4::nexus-children (find-node 43))
  (list
    (p4::make-operator-node 
        :name 44 
        :parent (find-node 43) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 44))
  (list
    (p4::make-binding-node 
        :name 45 
        :parent (find-node 44)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 45))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 45)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'georgiatech *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))))
 
(setf (p4::nexus-children (find-node 45))
  (list
    (p4::make-applied-op-node 
        :name 46 
        :parent (find-node 45)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 46))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 17)
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

(setf (p4::a-or-b-node-applied (find-node 46))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 46))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(in-city-p researcher washington))
                 (p4::instantiate-consed-literal '(at-loc-p researcher dulles)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))))))
 
(setf (p4::nexus-children (find-node 46))
  (list
    (p4::make-goal-node 
        :name 47 
        :parent (find-node 46) 
        :goal 
            (p4::instantiate-consed-literal '(in-city-p researcher atlanta)) 
        :introducing-operators (list (find-node 45) (find-node 41) (find-node 35) (find-node 32) (find-node 23) (find-node 8) )))) 
 
(setf (p4::nexus-children (find-node 47))
  (list
    (p4::make-operator-node 
        :name 48 
        :parent (find-node 47) 
        :operator (p4::get-operator fly-domestic))))
 
(setf (p4::nexus-children (find-node 48))
  (list
    (p4::make-binding-node 
        :name 49 
        :parent (find-node 48)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(in-country washington usa))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 49))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 49)
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
              (p4::instantiate-consed-literal '(in-country atlanta usa)))))
 
(setf (p4::nexus-children (find-node 49))
  (list
    (p4::make-goal-node 
        :name 50 
        :parent (find-node 49) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)) 
        :introducing-operators (list (find-node 45) (find-node 35) (find-node 32) (find-node 23) (find-node 8) )))) 
 
(setf (p4::nexus-children (find-node 50))
  (list
    (p4::make-operator-node 
        :name 51 
        :parent (find-node 50) 
        :operator (p4::get-operator fly-domestic))))
 
(setf (p4::nexus-children (find-node 51))
  (list
    (p4::make-binding-node 
        :name 52 
        :parent (find-node 51)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(in-country washington usa))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 52))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 52)
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
              (p4::instantiate-consed-literal '(in-country atlanta usa)))))
 
(setf (p4::nexus-children (find-node 52))
  (list
    (p4::make-applied-op-node 
        :name 53 
        :parent (find-node 52)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 53))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 14)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'postoffice *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l postoffice washington))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles)))))

(setf (p4::a-or-b-node-applied (find-node 53))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 53))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher postoffice)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher dulles))))))
 
(setf (p4::nexus-children (find-node 53))
  (list
    (p4::make-goal-node 
        :name 54 
        :parent (find-node 53) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher dulles)) 
        :introducing-operators (list (find-node 52) (find-node 49) )))) 
 
(setf (p4::nexus-children (find-node 54))
  (list
    (p4::make-operator-node 
        :name 55 
        :parent (find-node 54) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 55))
  (list
    (p4::make-binding-node 
        :name 56 
        :parent (find-node 55)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-l postoffice washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher postoffice)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 56))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 56)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'postoffice *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-l postoffice washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher postoffice)))))
 
(setf (p4::nexus-children (find-node 56))
  (list
    (p4::make-applied-op-node 
        :name 57 
        :parent (find-node 56)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 57))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 11)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'passport1 *current-problem-space*)
                    (p4::object-name-to-object 'postoffice *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher postoffice))
              (p4::instantiate-consed-literal '(at-loc-o passport1 postoffice))
              (list '~ (p4::instantiate-consed-literal '(immobile passport1))))))

(setf (p4::a-or-b-node-applied (find-node 57))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 57))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding researcher passport1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-o passport1 postoffice))))))
 
(setf (p4::nexus-children (find-node 57))
  (list
    (p4::make-applied-op-node 
        :name 58 
        :parent (find-node 57)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 58))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 56)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'postoffice *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-l postoffice washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(at-loc-p researcher postoffice)))))

(setf (p4::a-or-b-node-applied (find-node 58))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 58))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher dulles)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher postoffice))))))
 
(setf (p4::nexus-children (find-node 58))
  (list
    (p4::make-applied-op-node 
        :name 59 
        :parent (find-node 58)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 59))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 49)
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
              (p4::instantiate-consed-literal '(in-country atlanta usa)))))

(setf (p4::a-or-b-node-applied (find-node 59))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 59))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(in-city-p researcher washington))
                 (p4::instantiate-consed-literal '(at-loc-p researcher dulles))))))
 
(setf (p4::nexus-children (find-node 59))
  (list
    (p4::make-applied-op-node 
        :name 83 
        :parent (find-node 59)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 83))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 32)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*)
                    (p4::object-name-to-object 'bostonport *current-problem-space*)
                    (p4::object-name-to-object 'boston *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-country boston usa)))))

(setf (p4::a-or-b-node-applied (find-node 83))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 83))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(in-city-p researcher boston))
                 (p4::instantiate-consed-literal '(at-loc-p researcher bostonport)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))))))
 
(setf (p4::nexus-children (find-node 83))
  (list
    (p4::make-goal-node 
        :name 84 
        :parent (find-node 83) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher dulles)) 
        :introducing-operators (list (find-node 52) )))) 
 
(setf (p4::nexus-children (find-node 84))
  (list
    (p4::make-operator-node 
        :name 85 
        :parent (find-node 84) 
        :operator (p4::get-operator fly-domestic))))
 
(setf (p4::nexus-children (find-node 85))
  (list
    (p4::make-binding-node 
        :name 86 
        :parent (find-node 85)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher bostonport))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-city-p researcher boston))
              (p4::instantiate-consed-literal '(in-country boston usa))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-country washington usa)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 86))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 86)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'bostonport *current-problem-space*)
                    (p4::object-name-to-object 'boston *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher bostonport))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-city-p researcher boston))
              (p4::instantiate-consed-literal '(in-country boston usa))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-country washington usa)))))
 
(setf (p4::nexus-children (find-node 86))
  (list
    (p4::make-goal-node 
        :name 87 
        :parent (find-node 86) 
        :goal 
            (p4::instantiate-consed-literal '(in-city-p researcher washington)) 
        :introducing-operators (list (find-node 52) )))) 
 
(setf (p4::nexus-children (find-node 87))
  (list
    (p4::make-operator-node 
        :name 88 
        :parent (find-node 87) 
        :operator (p4::get-operator fly-domestic))))
 
(setf (p4::nexus-children (find-node 88))
  (list
    (p4::make-binding-node 
        :name 89 
        :parent (find-node 88)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher bostonport))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-city-p researcher boston))
              (p4::instantiate-consed-literal '(in-country boston usa))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-country washington usa)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 89))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 89)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'bostonport *current-problem-space*)
                    (p4::object-name-to-object 'boston *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher bostonport))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-city-p researcher boston))
              (p4::instantiate-consed-literal '(in-country boston usa))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-country washington usa)))))
 
(setf (p4::nexus-children (find-node 89))
  (list
    (p4::make-goal-node 
        :name 90 
        :parent (find-node 89) 
        :goal 
            (p4::instantiate-consed-literal '(in-city-p researcher atlanta)) 
        :introducing-operators (list (find-node 8) (find-node 45) (find-node 41) (find-node 35) (find-node 23) )))) 
 
(setf (p4::nexus-children (find-node 90))
  (list
    (p4::make-operator-node 
        :name 91 
        :parent (find-node 90) 
        :operator (p4::get-operator fly-domestic))))
 
(setf (p4::nexus-children (find-node 91))
  (list
    (p4::make-binding-node 
        :name 92 
        :parent (find-node 91)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher bostonport))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-city-p researcher boston))
              (p4::instantiate-consed-literal '(in-country boston usa))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 92))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 92)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'bostonport *current-problem-space*)
                    (p4::object-name-to-object 'boston *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher bostonport))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-city-p researcher boston))
              (p4::instantiate-consed-literal '(in-country boston usa))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa)))))
 
(setf (p4::nexus-children (find-node 92))
  (list
    (p4::make-goal-node 
        :name 93 
        :parent (find-node 92) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)) 
        :introducing-operators (list (find-node 8) (find-node 45) (find-node 35) (find-node 23) )))) 
 
(setf (p4::nexus-children (find-node 93))
  (list
    (p4::make-operator-node 
        :name 94 
        :parent (find-node 93) 
        :operator (p4::get-operator fly-domestic))))
 
(setf (p4::nexus-children (find-node 94))
  (list
    (p4::make-binding-node 
        :name 95 
        :parent (find-node 94)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher bostonport))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-city-p researcher boston))
              (p4::instantiate-consed-literal '(in-country boston usa))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 95))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 95)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'bostonport *current-problem-space*)
                    (p4::object-name-to-object 'boston *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher bostonport))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-city-p researcher boston))
              (p4::instantiate-consed-literal '(in-country boston usa))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa)))))
 
(setf (p4::nexus-children (find-node 95))
  (list
    (p4::make-applied-op-node 
        :name 96 
        :parent (find-node 95)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 96))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 29)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'bostonport *current-problem-space*)
                    (p4::object-name-to-object 'kinkos *current-problem-space*)
                    (p4::object-name-to-object 'boston *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l kinkos boston))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-city-p researcher boston))
              (p4::instantiate-consed-literal '(at-loc-p researcher bostonport)))))

(setf (p4::a-or-b-node-applied (find-node 96))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 96))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher kinkos)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher bostonport))))))
 
(setf (p4::nexus-children (find-node 96))
  (list
    (p4::make-goal-node 
        :name 97 
        :parent (find-node 96) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher bostonport)) 
        :introducing-operators (list (find-node 95) (find-node 92) (find-node 89) (find-node 86) )))) 
 
(setf (p4::nexus-children (find-node 97))
  (list
    (p4::make-operator-node 
        :name 98 
        :parent (find-node 97) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 98))
  (list
    (p4::make-binding-node 
        :name 99 
        :parent (find-node 98)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-city-l kinkos boston))
              (p4::instantiate-consed-literal '(in-city-p researcher boston))
              (p4::instantiate-consed-literal '(at-loc-p researcher kinkos)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 99))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 99)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'kinkos *current-problem-space*)
                    (p4::object-name-to-object 'bostonport *current-problem-space*)
                    (p4::object-name-to-object 'boston *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-city-l kinkos boston))
              (p4::instantiate-consed-literal '(in-city-p researcher boston))
              (p4::instantiate-consed-literal '(at-loc-p researcher kinkos)))))
 
(setf (p4::nexus-children (find-node 99))
  (list
    (p4::make-applied-op-node 
        :name 100 
        :parent (find-node 99)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 100))
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

(setf (p4::a-or-b-node-applied (find-node 100))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 100))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding researcher akr)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-o akr kinkos))))))
 
(setf (p4::nexus-children (find-node 100))
  (list
    (p4::make-applied-op-node 
        :name 101 
        :parent (find-node 100)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 101))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 99)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'kinkos *current-problem-space*)
                    (p4::object-name-to-object 'bostonport *current-problem-space*)
                    (p4::object-name-to-object 'boston *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-city-l kinkos boston))
              (p4::instantiate-consed-literal '(in-city-p researcher boston))
              (p4::instantiate-consed-literal '(at-loc-p researcher kinkos)))))

(setf (p4::a-or-b-node-applied (find-node 101))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 101))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher bostonport)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher kinkos))))))
 
(setf (p4::nexus-children (find-node 101))
  (list
    (p4::make-applied-op-node 
        :name 148 
        :parent (find-node 101)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 148))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 92)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'bostonport *current-problem-space*)
                    (p4::object-name-to-object 'boston *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher bostonport))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-city-p researcher boston))
              (p4::instantiate-consed-literal '(in-country boston usa))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa)))))

(setf (p4::a-or-b-node-applied (find-node 148))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 148))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(in-city-p researcher boston))
                 (p4::instantiate-consed-literal '(at-loc-p researcher bostonport))))))
 
(setf (p4::nexus-children (find-node 148))
  (list
    (p4::make-applied-op-node 
        :name 172 
        :parent (find-node 148)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 172))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 45)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'georgiatech *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))))

(setf (p4::a-or-b-node-applied (find-node 172))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 172))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))))))
 
(setf (p4::nexus-children (find-node 172))
  (list
    (p4::make-goal-node 
        :name 173 
        :parent (find-node 172) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher bostonport)) 
        :introducing-operators (list (find-node 89) (find-node 86) (find-node 95) )))) 
 
(setf (p4::nexus-children (find-node 173))
  (list
    (p4::make-operator-node 
        :name 174 
        :parent (find-node 173) 
        :operator (p4::get-operator fly-domestic))))
 
(setf (p4::nexus-children (find-node 174))
  (list
    (p4::make-binding-node 
        :name 176 
        :parent (find-node 174)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(in-country washington usa))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-country boston usa)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 176))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 176)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*)
                    (p4::object-name-to-object 'bostonport *current-problem-space*)
                    (p4::object-name-to-object 'boston *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(in-country washington usa))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-country boston usa)))))
 
(setf (p4::nexus-children (find-node 176))
  (list
    (p4::make-goal-node 
        :name 177 
        :parent (find-node 176) 
        :goal 
            (p4::instantiate-consed-literal '(in-city-p researcher boston)) 
        :introducing-operators (list (find-node 89) (find-node 86) (find-node 95) )))) 
 
(setf (p4::nexus-children (find-node 177))
  (list
    (p4::make-operator-node 
        :name 178 
        :parent (find-node 177) 
        :operator (p4::get-operator fly-domestic))))
 
(setf (p4::nexus-children (find-node 178))
  (list
    (p4::make-binding-node 
        :name 180 
        :parent (find-node 178)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(in-country washington usa))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-country boston usa)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 180))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-domestic)
          :binding-node-back-pointer (find-node 180)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'dulles *current-problem-space*)
                    (p4::object-name-to-object 'washington *current-problem-space*)
                    (p4::object-name-to-object 'bostonport *current-problem-space*)
                    (p4::object-name-to-object 'boston *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher dulles))
              (p4::instantiate-consed-literal '(in-city-l dulles washington))
              (p4::instantiate-consed-literal '(in-city-p researcher washington))
              (p4::instantiate-consed-literal '(in-country washington usa))
              (p4::instantiate-consed-literal '(in-city-l bostonport boston))
              (p4::instantiate-consed-literal '(in-country boston usa)))))
 
(setf (p4::nexus-children (find-node 180))
  (list
    (p4::make-goal-node 
        :name 181 
        :parent (find-node 180) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)) 
        :introducing-operators (list (find-node 8) (find-node 35) (find-node 23) )))) 
 
(setf (p4::nexus-children (find-node 181))
  (list
    (p4::make-operator-node 
        :name 182 
        :parent (find-node 181) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 182))
  (list
    (p4::make-binding-node 
        :name 183 
        :parent (find-node 182)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 183))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 183)
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
 
(setf (p4::nexus-children (find-node 183))
  (list
    (p4::make-applied-op-node 
        :name 184 
        :parent (find-node 183)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 184))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 41)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'georgiatech *current-problem-space*)
                    (p4::object-name-to-object 'kingstavern *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l kingstavern atlanta))
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech)))))

(setf (p4::a-or-b-node-applied (find-node 184))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 184))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech))))))
 
(setf (p4::nexus-children (find-node 184))
  (list
    (p4::make-goal-node 
        :name 185 
        :parent (find-node 184) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech)) 
        :introducing-operators (list (find-node 183) )))) 
 
(setf (p4::nexus-children (find-node 185))
  (list
    (p4::make-operator-node 
        :name 186 
        :parent (find-node 185) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 186))
  (list
    (p4::make-binding-node 
        :name 187 
        :parent (find-node 186)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-l kingstavern atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 187))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 187)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'kingstavern *current-problem-space*)
                    (p4::object-name-to-object 'georgiatech *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-l kingstavern atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern)))))
 
(setf (p4::nexus-children (find-node 187))
  (list
    (p4::make-applied-op-node 
        :name 188 
        :parent (find-node 187)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 188))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 38)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'luggage1 *current-problem-space*)
                    (p4::object-name-to-object 'kingstavern *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern))
              (p4::instantiate-consed-literal '(at-loc-o luggage1 kingstavern))
              (list '~ (p4::instantiate-consed-literal '(immobile luggage1))))))

(setf (p4::a-or-b-node-applied (find-node 188))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 188))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding researcher luggage1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-o luggage1 kingstavern))))))
 
(setf (p4::nexus-children (find-node 188))
  (list
    (p4::make-applied-op-node 
        :name 189 
        :parent (find-node 188)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 189))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 187)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'kingstavern *current-problem-space*)
                    (p4::object-name-to-object 'georgiatech *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-l kingstavern atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern)))))

(setf (p4::a-or-b-node-applied (find-node 189))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 189))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher kingstavern))))))
 
(setf (p4::nexus-children (find-node 189))
  (list
    (p4::make-applied-op-node 
        :name 190 
        :parent (find-node 189)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 190))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 183)
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

(setf (p4::a-or-b-node-applied (find-node 190))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 190))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech))))))
 
(setf (p4::nexus-children (find-node 190))
  (list
    (p4::make-applied-op-node 
        :name 191 
        :parent (find-node 190)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 191))
      (p4::make-instantiated-op
          :op (p4::get-operator fly-international)
          :binding-node-back-pointer (find-node 8)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'passport1 *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*)
                    (p4::object-name-to-object 'usa *current-problem-space*)
                    (p4::object-name-to-object 'athensport *current-problem-space*)
                    (p4::object-name-to-object 'iraklion *current-problem-space*)
                    (p4::object-name-to-object 'greece *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(holding researcher passport1))
              (p4::instantiate-consed-literal '(nationality researcher usa))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(in-country atlanta usa))
              (p4::instantiate-consed-literal '(in-city-l athensport iraklion))
              (p4::instantiate-consed-literal '(in-country iraklion greece)))))

(setf (p4::a-or-b-node-applied (find-node 191))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 191))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(in-city-p researcher iraklion))
                 (p4::instantiate-consed-literal '(at-loc-p researcher athensport)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))))))
