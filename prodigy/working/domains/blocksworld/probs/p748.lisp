(setf (current-problem)
  (create-problem
    (name p748)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
))))