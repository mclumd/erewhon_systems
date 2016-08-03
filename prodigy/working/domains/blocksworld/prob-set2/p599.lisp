(setf (current-problem)
  (create-problem
    (name p599)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockF)
          (on blockF blockC)
          (on blockC blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))))