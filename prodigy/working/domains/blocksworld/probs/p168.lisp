(setf (current-problem)
  (create-problem
    (name p168)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockE)
          (on blockE blockC)
          (on-table blockC)
))))