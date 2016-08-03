(setf (current-problem)
  (create-problem
    (name p169)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockF)
          (on blockF blockE)
          (on blockE blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))))