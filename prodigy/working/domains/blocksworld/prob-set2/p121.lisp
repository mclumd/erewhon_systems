(setf (current-problem)
  (create-problem
    (name p121)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockC)
          (on blockC blockB)
          (on blockB blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockE)
          (on blockE blockD)
          (on blockD blockG)
          (on-table blockG)
))))