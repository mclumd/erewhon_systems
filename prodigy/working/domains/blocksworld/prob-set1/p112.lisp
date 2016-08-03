(setf (current-problem)
  (create-problem
    (name p112)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockA)
          (on blockA blockC)
          (on blockC blockF)
          (on blockF blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on blockC blockH)
          (on blockH blockF)
          (on blockF blockE)
          (on-table blockE)
))))