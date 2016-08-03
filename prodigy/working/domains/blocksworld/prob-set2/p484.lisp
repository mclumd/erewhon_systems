(setf (current-problem)
  (create-problem
    (name p484)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on blockB blockG)
          (on blockG blockD)
          (on blockD blockC)
          (on-table blockC)
))))