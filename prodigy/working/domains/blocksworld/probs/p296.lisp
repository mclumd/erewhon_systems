(setf (current-problem)
  (create-problem
    (name p296)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockC)
          (on blockC blockE)
          (on blockE blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
))))