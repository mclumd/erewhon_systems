(setf (current-problem)
  (create-problem
    (name p356)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
))))