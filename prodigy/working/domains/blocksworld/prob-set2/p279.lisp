(setf (current-problem)
  (create-problem
    (name p279)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))))