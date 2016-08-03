(setf (current-problem)
  (create-problem
    (name p907)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))))