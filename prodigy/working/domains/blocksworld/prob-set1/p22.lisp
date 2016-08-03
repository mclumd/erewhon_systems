(setf (current-problem)
  (create-problem
    (name p22)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockB)
          (on blockB blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))))