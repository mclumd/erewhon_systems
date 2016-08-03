;;;;
;;;; Name: Philomena Lee
;;;;       Mayur
;;;;       Anoop
;;;; Class: CS609
;;;; Assignment: 2
;;;;
;;;; Location:
;;;;  /common/users2/csstu1/s005pxl/prodigy/domains/test/domain.lisp
;;;;  /common/users2/csstu1/s005pxl/prodigy/domains/test/probs/makepasta.lisp
;;;;  /common/users2/csstu1/s005pxl/prodigy/domains/test/probs/hotwater.lisp
;;;; 
;;;; Description: 
;;;;   This assignment is a simple domain of cooking pasta. It consists of 
;;;;   the following operators: 
;;;;    * put-into-corningware - if we have food and corningware, it put
;;;;          food ingredient into the pan. 
;;;;    * boil-the-water - if water is in the dutch-oven, it boils the water,
;;;;    * cook-the-meat, cook-the-pasta :- will issue is-cooked-xxxx if it 
;;;;      satisfies the precondition.
;;;;    * pour-meat-on-pasta - actually pur cooked pasta onto meat. 
;;;;
;;;;  There are 2 problems defined: 
;;;;    makepasta - goal is a plan to cook pasta given angel-hair and beef.
;;;;    hotwater - goal is to generate a plan to boil water given some water
;;;;               and pan. 
;;;;    
;;;;  Predicate: 
;;;;     is-clear - depicts the state of an object to be uncooked and not 
;;;;                in any container. 
;;;;     is-boiling-water - object is boiled.
;;;;     in - fist object is inside second object.
;;;;     is-cooked-pasta - object is pasta and cooked.
;;;;     is-cooked-meat - object is meat and cooked.
;;;;     is-empty - object is empty.
;;;;     on - one object is mixed in with the other.       
;;;;      

(create-problem-space 'myworld :current t)


;;
;;;;
;;;;  declaration of some types : root is FOOD and MEAT. 
;;;;  FOOD has subtype pasta and water. MEAT has subtype 
;;;;  beef and chicken.
;;;;  CORNINGWARE is another ROOT type with subtype 
;;;;  saucepan and dutch-oven.
;;;; 
;;;; 
(ptype-of FOOD :top-type)
(ptype-of pasta FOOD)
(ptype-of water FOOD)

(ptype-of MEAT :top-type)
(ptype-of beef  MEAT)
(ptype-of chicken MEAT)


(ptype-of CORNINGWARE :top-type)
(ptype-of saucepan CORNINGWARE)
(ptype-of dutch-oven CORNINGWARE)

;;;; 
;;;;  if <ob1> is food or meat, <ob2> is corningware and 
;;;;  <ob1> is clear and <ob2> is empty. then put food
;;;;  into container. 
;;;; 
(OPERATOR put-into-corningware
   (params <ob1> <ob2> )

   (preconds
     (( <ob1> (OR FOOD MEAT) )
      ( <ob2>  CORNINGWARE )
     )
     ( and (is-clear <ob1>)
           (is-empty <ob2>)
     )
   )
   (effects
      ()
      (  (del (is-clear <ob1> ) ) 
         (del (is-empty <ob2> ) )
         (add (in <ob1> <ob2> ) )
      )
   )
)
;;;; 
;;;;  if water is inside the dutch-oven, apply the operator
;;;;  to indicate that water is boiling. 
;;;; 
(OPERATOR boil-the-water
  (params <ob1> <ob2>)
  (preconds
   ((<ob1> water)
    (<ob2> dutch-oven)
   )
   ( and (in <ob1> <ob2> ) 
   )
  )
  (effects

     () ; water is put into container which is no longer
        ; empty and water is now hot.
     (
       (add (is-boiling-water <ob1>) )
     )
  )
)
;;;; 
;;;;  if meat is inside the saucepan. apply the operator
;;;;  to indicate that meat is cooked. 
;;;;
(OPERATOR cook-the-meat
  (params <ob1> <ob2>)
  (preconds
   ((<ob1> meat)
    (<ob2> saucepan)
   )
   ( and (in <ob1> <ob2> )
   )
  )
  (effects
     () ; water is put into container which is no longer
        ; empty and water is now hot. 
     ( 
       (add (is-cooked-meat <ob1>) )
     )

  )
)
;;;;
;;;; if water is boiling, pasta is uncooked
;;;; fire operator to indicate pasta is cooked in 
;;;; the dutch-oven.
;;;; 
(OPERATOR cook-the-pasta
  (params <ob1> <ob2>)
  (preconds 
    ( ( <ob1> pasta )
      ( <ob2> water ) 
      ( <ob3> dutch-oven )
    )
    (and (is-boiling-water <ob2> )
         (is-clear <ob1> )
         (in <ob2> <ob3> )
    )
  )
  ( effects
       () 
       ( ( del (is-clear <ob1> ))

         ( add (in <ob1> <ob3> ))
         ( add (is-cooked-pasta <ob1>) ) 
       )
  )      
)
;;;;
;;;; if meat and pasta is cooked, mix meat and pasta 
;;;; together. 

;;;;
(OPERATOR pour-meat-on-pasta
   (params <ob1> <ob2> )
   ( preconds 
      ( ( <ob1> meat)
        ( <ob2> pasta)
      )
      ( and  (is-cooked-meat <ob1>)
             (is-cooked-pasta <ob2>)
      )
   )
   ( effects 
       ( ( <ob3> saucepan)
         ( <ob4> dutch-oven)
         ( <ob5> water)
       )
       ( (del ( in <ob2> <ob4>))
         (deL ( in <ob5> <ob4>)) 
         (add ( is-empty <ob4>))
         (add ( in <ob2> <ob3>))
         (add ( on <ob1> <ob2>))
       )
   )
   )
