(setf (current-problem)
  (create-problem
    (name p209)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockE)
          (on blockE blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockE)
          (on blockE blockB)
          (on-table blockB)
))))