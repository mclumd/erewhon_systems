(setf (current-problem)
  (create-problem
    (name p644)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))))