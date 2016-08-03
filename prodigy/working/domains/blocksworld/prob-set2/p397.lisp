(setf (current-problem)
  (create-problem
    (name p397)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
))))