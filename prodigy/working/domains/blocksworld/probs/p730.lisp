(setf (current-problem)
  (create-problem
    (name p730)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
))))