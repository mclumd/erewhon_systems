(setf (current-problem)
  (create-problem
    (name p335)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on blockG blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))))