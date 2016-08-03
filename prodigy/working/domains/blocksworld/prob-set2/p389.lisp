(setf (current-problem)
  (create-problem
    (name p389)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
))))