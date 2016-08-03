(setf (current-problem)
  (create-problem
    (name p144)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
))))