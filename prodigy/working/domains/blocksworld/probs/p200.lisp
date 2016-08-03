(setf (current-problem)
  (create-problem
    (name p200)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
))))