(setf (current-problem)
  (create-problem
    (name p200)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on blockF blockD)
          (on blockD blockB)
          (on blockB blockA)
          (on blockA blockH)
          (on blockH blockE)
          (on-table blockE)
))))