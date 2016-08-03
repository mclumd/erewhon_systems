(setf (current-problem)
  (create-problem
    (name p147)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
))))