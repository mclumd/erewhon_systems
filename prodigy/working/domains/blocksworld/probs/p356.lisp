(setf (current-problem)
  (create-problem
    (name p356)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockH)
          (on blockH blockC)
          (on blockC blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
))))