(setf (current-problem)
  (create-problem
    (name p330)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))))