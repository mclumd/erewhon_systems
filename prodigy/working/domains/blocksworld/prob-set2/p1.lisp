(setf (current-problem)
  (create-problem
    (name p1)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))))