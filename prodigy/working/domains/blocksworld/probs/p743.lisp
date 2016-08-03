(setf (current-problem)
  (create-problem
    (name p743)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockC)
          (on blockC blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockD)
          (on blockD blockH)
          (on-table blockH)
))))