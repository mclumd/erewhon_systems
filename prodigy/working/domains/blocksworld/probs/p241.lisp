(setf (current-problem)
  (create-problem
    (name p241)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on blockG blockB)
          (on-table blockB)
))))