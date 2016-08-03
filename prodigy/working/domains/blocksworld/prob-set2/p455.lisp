(setf (current-problem)
  (create-problem
    (name p455)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
))))