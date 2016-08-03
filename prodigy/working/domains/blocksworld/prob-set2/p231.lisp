(setf (current-problem)
  (create-problem
    (name p231)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
))))