(setf (current-problem)
  (create-problem
    (name p944)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockB)
          (on blockB blockE)
          (on-table blockE)
))))