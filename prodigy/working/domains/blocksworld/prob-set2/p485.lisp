(setf (current-problem)
  (create-problem
    (name p485)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockB)
          (on blockB blockF)
          (on blockF blockC)
          (on blockC blockD)
          (on blockD blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockG)
          (on blockG blockE)
          (on-table blockE)
))))