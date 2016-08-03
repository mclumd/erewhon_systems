(setf (current-problem)
  (create-problem
    (name p321)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockF)
          (on blockF blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on blockB blockC)
          (on-table blockC)
))))