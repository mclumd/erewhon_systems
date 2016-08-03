(setf (current-problem)
  (create-problem
    (name p62)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on blockC blockA)
          (on-table blockA)
))))