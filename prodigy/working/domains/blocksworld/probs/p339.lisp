(setf (current-problem)
  (create-problem
    (name p339)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockB)
          (on blockB blockF)
          (on blockF blockE)
          (on blockE blockG)
          (on blockG blockA)
          (on blockA blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockB)
          (on blockB blockG)
          (on-table blockG)
))))