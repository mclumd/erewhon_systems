(setf (current-problem)
  (create-problem
    (name p175)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
))))