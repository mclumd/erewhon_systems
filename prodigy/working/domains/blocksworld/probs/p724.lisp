(setf (current-problem)
  (create-problem
    (name p724)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
))))