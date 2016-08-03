(setf (current-problem)
  (create-problem
    (name p485)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))))