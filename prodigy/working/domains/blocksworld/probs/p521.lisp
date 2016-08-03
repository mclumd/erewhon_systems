(setf (current-problem)
  (create-problem
    (name p521)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))))