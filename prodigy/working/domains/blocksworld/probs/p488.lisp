(setf (current-problem)
  (create-problem
    (name p488)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
))))