(setf (current-problem)
  (create-problem
    (name p118)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
))))