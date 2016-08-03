(setf (current-problem)
  (create-problem
    (name p914)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockF)
          (on blockF blockA)
          (on blockA blockH)
          (on blockH blockC)
          (on-table blockC)
))))