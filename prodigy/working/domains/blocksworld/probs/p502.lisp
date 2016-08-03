(setf (current-problem)
  (create-problem
    (name p502)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on blockC blockD)
          (on blockD blockG)
          (on blockG blockA)
          (on-table blockA)
))))