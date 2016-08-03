(setf (current-problem)
  (create-problem
    (name p974)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on blockA blockD)
          (on blockD blockH)
          (on-table blockH)
))))