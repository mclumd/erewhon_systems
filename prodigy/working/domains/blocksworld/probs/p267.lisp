(setf (current-problem)
  (create-problem
    (name p267)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
))))