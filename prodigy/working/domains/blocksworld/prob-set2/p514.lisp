(setf (current-problem)
  (create-problem
    (name p514)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))))