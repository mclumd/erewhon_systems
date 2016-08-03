(setf (current-problem)
  (create-problem
    (name p273)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on blockH blockD)
          (on blockD blockC)
          (on blockC blockE)
          (on-table blockE)
))))