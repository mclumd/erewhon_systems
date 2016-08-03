(setf (current-problem)
  (create-problem
    (name p993)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on blockC blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockD)
          (on blockD blockF)
          (on-table blockF)
))))