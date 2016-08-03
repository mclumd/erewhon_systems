(setf (current-problem)
  (create-problem
    (name p313)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
))))