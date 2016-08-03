(setf (current-problem)
  (create-problem
    (name p205)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))))