(setf (current-problem)
  (create-problem
    (name p381)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockH)
          (on blockH blockB)
          (on blockB blockD)
          (on blockD blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
))))