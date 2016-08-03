(setf (current-problem)
  (create-problem
    (name p199)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on blockC blockH)
          (on blockH blockD)
          (on-table blockD)
))))