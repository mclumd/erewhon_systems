(setf (current-problem)
  (create-problem
    (name p212)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockA)
          (on blockA blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))))