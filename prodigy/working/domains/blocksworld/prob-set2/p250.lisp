(setf (current-problem)
  (create-problem
    (name p250)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))))