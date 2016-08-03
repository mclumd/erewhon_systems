(setf (current-problem)
  (create-problem
    (name p160)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
))))