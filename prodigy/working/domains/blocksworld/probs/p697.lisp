(setf (current-problem)
  (create-problem
    (name p697)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockA)
          (on blockA blockF)
          (on blockF blockC)
          (on blockC blockE)
          (on-table blockE)
))))