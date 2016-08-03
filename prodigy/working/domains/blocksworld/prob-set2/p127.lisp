(setf (current-problem)
  (create-problem
    (name p127)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
))))