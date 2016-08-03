(setf (current-problem)
  (create-problem
    (name p183)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))))