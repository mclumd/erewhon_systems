(setf (current-problem)
  (create-problem
    (name p320)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
))))