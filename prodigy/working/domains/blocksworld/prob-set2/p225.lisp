(setf (current-problem)
  (create-problem
    (name p225)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockA)
          (on blockA blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
))))