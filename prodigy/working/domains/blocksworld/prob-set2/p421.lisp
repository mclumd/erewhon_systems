(setf (current-problem)
  (create-problem
    (name p421)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
))))