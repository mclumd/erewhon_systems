(setf (current-problem)
  (create-problem
    (name p9)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))))