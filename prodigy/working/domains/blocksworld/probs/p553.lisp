(setf (current-problem)
  (create-problem
    (name p553)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))))