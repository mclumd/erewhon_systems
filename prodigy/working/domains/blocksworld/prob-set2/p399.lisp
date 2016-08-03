(setf (current-problem)
  (create-problem
    (name p399)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockD)
          (on blockD blockH)
          (on blockH blockF)
          (on blockF blockA)
          (on blockA blockC)
          (on-table blockC)
))))