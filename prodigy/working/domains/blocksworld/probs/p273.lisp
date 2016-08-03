(setf (current-problem)
  (create-problem
    (name p273)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on blockC blockD)
          (on-table blockD)
))))