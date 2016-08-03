(setf (current-problem)
  (create-problem
    (name p511)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockE)
          (on blockE blockA)
          (on-table blockA)
))))