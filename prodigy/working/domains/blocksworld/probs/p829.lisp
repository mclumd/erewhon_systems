(setf (current-problem)
  (create-problem
    (name p829)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockB)
          (on blockB blockA)
          (on blockA blockD)
          (on-table blockD)
))))