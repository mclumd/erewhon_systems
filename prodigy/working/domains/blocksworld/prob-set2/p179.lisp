(setf (current-problem)
  (create-problem
    (name p179)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on blockG blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
))))