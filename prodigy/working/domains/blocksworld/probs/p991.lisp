(setf (current-problem)
  (create-problem
    (name p991)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))))