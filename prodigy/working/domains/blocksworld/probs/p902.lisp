(setf (current-problem)
  (create-problem
    (name p902)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockF)
          (on blockF blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on blockF blockA)
          (on blockA blockC)
          (on-table blockC)
))))