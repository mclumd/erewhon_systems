(setf (current-problem)
  (create-problem
    (name p419)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockD)
          (on blockD blockC)
          (on blockC blockE)
          (on blockE blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockA)
          (on blockA blockE)
          (on-table blockE)
))))