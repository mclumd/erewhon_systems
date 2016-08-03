 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g11))
              (p4::instantiate-consed-literal '(g13))
              (p4::instantiate-consed-literal '(g2))
              (p4::instantiate-consed-literal '(g10)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g11))
              (p4::instantiate-consed-literal '(g13))
              (p4::instantiate-consed-literal '(g2))
              (p4::instantiate-consed-literal '(g10)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 21703 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(g13)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 21703))
  (list
    (p4::make-operator-node 
        :name 21704 
        :parent (find-node 21703) 
        :operator (p4::get-operator a2-13))))
 
(setf (p4::nexus-children (find-node 21704))
  (list
    (p4::make-binding-node 
        :name 21705 
        :parent (find-node 21704)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p13))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 21705))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-13)
          :binding-node-back-pointer (find-node 21705)
          :precond 
            (p4::instantiate-consed-literal '(p13))))
 
(setf (p4::nexus-children (find-node 21705))
  (list
    (p4::make-goal-node 
        :name 24541 
        :parent (find-node 21705) 
        :goal 
            (p4::instantiate-consed-literal '(g11)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 24541))
  (list
    (p4::make-operator-node 
        :name 24542 
        :parent (find-node 24541) 
        :operator (p4::get-operator a2-11))))
 
(setf (p4::nexus-children (find-node 24542))
  (list
    (p4::make-binding-node 
        :name 24543 
        :parent (find-node 24542)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p11))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 24543))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-11)
          :binding-node-back-pointer (find-node 24543)
          :precond 
            (p4::instantiate-consed-literal '(p11))))
 
(setf (p4::nexus-children (find-node 24543))
  (list
    (p4::make-goal-node 
        :name 28412 
        :parent (find-node 24543) 
        :goal 
            (p4::instantiate-consed-literal '(g10)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 28412))
  (list
    (p4::make-operator-node 
        :name 28413 
        :parent (find-node 28412) 
        :operator (p4::get-operator a2-10))))
 
(setf (p4::nexus-children (find-node 28413))
  (list
    (p4::make-binding-node 
        :name 28414 
        :parent (find-node 28413)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p10))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 28414))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-10)
          :binding-node-back-pointer (find-node 28414)
          :precond 
            (p4::instantiate-consed-literal '(p10))))
 
(setf (p4::nexus-children (find-node 28414))
  (list
    (p4::make-goal-node 
        :name 29507 
        :parent (find-node 28414) 
        :goal 
            (p4::instantiate-consed-literal '(g2)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 29507))
  (list
    (p4::make-operator-node 
        :name 29508 
        :parent (find-node 29507) 
        :operator (p4::get-operator a2-2))))
 
(setf (p4::nexus-children (find-node 29508))
  (list
    (p4::make-binding-node 
        :name 29509 
        :parent (find-node 29508)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29509))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 29509)
          :precond 
            (p4::instantiate-consed-literal '(p2))))
 
(setf (p4::nexus-children (find-node 29509))
  (list
    (p4::make-goal-node 
        :name 29510 
        :parent (find-node 29509) 
        :goal 
            (p4::instantiate-consed-literal '(p2)) 
        :introducing-operators (list (find-node 29509) )))) 
 
(setf (p4::nexus-children (find-node 29510))
  (list
    (p4::make-operator-node 
        :name 29511 
        :parent (find-node 29510) 
        :operator (p4::get-operator a1-2))))
 
(setf (p4::nexus-children (find-node 29511))
  (list
    (p4::make-binding-node 
        :name 29512 
        :parent (find-node 29511)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i2))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29512))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 29512)
          :precond 
            (p4::instantiate-consed-literal '(i2))))
 
(setf (p4::nexus-children (find-node 29512))
  (list
    (p4::make-applied-op-node 
        :name 29513 
        :parent (find-node 29512)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29513))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-2)
          :binding-node-back-pointer (find-node 29512)
          :precond 
            (p4::instantiate-consed-literal '(i2))))

(setf (p4::a-or-b-node-applied (find-node 29513))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 29513))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))))))
 
(setf (p4::nexus-children (find-node 29513))
  (list
    (p4::make-goal-node 
        :name 29518 
        :parent (find-node 29513) 
        :goal 
            (p4::instantiate-consed-literal '(p10)) 
        :introducing-operators (list (find-node 28414) )))) 
 
(setf (p4::nexus-children (find-node 29518))
  (list
    (p4::make-operator-node 
        :name 29519 
        :parent (find-node 29518) 
        :operator (p4::get-operator a1-10))))
 
(setf (p4::nexus-children (find-node 29519))
  (list
    (p4::make-binding-node 
        :name 29520 
        :parent (find-node 29519)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i10))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29520))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-10)
          :binding-node-back-pointer (find-node 29520)
          :precond 
            (p4::instantiate-consed-literal '(i10))))
 
(setf (p4::nexus-children (find-node 29520))
  (list
    (p4::make-applied-op-node 
        :name 29521 
        :parent (find-node 29520)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29521))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-10)
          :binding-node-back-pointer (find-node 29520)
          :precond 
            (p4::instantiate-consed-literal '(i10))))

(setf (p4::a-or-b-node-applied (find-node 29521))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 29521))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p10)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i2))
                 (p4::instantiate-consed-literal '(i3))
                 (p4::instantiate-consed-literal '(i4))
                 (p4::instantiate-consed-literal '(i5))
                 (p4::instantiate-consed-literal '(i6))
                 (p4::instantiate-consed-literal '(i7))
                 (p4::instantiate-consed-literal '(i8))
                 (p4::instantiate-consed-literal '(i9))))))
 
(setf (p4::nexus-children (find-node 29521))
  (list
    (p4::make-goal-node 
        :name 29530 
        :parent (find-node 29521) 
        :goal 
            (p4::instantiate-consed-literal '(p11)) 
        :introducing-operators (list (find-node 24543) )))) 
 
(setf (p4::nexus-children (find-node 29530))
  (list
    (p4::make-operator-node 
        :name 29531 
        :parent (find-node 29530) 
        :operator (p4::get-operator a1-11))))
 
(setf (p4::nexus-children (find-node 29531))
  (list
    (p4::make-binding-node 
        :name 29532 
        :parent (find-node 29531)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i11))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29532))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-11)
          :binding-node-back-pointer (find-node 29532)
          :precond 
            (p4::instantiate-consed-literal '(i11))))
 
(setf (p4::nexus-children (find-node 29532))
  (list
    (p4::make-applied-op-node 
        :name 29533 
        :parent (find-node 29532)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29533))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-11)
          :binding-node-back-pointer (find-node 29532)
          :precond 
            (p4::instantiate-consed-literal '(i11))))

(setf (p4::a-or-b-node-applied (find-node 29533))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 29533))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p11)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i10))))))
 
(setf (p4::nexus-children (find-node 29533))
  (list
    (p4::make-goal-node 
        :name 29546 
        :parent (find-node 29533) 
        :goal 
            (p4::instantiate-consed-literal '(p13)) 
        :introducing-operators (list (find-node 21705) )))) 
 
(setf (p4::nexus-children (find-node 29546))
  (list
    (p4::make-operator-node 
        :name 29547 
        :parent (find-node 29546) 
        :operator (p4::get-operator a1-13))))
 
(setf (p4::nexus-children (find-node 29547))
  (list
    (p4::make-binding-node 
        :name 29548 
        :parent (find-node 29547)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i13))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29548))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-13)
          :binding-node-back-pointer (find-node 29548)
          :precond 
            (p4::instantiate-consed-literal '(i13))))
 
(setf (p4::nexus-children (find-node 29548))
  (list
    (p4::make-applied-op-node 
        :name 29549 
        :parent (find-node 29548)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29549))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-13)
          :binding-node-back-pointer (find-node 29548)
          :precond 
            (p4::instantiate-consed-literal '(i13))))

(setf (p4::a-or-b-node-applied (find-node 29549))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 29549))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p13)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i11))
                 (p4::instantiate-consed-literal '(i12))))))
 
(setf (p4::nexus-children (find-node 29549))
  (list
    (p4::make-applied-op-node 
        :name 29550 
        :parent (find-node 29549)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29550))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-2)
          :binding-node-back-pointer (find-node 29509)
          :precond 
            (p4::instantiate-consed-literal '(p2))))

(setf (p4::a-or-b-node-applied (find-node 29550))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 29550))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i13))
                 (p4::instantiate-consed-literal '(i14))
                 (p4::instantiate-consed-literal '(i15))))))
 
(setf (p4::nexus-children (find-node 29550))
  (list
    (p4::make-applied-op-node 
        :name 29551 
        :parent (find-node 29550)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29551))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-10)
          :binding-node-back-pointer (find-node 28414)
          :precond 
            (p4::instantiate-consed-literal '(p10))))

(setf (p4::a-or-b-node-applied (find-node 29551))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 29551))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g10)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p2))))))
 
(setf (p4::nexus-children (find-node 29551))
  (list
    (p4::make-applied-op-node 
        :name 29552 
        :parent (find-node 29551)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29552))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-11)
          :binding-node-back-pointer (find-node 24543)
          :precond 
            (p4::instantiate-consed-literal '(p11))))

(setf (p4::a-or-b-node-applied (find-node 29552))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 29552))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g11)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p10))))))
 
(setf (p4::nexus-children (find-node 29552))
  (list
    (p4::make-applied-op-node 
        :name 29553 
        :parent (find-node 29552)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29553))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-13)
          :binding-node-back-pointer (find-node 21705)
          :precond 
            (p4::instantiate-consed-literal '(p13))))

(setf (p4::a-or-b-node-applied (find-node 29553))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 29553))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g13)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p11))))))
