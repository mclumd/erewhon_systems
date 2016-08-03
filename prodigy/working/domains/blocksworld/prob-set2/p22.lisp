(setf (current-problem)
  (create-problem
    (name p22)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockD)
          (on blockD blockH)
          (on blockH blockB)
          (on blockB blockF)
          (on blockF blockG)
          (on blockG blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))))