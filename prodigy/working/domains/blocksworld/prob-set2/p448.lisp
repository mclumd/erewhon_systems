(setf (current-problem)
  (create-problem
    (name p448)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockH)
          (on blockH blockA)
          (on blockA blockF)
          (on blockF blockC)
          (on blockC blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
))))