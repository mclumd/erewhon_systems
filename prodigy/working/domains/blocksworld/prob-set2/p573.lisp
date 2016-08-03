(setf (current-problem)
  (create-problem
    (name p573)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))))