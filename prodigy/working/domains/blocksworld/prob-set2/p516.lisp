(setf (current-problem)
  (create-problem
    (name p516)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))))