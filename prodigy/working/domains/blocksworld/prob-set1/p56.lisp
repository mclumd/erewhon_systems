(setf (current-problem)
  (create-problem
    (name p56)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))))