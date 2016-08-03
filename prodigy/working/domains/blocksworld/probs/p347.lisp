(setf (current-problem)
  (create-problem
    (name p347)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
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