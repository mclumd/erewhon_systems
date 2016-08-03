(setf (current-problem)
  (create-problem
    (name p870)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockB)
          (on blockB blockF)
          (on-table blockF)
))))