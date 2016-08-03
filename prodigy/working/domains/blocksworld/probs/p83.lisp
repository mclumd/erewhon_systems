(setf (current-problem)
  (create-problem
    (name p83)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockG)
          (on blockG blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))))