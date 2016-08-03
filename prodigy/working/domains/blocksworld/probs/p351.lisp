(setf (current-problem)
  (create-problem
    (name p351)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockC)
          (on blockC blockG)
          (on blockG blockF)
          (on blockF blockD)
          (on blockD blockA)
          (on blockA blockB)
          (on-table blockB)
))))