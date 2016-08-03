(setf (current-problem)
  (create-problem
    (name p78)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockD)
          (on blockD blockF)
          (on blockF blockA)
          (on-table blockA)
))))