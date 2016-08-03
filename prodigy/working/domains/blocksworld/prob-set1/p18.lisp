(setf (current-problem)
  (create-problem
    (name p18)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))))