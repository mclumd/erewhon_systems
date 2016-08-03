(setf (current-problem)
  (create-problem
    (name p587)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))))