(setf (current-problem)
  (create-problem
    (name p889)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on blockH blockC)
          (on-table blockC)
))))