(setf (current-problem)
  (create-problem
    (name p58)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockA)
          (on blockA blockF)
          (on blockF blockE)
          (on-table blockE)
))))