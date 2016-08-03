(setf (current-problem)
  (create-problem
    (name p39)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))))