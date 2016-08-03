(setf (current-problem)
  (create-problem
    (name p70)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on blockE blockA)
          (on blockA blockF)
          (on blockF blockD)
          (on-table blockD)
))))