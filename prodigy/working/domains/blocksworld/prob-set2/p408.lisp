(setf (current-problem)
  (create-problem
    (name p408)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on blockF blockA)
          (on blockA blockG)
          (on blockG blockC)
          (on-table blockC)
))))