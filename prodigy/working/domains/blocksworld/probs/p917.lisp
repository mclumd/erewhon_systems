(setf (current-problem)
  (create-problem
    (name p917)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))))