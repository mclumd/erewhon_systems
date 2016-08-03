(setf (current-problem)
  (create-problem
    (name p142)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
))))