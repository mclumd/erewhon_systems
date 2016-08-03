(setf (current-problem)
  (create-problem
    (name p195)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on blockH blockB)
          (on-table blockB)
))))