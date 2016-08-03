(setf (current-problem)
  (create-problem
    (name p210)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
))))