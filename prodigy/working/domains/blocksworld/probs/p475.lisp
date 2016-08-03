(setf (current-problem)
  (create-problem
    (name p475)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
))))