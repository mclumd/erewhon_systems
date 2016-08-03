(setf (current-problem)
  (create-problem
    (name p322)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))))