(setf (current-problem)
  (create-problem
    (name p454)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on blockE blockF)
          (on-table blockF)
))))