(setf (current-problem)
  (create-problem
    (name p699)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockH)
          (on blockH blockB)
          (on blockB blockA)
          (on blockA blockG)
          (on blockG blockD)
          (on blockD blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on blockH blockD)
          (on blockD blockF)
          (on blockF blockA)
          (on blockA blockC)
          (on blockC blockG)
          (on-table blockG)
))))