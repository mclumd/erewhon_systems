(setf (current-problem)
      (create-problem
       (name p1)
       (objects
	(a b c d e f g
	 p1 p2 p3 ;p4 p5
	 ;p6 p7 p8 p9 p10
	 Path))
       (state
	(and
; (or2 b c a)
	     (and2 d e b)
;	     (and2 f g c)
	     (tr-num 0)
	     (free-path p1)
	     (free-path p2)
;	     (free-path p3)
	     ;(free-path p4)
	     ;(free-path p5)
	     ;(free-path p6)
	     ;(free-path p7)
	     ;(free-path p8)
	     ;(free-path p9)
	     ;(free-path p10)
))
       (igoal (mapped))))

; (~ (and2 d e b)))))


#|
solutions:
* (run)
Creating objects (A B C D E F G P1 P2 P3) of type PATH

  2 n2 (done)
  4 n4 <*finish*>
  5   n5 (mapped)
  7   n7 <infer-mapped>
  8     n8 (mapped-and) [2]
 10     n10 <infer-mapped-and>
 11       n11 not (and2 d e b) [2]
 13       n13 <map-and2-not1nand2 d e b> [9]
[GC threshold exceeded with 2,870,352 bytes in use.  Commencing GC.]
[GC completed with 930,864 bytes retained and 1,939,488 bytes freed.]
[GC will next occur when at least 2,930,864 bytes are in use.]

 14       n14 <MAP-AND2-NOT1NAND2 D E B>
 14       n14 <INFER-MAPPED-AND> [2]
 15     n15 (mapped-or) [1]
 17     n17 <infer-mapped-or>
[GC threshold exceeded with 3,011,936 bytes in use.  Commencing GC.]
[GC completed with 1,076,560 bytes retained and 1,935,376 bytes freed.]
[GC will next occur when at least 3,076,560 bytes are in use.]

 18     n18 (mapped-not)
 20     n20 <infer-mapped-not>
 20     n20 <infer-mapped-not>
 20     n20 <INFER-MAPPED-NOT>
 20     n20 <INFER-MAPPED>
Achieved top-level goals.

Solution:
	<map-and2-not1nand2 d e b>
	<infer-mapped-and>
	<infer-mapped-or>
	<infer-mapped-not>
	<infer-mapped>

(((:STOP . :ACHIEVE) . #<BINDING-NODE 20 #<INFER-MAPPED-NOT>>)
 #<MAP-AND2-NOT1NAND2 [<P1> D] [<P2> E] [<P3> B] [<NEW> P2]>
 #<INFER-MAPPED-AND> #<INFER-MAPPED-OR> #<INFER-MAPPED-NOT>
 #<INFER-MAPPED>)

|#