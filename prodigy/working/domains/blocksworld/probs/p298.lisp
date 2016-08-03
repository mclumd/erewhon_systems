(setf (current-problem)
  (create-problem
    (name p298)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockE)
          (on blockE blockG)
          (on blockG blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on blockC blockB)
          (on-table blockB)
))))