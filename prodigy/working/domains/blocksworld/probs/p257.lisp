(setf (current-problem)
  (create-problem
    (name p257)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockB)
          (on blockB blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))))