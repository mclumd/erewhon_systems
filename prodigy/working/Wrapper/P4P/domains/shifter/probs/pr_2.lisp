;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Shift the world ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This problem is set up to see how the prodigy deals
;; with conflicts. Some packages must be moved before
;; other packages can be put in their place. Also we
;; want to see how prodigy deals with not having a goal
;; for the end position of the conveyer. It's supposed 
;; simply not care and will leave it where it ends up
;; after the last package is in it's place.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Two objects: pack1..pack2
;; Four slots: slot1..slot4
;; packages are stored in slots that are next to the 
;; conveyer.
;;
;;  Here is the initial state:
;;  _________________________
;;  |  p1 |  p2 |     |     |   (slots)
;;  -------------------------
;;  .  C  .     .     .     .   (conveyer system)
;;  -------------------------
;;
;;  Here is the goal state:
;;  _________________________
;;  |     |  p1 | p2  |     |   (slots)
;;  -------------------------
;;  .     .     .     .     .   (conveyer system)
;;  -------------------------
;;     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setf (current-problem)
      (create-problem
       (name pr2)
       (objects
        (pack1 pack2 OBJECT)
        (slot1 slot2 slot3 slot4 SLOT))
       
       ; the initial state
       (state 

        (and (conveyer-empty)
             (in-slot pack1 slot1)
             (in-slot pack2 slot2)
             (is-empty slot3)
             (is-empty slot4)
             (at-slot slot1)))
       
       ; the goal state
       (igoal 
        (and (in-slot pack1 slot2)
             (in-slot pack2 slot3)))))



