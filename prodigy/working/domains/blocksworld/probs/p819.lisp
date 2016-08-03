(setf (current-problem)
  (create-problem
    (name p819)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on blockA blockE)
          (on-table blockE)
))))