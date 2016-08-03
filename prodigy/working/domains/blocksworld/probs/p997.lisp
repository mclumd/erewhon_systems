(setf (current-problem)
  (create-problem
    (name p997)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockE)
          (on blockE blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockD)
          (on blockD blockC)
          (on blockC blockH)
          (on blockH blockE)
          (on blockE blockG)
          (on blockG blockB)
          (on-table blockB)
))))