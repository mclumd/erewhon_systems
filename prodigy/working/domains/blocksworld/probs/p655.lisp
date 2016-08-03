(setf (current-problem)
  (create-problem
    (name p655)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockC)
          (on blockC blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockG)
          (on blockG blockE)
          (on-table blockE)
))))