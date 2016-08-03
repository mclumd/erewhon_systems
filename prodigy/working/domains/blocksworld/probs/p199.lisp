(setf (current-problem)
  (create-problem
    (name p199)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockG)
          (on blockG blockF)
          (on blockF blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on blockB blockG)
          (on blockG blockC)
          (on blockC blockD)
          (on-table blockD)
))))