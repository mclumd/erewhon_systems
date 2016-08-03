(setf (current-problem)
  (create-problem
    (name p225)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockC)
          (on blockC blockA)
          (on-table blockA)
))))