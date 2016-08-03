;;; A translation of the UCPOP road-operators domain into prodigy 4.0
;;; syntax, for comparison.
;;; Jim Blythe, 4/4/93

(create-problem-space 'uc-road-operators :current t)

;;; The original domain in UCPOP doesn't make use of the types,
;;; although it has them as static predicates.

(ptype-of Vehicle :top-type)
(ptype-of Place   :top-type)

(OPERATOR 
 drive
 (params <vehicle> <location1> <location2>)
 (preconds 
  ((<vehicle> Vehicle)
   (<location1> Place)
   (<location2> Place))
  (and (at <vehicle> <location1>)
       (road <location1> <location2>)))
 (effects 
  ()
  ((add (at <vehicle> <location2>))
   (del (at <vehicle> <location1>)))
  ))

(operator
 cross
 (params <vehicle> <location1> <location2>)
 (preconds
  ((<vehicle> Vehicle)
   (<location1> Place)
   (<location2> Place))
  (and (at <vehicle> <location1>) (bridge <location1> <location2>)))
 (effects
  ()
  ((add (at <vehicle> <location2>))
   (del (at <vehicle> <location1>)))))







