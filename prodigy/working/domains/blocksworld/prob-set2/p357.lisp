(setf (current-problem)
  (create-problem
    (name p357)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
))))