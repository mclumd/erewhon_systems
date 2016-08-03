(setf (getf (p4::problem-space-plist *current-problem-space*) :depth-bound) 75)
(output-level 3)

(setf (current-problem)
      (create-problem
       (name ss2-3-prime)
       (objects
	(a b c BOX)
	(key12 KEY)
	(rm1 rm2 ROOM)
	(dr12 DOOR))
       (state
	(and (dr-to-rm dr12 rm2)
	     (dr-to-rm dr12 rm1)
	     (connects dr12 rm2 rm1)
	     (connects dr12 rm1 rm2)
	     (connects dr12 rm1 rm2)
	     (connects dr12 rm2 rm1)
	     (arm-empty)
	     (unlocked dr12)
	     (dr-closed dr12)
	     (pushable c)
	     (inroom c rm1)
	     (inroom b rm2)
	     (inroom a rm2)
	     (inroom key12 rm1)
	     (inroom robot rm2)
	     (carriable key12)
	     (is-key dr12 key12)))
       (igoal (and (inroom key12 rm2) (inroom c rm2)))))

#|
Solution:  
1. op-4     	<goto-dr dr12 rm2>
2. op-11        <open-door dr12>
3. op-5	        <go-thru-dr dr12 rm2 rm1>
4. op-15	<goto-obj key12 rm1>
5. op-7 	<pickup-obj key12>
6. op-8 	<goto-dr dr12 rm1>
7. op-16	<carry-thru-dr key12 dr12 rm2 rm1>
8. op-10	<putdown key12>
9. op-17	<go-thru-dr dr12 rm2 rm1>
10. op-12	<goto-obj c rm1>
11. op-13	<push-to-dr c dr12 rm1>
12. op-14	<push-thru-dr c dr12 rm1 rm2>


Achieving goal (next-to robot c), op-4 is applied, subgoals of op-4
are achieved by obs-2, obs-6, obs-8, obs-9
i.e., (open-door dr12), (goto-dr dr12 rm1), (putdown key12),
(go-thru-dr dr12 rm2 rm1).

Achieving goal (inroom c rm2), op-6  is applied, subgoals are achieved
by obs-2, obs-8, obs-10, obs-12
<open-door dr12>, <putdown key12>, <goto-obj c rm1>, <push-thru-dr c dr12 rm1 rm2>

Useful sequences of observations:
(dr-open dr12):       obs-1, obs-2;
(inroom robot rm1):   obs-1, obs-2, obs-3;
(next-to robot key):  obs-3, obs-4;
(holding key): obs-3, obs-4, obs-5;
(next-to robot dr12): obs-2, obs-5, obs-6;
(inroom robot rm2), 
(inroom key rm2):     obs-5, obs-6, obs-7;
(next-to robot key),
(arm-empty):          obs-2, obs-6, obs-7, obs-8;
(inroom robot rm1):   obs-2, obs-6, obs-8, obs-9;
(next-to robot c):    obs-2, obs-8, obs-9, obs-10;
(inroom c rm2):       obs-2, obs-8, obs-9, obs-10, obs-11,

Ones making sense:
(dr-open dr12):       obs-1, obs-2;
(inroom robot rm1):   obs-1, obs-2, obs-3;
(next-to robot key):  obs-3, obs-4;
(holding key): obs-3, obs-4, obs-5;
(inroom robot rm2), 
(inroom key rm2):     obs-5, obs-6, obs-7;
(inroom robot rm1):   obs-2, obs-6, obs-8, obs-9;
(next-to robot c):    obs-2, obs-8, obs-9, obs-10;

 New-op: OP-1;        Real-ops: (GOTO-DR)
 New-op: OP-2;        Real-ops: (GO-THRU-DR)
 New-op: OP-3;        Real-ops: (CLOSE-DOOR)
 New-op: OP-4;        Real-ops: (GOTO-DR)
 New-op: OP-5;        Real-ops: (GOTO-DR)
 New-op: OP-6;        Real-ops: (GOTO-OBJ)
 New-op: OP-7;        Real-ops: (PICKUP-OBJ)
 New-op: OP-8;        Real-ops: (GOTO-DR)
 New-op: OP-9;        Real-ops: (LOCK)
 New-op: OP-10;        Real-ops: (PUTDOWN)
 New-op: OP-11;        Real-ops: (OPEN-DOOR)
 New-op: OP-12;        Real-ops: (GOTO-OBJ)
 New-op: OP-13;        Real-ops: (PUSH-TO-DR)
 New-op: OP-14;        Real-ops: (PUSH-THRU-DR)
 New-op: OP-15;        Real-ops: (GOTO-OBJ)
 New-op: OP-16;        Real-ops: (CARRY-THRU-DR)
 New-op: OP-17;        Real-ops: (GO-THRU-DR)
 New-op: OP-18;        Real-ops: (GOTO-DR)
 New-op: OP-19;        Real-ops: (GOTO-OBJ)
|#

