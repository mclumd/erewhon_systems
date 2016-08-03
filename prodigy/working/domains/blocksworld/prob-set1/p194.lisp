(setf (current-problem)
  (create-problem
    (name p194)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockA)
          (on blockA blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
))))