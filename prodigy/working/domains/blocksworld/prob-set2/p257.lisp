(setf (current-problem)
  (create-problem
    (name p257)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))))