(setf (current-problem)
  (create-problem
    (name p838)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockF)
          (on blockF blockH)
          (on blockH blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
))))