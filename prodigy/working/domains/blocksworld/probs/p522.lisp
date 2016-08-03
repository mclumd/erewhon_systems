(setf (current-problem)
  (create-problem
    (name p522)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))))