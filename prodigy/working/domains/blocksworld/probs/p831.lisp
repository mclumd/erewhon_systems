(setf (current-problem)
  (create-problem
    (name p831)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
))))