(setf (current-problem)
  (create-problem
    (name p200)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockD)
          (on blockD blockB)
          (on blockB blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))))