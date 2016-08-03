(setf (current-problem)
  (create-problem
    (name p149)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockA)
          (on blockA blockE)
          (on-table blockE)
))))