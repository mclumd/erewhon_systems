(setf (current-problem)
  (create-problem
    (name p79)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
))))