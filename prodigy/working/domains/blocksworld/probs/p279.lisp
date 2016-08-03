(setf (current-problem)
  (create-problem
    (name p279)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockB)
          (on blockB blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockH)
          (on blockH blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
))))