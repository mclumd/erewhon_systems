(setf (current-problem)
  (create-problem
    (name p142)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockA)
          (on blockA blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockA)
          (on blockA blockB)
          (on blockB blockE)
          (on blockE blockC)
          (on blockC blockH)
          (on blockH blockF)
          (on-table blockF)
))))