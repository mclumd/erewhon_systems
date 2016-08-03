(setf (current-problem)
  (create-problem
    (name p169)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockC)
          (on blockC blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on blockC blockF)
          (on blockF blockD)
          (on blockD blockH)
          (on-table blockH)
))))