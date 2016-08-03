(setf (current-problem)
  (create-problem
    (name p405)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockE)
          (on blockE blockG)
          (on blockG blockH)
          (on blockH blockA)
          (on blockA blockF)
          (on blockF blockC)
          (on blockC blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
))))