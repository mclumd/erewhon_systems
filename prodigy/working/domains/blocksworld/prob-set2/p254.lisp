(setf (current-problem)
  (create-problem
    (name p254)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
))))