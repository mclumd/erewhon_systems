(setf (current-problem)
  (create-problem
    (name p443)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))))