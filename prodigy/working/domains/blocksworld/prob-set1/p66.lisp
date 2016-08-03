(setf (current-problem)
  (create-problem
    (name p66)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
))))