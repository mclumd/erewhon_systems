(setf (current-problem)
  (create-problem
    (name p191)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockC)
          (on blockC blockG)
          (on blockG blockD)
          (on blockD blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockG)
          (on blockG blockA)
          (on blockA blockD)
          (on blockD blockE)
          (on-table blockE)
))))