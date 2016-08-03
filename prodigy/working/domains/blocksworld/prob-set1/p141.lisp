(setf (current-problem)
  (create-problem
    (name p141)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))))