(setf (current-problem)
  (create-problem
    (name p151)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockH)
          (on blockH blockB)
          (on blockB blockF)
          (on blockF blockE)
          (on blockE blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
))))