(setf (current-problem)
  (create-problem
    (name p715)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))))