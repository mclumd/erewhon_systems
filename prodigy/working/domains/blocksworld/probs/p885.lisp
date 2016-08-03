(setf (current-problem)
  (create-problem
    (name p885)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockG)
          (on blockG blockD)
          (on blockD blockB)
          (on blockB blockF)
          (on blockF blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))))