(setf (current-problem)
  (create-problem
    (name p105)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))))