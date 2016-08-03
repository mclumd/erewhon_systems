(setf (current-problem)
  (create-problem
    (name p517)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockG)
          (on blockG blockD)
          (on blockD blockF)
          (on blockF blockC)
          (on blockC blockE)
          (on blockE blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockC)
          (on blockC blockF)
          (on-table blockF)
))))