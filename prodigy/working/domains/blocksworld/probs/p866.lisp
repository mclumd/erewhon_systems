(setf (current-problem)
  (create-problem
    (name p866)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))))