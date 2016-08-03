(setf (current-problem)
  (create-problem
    (name p95)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockH)
          (on blockH blockA)
          (on blockA blockE)
          (on blockE blockF)
          (on blockF blockG)
          (on blockG blockB)
          (on blockB blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))))