 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(g1))
              (p4::instantiate-consed-literal '(g4))
              (p4::instantiate-consed-literal '(g3)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(g1))
              (p4::instantiate-consed-literal '(g4))
              (p4::instantiate-consed-literal '(g3)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 1090 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(g4)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 1090))
  (list
    (p4::make-operator-node 
        :name 1091 
        :parent (find-node 1090) 
        :operator (p4::get-operator a2-4))))
 
(setf (p4::nexus-children (find-node 1091))
  (list
    (p4::make-binding-node 
        :name 1092 
        :parent (find-node 1091)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1092))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 1092)
          :precond 
            (p4::instantiate-consed-literal '(p4))))
 
(setf (p4::nexus-children (find-node 1092))
  (list
    (p4::make-goal-node 
        :name 1632 
        :parent (find-node 1092) 
        :goal 
            (p4::instantiate-consed-literal '(g3)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 1632))
  (list
    (p4::make-operator-node 
        :name 1633 
        :parent (find-node 1632) 
        :operator (p4::get-operator a2-3))))
 
(setf (p4::nexus-children (find-node 1633))
  (list
    (p4::make-binding-node 
        :name 1634 
        :parent (find-node 1633)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1634))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 1634)
          :precond 
            (p4::instantiate-consed-literal '(p3))))
 
(setf (p4::nexus-children (find-node 1634))
  (list
    (p4::make-goal-node 
        :name 1808 
        :parent (find-node 1634) 
        :goal 
            (p4::instantiate-consed-literal '(g1)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 1808))
  (list
    (p4::make-operator-node 
        :name 1809 
        :parent (find-node 1808) 
        :operator (p4::get-operator a2-1))))
 
(setf (p4::nexus-children (find-node 1809))
  (list
    (p4::make-binding-node 
        :name 1810 
        :parent (find-node 1809)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(p1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1810))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 1810)
          :precond 
            (p4::instantiate-consed-literal '(p1))))
 
(setf (p4::nexus-children (find-node 1810))
  (list
    (p4::make-goal-node 
        :name 1811 
        :parent (find-node 1810) 
        :goal 
            (p4::instantiate-consed-literal '(p1)) 
        :introducing-operators (list (find-node 1810) )))) 
 
(setf (p4::nexus-children (find-node 1811))
  (list
    (p4::make-operator-node 
        :name 1812 
        :parent (find-node 1811) 
        :operator (p4::get-operator a1-1))))
 
(setf (p4::nexus-children (find-node 1812))
  (list
    (p4::make-binding-node 
        :name 1813 
        :parent (find-node 1812)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i1))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1813))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 1813)
          :precond 
            (p4::instantiate-consed-literal '(i1))))
 
(setf (p4::nexus-children (find-node 1813))
  (list
    (p4::make-applied-op-node 
        :name 1814 
        :parent (find-node 1813)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1814))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-1)
          :binding-node-back-pointer (find-node 1813)
          :precond 
            (p4::instantiate-consed-literal '(i1))))

(setf (p4::a-or-b-node-applied (find-node 1814))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 1814))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 1814))
  (list
    (p4::make-goal-node 
        :name 1819 
        :parent (find-node 1814) 
        :goal 
            (p4::instantiate-consed-literal '(p3)) 
        :introducing-operators (list (find-node 1634) )))) 
 
(setf (p4::nexus-children (find-node 1819))
  (list
    (p4::make-operator-node 
        :name 1820 
        :parent (find-node 1819) 
        :operator (p4::get-operator a1-3))))
 
(setf (p4::nexus-children (find-node 1820))
  (list
    (p4::make-binding-node 
        :name 1821 
        :parent (find-node 1820)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i3))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1821))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 1821)
          :precond 
            (p4::instantiate-consed-literal '(i3))))
 
(setf (p4::nexus-children (find-node 1821))
  (list
    (p4::make-applied-op-node 
        :name 1822 
        :parent (find-node 1821)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1822))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-3)
          :binding-node-back-pointer (find-node 1821)
          :precond 
            (p4::instantiate-consed-literal '(i3))))

(setf (p4::a-or-b-node-applied (find-node 1822))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 1822))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i1))
                 (p4::instantiate-consed-literal '(i2))))))
 
(setf (p4::nexus-children (find-node 1822))
  (list
    (p4::make-goal-node 
        :name 1831 
        :parent (find-node 1822) 
        :goal 
            (p4::instantiate-consed-literal '(p4)) 
        :introducing-operators (list (find-node 1092) )))) 
 
(setf (p4::nexus-children (find-node 1831))
  (list
    (p4::make-operator-node 
        :name 1832 
        :parent (find-node 1831) 
        :operator (p4::get-operator a1-4))))
 
(setf (p4::nexus-children (find-node 1832))
  (list
    (p4::make-binding-node 
        :name 1833 
        :parent (find-node 1832)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(i4))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1833))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 1833)
          :precond 
            (p4::instantiate-consed-literal '(i4))))
 
(setf (p4::nexus-children (find-node 1833))
  (list
    (p4::make-applied-op-node 
        :name 1834 
        :parent (find-node 1833)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1834))
      (p4::make-instantiated-op
          :op (p4::get-operator a1-4)
          :binding-node-back-pointer (find-node 1833)
          :precond 
            (p4::instantiate-consed-literal '(i4))))

(setf (p4::a-or-b-node-applied (find-node 1834))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 1834))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(p4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i3))))))
 
(setf (p4::nexus-children (find-node 1834))
  (list
    (p4::make-applied-op-node 
        :name 1835 
        :parent (find-node 1834)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1835))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-1)
          :binding-node-back-pointer (find-node 1810)
          :precond 
            (p4::instantiate-consed-literal '(p1))))

(setf (p4::a-or-b-node-applied (find-node 1835))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 1835))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(i4))
                 (p4::instantiate-consed-literal '(i5))
                 (p4::instantiate-consed-literal '(i6))
                 (p4::instantiate-consed-literal '(i7))
                 (p4::instantiate-consed-literal '(i8))
                 (p4::instantiate-consed-literal '(i9))
                 (p4::instantiate-consed-literal '(i10))
                 (p4::instantiate-consed-literal '(i11))
                 (p4::instantiate-consed-literal '(i12))
                 (p4::instantiate-consed-literal '(i13))
                 (p4::instantiate-consed-literal '(i14))
                 (p4::instantiate-consed-literal '(i15))))))
 
(setf (p4::nexus-children (find-node 1835))
  (list
    (p4::make-applied-op-node 
        :name 1836 
        :parent (find-node 1835)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1836))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-3)
          :binding-node-back-pointer (find-node 1634)
          :precond 
            (p4::instantiate-consed-literal '(p3))))

(setf (p4::a-or-b-node-applied (find-node 1836))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 1836))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g3)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p1))))))
 
(setf (p4::nexus-children (find-node 1836))
  (list
    (p4::make-applied-op-node 
        :name 1837 
        :parent (find-node 1836)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 1837))
      (p4::make-instantiated-op
          :op (p4::get-operator a2-4)
          :binding-node-back-pointer (find-node 1092)
          :precond 
            (p4::instantiate-consed-literal '(p4))))

(setf (p4::a-or-b-node-applied (find-node 1837))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 1837))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(g4)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(p3))))))
