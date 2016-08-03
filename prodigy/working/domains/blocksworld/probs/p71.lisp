(setf (current-problem)
  (create-problem
    (name p71)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockD)
          (on blockD blockG)
          (on blockG blockC)
          (on blockC blockA)
          (on blockA blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
))))