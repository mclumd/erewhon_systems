(setf (current-problem)
  (create-problem
    (name p181)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
))))