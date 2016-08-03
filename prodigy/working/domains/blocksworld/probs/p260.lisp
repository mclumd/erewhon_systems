(setf (current-problem)
  (create-problem
    (name p260)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on blockD blockH)
          (on-table blockH)
))))