(setf (current-problem)
  (create-problem
    (name p343)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
))))