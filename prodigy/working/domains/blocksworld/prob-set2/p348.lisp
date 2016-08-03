(setf (current-problem)
  (create-problem
    (name p348)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))))