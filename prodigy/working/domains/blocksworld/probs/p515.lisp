(setf (current-problem)
  (create-problem
    (name p515)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockA)
          (on blockA blockG)
          (on blockG blockD)
          (on blockD blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))))