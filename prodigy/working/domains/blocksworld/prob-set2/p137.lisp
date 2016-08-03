(setf (current-problem)
  (create-problem
    (name p137)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockE)
          (on blockE blockF)
          (on blockF blockD)
          (on blockD blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
))))