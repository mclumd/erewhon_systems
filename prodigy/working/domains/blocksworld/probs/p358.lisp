(setf (current-problem)
  (create-problem
    (name p358)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))))