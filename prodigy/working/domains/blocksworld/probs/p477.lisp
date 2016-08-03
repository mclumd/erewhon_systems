(setf (current-problem)
  (create-problem
    (name p477)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))))