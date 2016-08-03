(setf (current-problem)
  (create-problem
    (name p105)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockA)
          (on blockA blockH)
          (on blockH blockD)
          (on-table blockD)
))))