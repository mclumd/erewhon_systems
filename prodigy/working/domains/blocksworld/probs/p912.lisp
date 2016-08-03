(setf (current-problem)
  (create-problem
    (name p912)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockA)
          (on blockA blockF)
          (on blockF blockH)
          (on blockH blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockD)
          (on blockD blockA)
          (on-table blockA)
))))