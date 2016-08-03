(setf (current-problem)
  (create-problem
    (name p75)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
))))