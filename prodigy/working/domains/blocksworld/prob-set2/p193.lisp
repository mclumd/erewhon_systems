(setf (current-problem)
  (create-problem
    (name p193)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockA)
          (on blockA blockG)
          (on blockG blockH)
          (on-table blockH)
))))