(setf (current-problem)
  (create-problem
    (name p168)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockH)
          (on blockH blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockF)
          (on blockF blockB)
          (on blockB blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
))))