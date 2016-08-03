 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-p researcher iraklion))
              (p4::instantiate-consed-literal '(holding researcher akr)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-p researcher iraklion))
              (p4::instantiate-consed-literal '(holding researcher akr)))))
 
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
              (p4::instantiate-consed-literal '(in-city-l postoffice atlanta))
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 14))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 14)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'georgiatech *current-problem-space*)
                    (p4::object-name-to-object 'postoffice *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l postoffice atlanta))
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech)))))
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-applied-op-node 
        :name 15 
        :parent (find-node 14)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 15))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 14)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'georgiatech *current-problem-space*)
                    (p4::object-name-to-object 'postoffice *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l postoffice atlanta))
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech)))))

(setf (p4::a-or-b-node-applied (find-node 15))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 15))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher postoffice)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech))))))
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-applied-op-node 
        :name 16 
        :parent (find-node 15)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 16))
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

(setf (p4::a-or-b-node-applied (find-node 16))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 16))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding researcher passport1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-o passport1 postoffice))))))
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-goal-node 
        :name 17 
        :parent (find-node 16) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)) 
        :introducing-operators (list (find-node 8) )))) 
 
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
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-l postoffice atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher postoffice)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 19))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 19)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'postoffice *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-l postoffice atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher postoffice)))))
 
(setf (p4::nexus-children (find-node 19))
  (list
    (p4::make-applied-op-node 
        :name 20 
        :parent (find-node 19)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 20))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 19)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'postoffice *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-l postoffice atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher postoffice)))))

(setf (p4::a-or-b-node-applied (find-node 20))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 20))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher postoffice))))))
 
(setf (p4::nexus-children (find-node 20))
  (list
    (p4::make-goal-node 
        :name 307 
        :parent (find-node 20) 
        :goal 
            (p4::instantiate-consed-literal '(holding researcher akr)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 307))
  (list
    (p4::make-operator-node 
        :name 308 
        :parent (find-node 307) 
        :operator (p4::get-operator pick-up))))
 
(setf (p4::nexus-children (find-node 308))
  (list
    (p4::make-binding-node 
        :name 309 
        :parent (find-node 308)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher kinkos))
              (p4::instantiate-consed-literal '(at-loc-o akr kinkos))
              (list '~ (p4::instantiate-consed-literal '(immobile akr))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 309))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 309)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'akr *current-problem-space*)
                    (p4::object-name-to-object 'kinkos *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher kinkos))
              (p4::instantiate-consed-literal '(at-loc-o akr kinkos))
              (list '~ (p4::instantiate-consed-literal '(immobile akr))))))
 
(setf (p4::nexus-children (find-node 309))
  (list
    (p4::make-goal-node 
        :name 310 
        :parent (find-node 309) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher kinkos)) 
        :introducing-operators (list (find-node 309) )))) 
 
(setf (p4::nexus-children (find-node 310))
  (list
    (p4::make-operator-node 
        :name 311 
        :parent (find-node 310) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 311))
  (list
    (p4::make-binding-node 
        :name 312 
        :parent (find-node 311)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l kinkos atlanta))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 312))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 312)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'kinkos *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l kinkos atlanta))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))))
 
(setf (p4::nexus-children (find-node 312))
  (list
    (p4::make-applied-op-node 
        :name 313 
        :parent (find-node 312)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 313))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 312)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'hartsfield *current-problem-space*)
                    (p4::object-name-to-object 'kinkos *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l kinkos atlanta))
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))))

(setf (p4::a-or-b-node-applied (find-node 313))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 313))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher kinkos)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))))))
 
(setf (p4::nexus-children (find-node 313))
  (list
    (p4::make-applied-op-node 
        :name 314 
        :parent (find-node 313)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 314))
      (p4::make-instantiated-op
          :op (p4::get-operator pick-up)
          :binding-node-back-pointer (find-node 309)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'akr *current-problem-space*)
                    (p4::object-name-to-object 'kinkos *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher kinkos))
              (p4::instantiate-consed-literal '(at-loc-o akr kinkos))
              (list '~ (p4::instantiate-consed-literal '(immobile akr))))))

(setf (p4::a-or-b-node-applied (find-node 314))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 314))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding researcher akr)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-o akr kinkos))))))
 
(setf (p4::nexus-children (find-node 314))
  (list
    (p4::make-goal-node 
        :name 315 
        :parent (find-node 314) 
        :goal 
            (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)) 
        :introducing-operators (list (find-node 8) )))) 
 
(setf (p4::nexus-children (find-node 315))
  (list
    (p4::make-operator-node 
        :name 316 
        :parent (find-node 315) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 316))
  (list
    (p4::make-binding-node 
        :name 317 
        :parent (find-node 316)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(in-city-l hartsfield atlanta))
              (p4::instantiate-consed-literal '(in-city-l kinkos atlanta))
              (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
              (p4::instantiate-consed-literal '(at-loc-p researcher kinkos)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 317))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 317)
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
 
(setf (p4::nexus-children (find-node 317))
  (list
    (p4::make-applied-op-node 
        :name 318 
        :parent (find-node 317)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 318))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 317)
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

(setf (p4::a-or-b-node-applied (find-node 318))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 318))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at-loc-p researcher kinkos))))))
 
(setf (p4::nexus-children (find-node 318))
  (list
    (p4::make-applied-op-node 
        :name 319 
        :parent (find-node 318)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 319))
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

(setf (p4::a-or-b-node-applied (find-node 319))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 319))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(in-city-p researcher iraklion))
                 (p4::instantiate-consed-literal '(at-loc-p researcher athensport)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(in-city-p researcher atlanta))
                 (p4::instantiate-consed-literal '(at-loc-p researcher hartsfield))))))
