(setf (current-problem)
  (create-problem
    (name p923)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockF)
          (on blockF blockC)
          (on blockC blockH)
          (on blockH blockD)
          (on blockD blockE)
          (on blockE blockA)
          (on-table blockA)
))))