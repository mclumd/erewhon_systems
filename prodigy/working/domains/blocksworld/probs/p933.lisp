(setf (current-problem)
  (create-problem
    (name p933)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))))