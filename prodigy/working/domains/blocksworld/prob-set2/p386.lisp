(setf (current-problem)
  (create-problem
    (name p386)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockD)
          (on blockD blockE)
          (on blockE blockH)
          (on blockH blockF)
          (on blockF blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))))