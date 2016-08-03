(setf (current-problem)
  (create-problem
    (name p494)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))))