(setf (current-problem)
  (create-problem
    (name p315)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))))