(setf (current-problem)
  (create-problem
    (name p12)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockA)
          (on blockA blockD)
          (on blockD blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockH)
          (on blockH blockA)
          (on blockA blockG)
          (on blockG blockC)
          (on-table blockC)
))))