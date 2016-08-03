(setf (current-problem)
  (create-problem
    (name p864)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockD)
          (on blockD blockF)
          (on blockF blockC)
          (on blockC blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))))