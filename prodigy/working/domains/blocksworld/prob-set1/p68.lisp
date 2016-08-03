(setf (current-problem)
  (create-problem
    (name p68)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockC)
          (on blockC blockB)
          (on blockB blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockH)
          (on blockH blockB)
          (on-table blockB)
))))