(setf (current-problem)
  (create-problem
    (name p567)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockB)
          (on blockB blockG)
          (on blockG blockD)
          (on blockD blockF)
          (on blockF blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
))))