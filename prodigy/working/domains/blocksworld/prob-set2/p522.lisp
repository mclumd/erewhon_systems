(setf (current-problem)
  (create-problem
    (name p522)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))))