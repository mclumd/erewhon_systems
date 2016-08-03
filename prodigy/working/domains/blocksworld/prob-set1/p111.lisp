(setf (current-problem)
  (create-problem
    (name p111)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on blockB blockD)
          (on blockD blockE)
          (on blockE blockC)
          (on-table blockC)
))))