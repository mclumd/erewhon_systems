(setf (current-problem)
  (create-problem
    (name p128)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockH)
          (on blockH blockA)
          (on blockA blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))))