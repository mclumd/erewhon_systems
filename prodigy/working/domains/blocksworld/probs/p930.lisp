(setf (current-problem)
  (create-problem
    (name p930)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
))))