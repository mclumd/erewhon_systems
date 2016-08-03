(setf (current-problem)
  (create-problem
    (name p836)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))))