(setf (current-problem)
  (create-problem
    (name p348)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockC)
          (on blockC blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
))))