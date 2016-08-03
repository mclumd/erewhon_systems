(setf (current-problem)
  (create-problem
    (name p436)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))))