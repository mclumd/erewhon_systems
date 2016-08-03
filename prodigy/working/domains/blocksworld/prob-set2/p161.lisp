(setf (current-problem)
  (create-problem
    (name p161)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))))