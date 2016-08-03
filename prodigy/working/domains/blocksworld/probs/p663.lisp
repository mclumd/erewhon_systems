(setf (current-problem)
  (create-problem
    (name p663)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on blockF blockG)
          (on-table blockG)
))))