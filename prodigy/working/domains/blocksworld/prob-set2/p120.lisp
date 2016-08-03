(setf (current-problem)
  (create-problem
    (name p120)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockE)
          (on blockE blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))))