(setf (current-problem)
  (create-problem
    (name p621)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))))