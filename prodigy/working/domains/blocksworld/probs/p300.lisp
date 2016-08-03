(setf (current-problem)
  (create-problem
    (name p300)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockE)
          (on blockE blockC)
          (on blockC blockA)
          (on-table blockA)
))))