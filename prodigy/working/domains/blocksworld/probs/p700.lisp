(setf (current-problem)
  (create-problem
    (name p700)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
))))