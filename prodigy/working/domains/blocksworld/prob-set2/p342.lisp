(setf (current-problem)
  (create-problem
    (name p342)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
))))