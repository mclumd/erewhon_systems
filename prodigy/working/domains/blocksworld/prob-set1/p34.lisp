(setf (current-problem)
  (create-problem
    (name p34)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
))))