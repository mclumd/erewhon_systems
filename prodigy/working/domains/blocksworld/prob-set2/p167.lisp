(setf (current-problem)
  (create-problem
    (name p167)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockD)
          (on blockD blockB)
          (on-table blockB)
))))