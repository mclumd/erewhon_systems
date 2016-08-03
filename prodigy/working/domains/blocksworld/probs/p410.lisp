(setf (current-problem)
  (create-problem
    (name p410)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on blockF blockD)
          (on-table blockD)
))))