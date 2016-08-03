(setf (current-problem)
  (create-problem
    (name p143)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockA)
          (on blockA blockB)
          (on blockB blockF)
          (on blockF blockH)
          (on blockH blockG)
          (on blockG blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
))))