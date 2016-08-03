(setf (current-problem)
  (create-problem
    (name p311)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on blockF blockC)
          (on blockC blockA)
          (on blockA blockH)
          (on-table blockH)
))))