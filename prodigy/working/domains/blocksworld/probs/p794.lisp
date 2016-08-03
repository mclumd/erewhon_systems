(setf (current-problem)
  (create-problem
    (name p794)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockG)
          (on blockG blockA)
          (on blockA blockF)
          (on blockF blockD)
          (on-table blockD)
))))