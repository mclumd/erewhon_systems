(setf (current-problem)
  (create-problem
    (name p309)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on blockA blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockH)
          (on blockH blockF)
          (on-table blockF)
))))