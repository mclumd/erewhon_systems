(create-problem-space 'tm :current t)

(ptype-of Path :Top-Type)

(infinite-type Number #'numberp)

(OPERATOR
 MAP-AND2-NOT1NAND2
 (params <p1> <p2> <p3>)
 (preconds
  ((<p1> Path)
   (<p2> Path)
   (<p3> Path)
   (<new> Path))
  (and (and2 <p1> <p2> <p3>)
       (free-path <new>)))
 (effects
  ((<n> (and Number (gen-from-pred (tr-num <n>))))
   (<nn> (and Number (inc-tr-num <n> 6 <nn>)))
   )
  ((del (and2 <p1> <p2> <p3>))
   (del (free-path <new>))
   (del (tr-num <n>))
   (add (g-inv1  <new> <p3>))
   (add (g-nand2 <p1> <p2> <new>))
   (add (tr-num <nn>)))))

(OPERATOR
 MAP-OR2-NOT1NOR2
 (params <p1> <p2> <p3>)
 (preconds
  ((<p1> Path)
   (<p2> Path)
   (<p3> Path)
   (<new> Path))
  (and (or2 <p1> <p2> <p3>)
       (free-path <new>)))
 (effects
  ((<n> (and Number (gen-from-pred (tr-num <n>))))
   (<nn> (and Number (inc-tr-num <n> 6 <nn>))))
 ((del (or2 <p1> <p2> <p3>))
  (del (free-path <new>))
  (del (tr-num <n>))
  (add (g-inv1  <new> <p3>))
  (add (g-nor2 <p1> <p2> <new>))
  (add (tr-num <nn>)))))

(OPERATOR
 MAP-OR2-NAND2NOT1NOT1
 (params <p1> <p2> <p3>)
 (preconds
  ((<p1> Path)
   (<p2> Path)
   (<p3> Path)
   (<new1> Path)
   (<new2> Path))
  (and (or2 <p1> <p2> <p3>)
       (free-path <new1>)
       (free-path <new2>)))
 (effects
  ((<n> (and Number (gen-from-pred (tr-num <n>))))
   (<nn> (and Number (inc-tr-num <n> 8 <nn>))))
  ((del (or2 <p1> <p2> <p3>))
   (del (free-path <new1>))
   (del (free-path <new2>))
   (del (tr-num <n>))
   (add (g-nand2 <new1> <new2> <p3>))
   (add (g-inv1  <p1> <new1>))
   (add (g-inv1  <p2> <new2>))
   (add (tr-num <nn>)))))

(OPERATOR
 MAP-NOT1-INV1
 (params <p1> <p2>)
 (preconds
  ((<p1> Path)
   (<p2> Path))
  (not1 <p1> <p2>))
 (effects
  ((<n> (and Number (gen-from-pred (tr-num <n>))))
   (<nn> (and Number (inc-tr-num <n> 2 <nn>))))
  ((del (not1 <p1> <p2>))
   (del (tr-num <n>))
   (add (g-inv1 <p1> <p2>))
   (add (tr-num <nn>)))))

(OPERATOR
 OPT-INV1INV1-BUF1
 (params <p1> <p2> <p3>)
 (preconds
  ((<p1> Path)
   (<p2> Path)
   (<p3> Path)
   (<nn> Number)
   (<n> (and Number (dec-tr-num <n> 4 <nn>))))
  (and (g-inv1 <p1> <p2>)
       (g-inv1 <p2> <p3>)
       (tr-num <n>)))
 (effects
  ()
;  ((<n> (and Number (gen-from-pred (tr-num <n>))))
;   (<nn> (and Number (dec-tr-num <n> 4 <nn>))))
  ((del (g-inv1 <p1> <p2>))
   (del (g-inv1 <p2> <p3>))
   (del (tr-num <n>))
   (add (g-buf1 <p1> <p3>))
   (add (tr-num <nn>)))))

(Inference-Rule
 INFER-MAPPED-AND
 (mode lazy)
 (params)
 (preconds
  ()
;  ((<a> path)
;   (<b> path)
;   (<c> path))
  (forall ((<a> Path) (<b> Path) (<c> Path))
          (~ (and2 <a> <b> <c>)))
;  (~ (exists ((<a> Path) (<b> Path) (<c> Path))
;           (and2 <a> <b> <c>)))
  )
 (effects
  ()
  ((add (mapped-and)))))
	  
(Inference-Rule
 INFER-MAPPED-OR
 (mode lazy)
 (params)
 (preconds
  ()
  (forall ((<a> Path) (<b> Path) (<c> Path))
          (~ (or2 <a> <b> <c>)))
; (~ (exists ((<a> Path) (<b> Path) (<c> Path))
;           (or2 <a> <b> <c>)))
  )
 (effects
  ()
  ((add (mapped-or)))))
	  
(Inference-Rule
 INFER-MAPPED-NOT
 (mode lazy)
 (params)
 (preconds
  ()
  (forall ((<a> Path) (<b> Path))
          (~ (not1 <a> <b>)))
;  (~ (exists ((<a> Path) (<b> Path))
;             (not1 <a> <b>)))
  )
 (effects
  ()
  ((add (mapped-not)))))
	  
(Inference-Rule
 INFER-MAPPED
 (mode lazy)
 (params)
 (preconds
  ()
  (and (mapped-and)
       (mapped-or)
       (mapped-not)))
 (effects
  ()
  ((add (mapped)))))

#|
(Control-Rule Select-Op-For-Dec-Tr-Num
    (IF (and (current-goal (tr-num <n>))
	     (true-in-state (tr-num <nn>))
	     (< <n> <nn>)))
    (THEN select operator opt-inv1inv1-buf1))


(Control-Rule Select-Binding-For-Goal-Dec-Tr-Num
    (IF (and (current-goal (tr-num <n>))
	     (current-ops (OPT-INV1INV1-BUF1))
	     (true-in-state (tr-num <nn>))
	     (< <n> <nn>)
	     (true-in-state (g-inv1 <x> <y>))
	     (true-in-state (g-inv1 <y> <z>))))
    (THEN select bindings ((<p1> . <x>) (<p2> . <y>) (<p3> . <z>))))
	     
(Control-Rule working-on-mapped-1
    (IF (and (candidate-goal (mapped-or))
	     (candidate-goal (tr-num <n>))))
    (THEN prefer goal (mapped-or)))

(Control-Rule working-on-mapped-2
    (IF (and (candidate-goal (mapped-and))
	     (candidate-goal (tr-num <n>))))
    (THEN prefer goal (mapped-and)))

(Control-Rule working-on-mapped-3
    (IF (and (candidate-goal (mapped-not))
	     (candidate-goal (tr-num <n>))))
    (THEN prefer goal (mapped-not)))

(Control-Rule working-on-mapped-3
    (IF (and (candidate-goal (mapped))
	     (candidate-goal (tr-num <n>))))
    (THEN prefer  goal (mapped)))

|#
