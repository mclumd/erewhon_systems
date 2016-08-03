(setf (current-problem)
  (create-problem
    (name p418)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))))