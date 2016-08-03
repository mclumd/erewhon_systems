(setf (current-problem)
  (create-problem
    (name p69)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))))