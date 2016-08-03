(setf (current-problem)
  (create-problem
    (name p185)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockF)
          (on blockF blockH)
          (on blockH blockC)
          (on blockC blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))))