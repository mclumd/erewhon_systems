(setf (current-problem)
  (create-problem
    (name p213)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))))