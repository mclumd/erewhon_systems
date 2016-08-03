(setf (current-problem)
  (create-problem
    (name p507)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
))))