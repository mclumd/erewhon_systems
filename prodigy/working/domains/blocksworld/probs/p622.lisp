(setf (current-problem)
  (create-problem
    (name p622)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))))