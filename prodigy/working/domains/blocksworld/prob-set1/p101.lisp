(setf (current-problem)
  (create-problem
    (name p101)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockD)
          (on-table blockD)
))))