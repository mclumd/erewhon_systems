(setf (current-problem)
  (create-problem
    (name p147)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on blockH blockA)
          (on blockA blockF)
          (on blockF blockC)
          (on-table blockC)
))))