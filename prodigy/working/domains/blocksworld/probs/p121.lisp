(setf (current-problem)
  (create-problem
    (name p121)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockF)
          (on blockF blockD)
          (on blockD blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockH)
          (on blockH blockG)
          (on-table blockG)
))))