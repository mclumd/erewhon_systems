(setf (current-problem)
  (create-problem
    (name p44)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))))