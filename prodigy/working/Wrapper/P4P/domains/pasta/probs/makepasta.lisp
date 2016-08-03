;;;;
;;;; Name: Philomena Lee
;;;; class: cs609
;;;; assignment #2 
;;;;
;;;; this is problem description: 
;;;;  initial state: 
;;;;       angel-hair is pasta, meat is beef. 
;;;;       pan1 is saucepan, pan2 is dutch-oven and 
;;;;       H2O is water. 
;;;;
(setf (current-problem)
      (create-problem
       (name MakePasta)
       (objects
         (angel-hair pasta)
         (beef meat) 
         (pan1 dutch-oven) 
         (pan2 saucepan) 
         (H2O  water)
       )
       (state
        (and 
             (is-clear H2O)
             (is-clear angel-hair)
             (is-clear beef)
             (is-empty pan1)
             (is-empty pan2) )
       )
       (goal
           ( and (on beef angel-hair))
       )
     )
      )
