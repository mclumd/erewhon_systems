(setf (current-problem)
  (create-problem
    (name p73)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))))