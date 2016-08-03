(setf (current-problem)
  (create-problem
    (name p632)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))))