(setf (current-problem)
  (create-problem
    (name p369)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))))