(setf (current-problem)
  (create-problem
    (name p346)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockC)
          (on-table blockC)
))))