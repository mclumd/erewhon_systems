(setf (current-problem)
  (create-problem
    (name p488)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))))