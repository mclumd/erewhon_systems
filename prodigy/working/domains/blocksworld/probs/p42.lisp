(setf (current-problem)
  (create-problem
    (name p42)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))))