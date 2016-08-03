(setf (current-problem)
  (create-problem
    (name p496)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockG)
          (on blockG blockA)
          (on blockA blockC)
          (on blockC blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))))