(setf (current-problem)
  (create-problem
    (name p875)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockH)
          (on blockH blockC)
          (on-table blockC)
))))