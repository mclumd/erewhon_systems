(setf (current-problem)
  (create-problem
    (name p612)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockC)
          (on blockC blockD)
          (on blockD blockB)
          (on blockB blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
))))