(setf (current-problem)
  (create-problem
    (name p155)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on blockH blockE)
          (on blockE blockA)
          (on blockA blockG)
          (on-table blockG)
))))