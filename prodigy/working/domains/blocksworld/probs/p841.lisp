(setf (current-problem)
  (create-problem
    (name p841)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on blockD blockE)
          (on-table blockE)
))))