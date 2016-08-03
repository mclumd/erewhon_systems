(setf (current-problem)
  (create-problem
    (name p109)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
))))