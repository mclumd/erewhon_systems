(setf (current-problem)
  (create-problem
    (name p190)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))))