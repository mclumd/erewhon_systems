(setf (current-problem)
  (create-problem
    (name p256)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))))