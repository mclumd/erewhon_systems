(setf (current-problem)
  (create-problem
    (name p283)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))))