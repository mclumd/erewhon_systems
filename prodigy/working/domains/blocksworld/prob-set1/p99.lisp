(setf (current-problem)
  (create-problem
    (name p99)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on blockA blockG)
          (on blockG blockE)
          (on blockE blockC)
          (on-table blockC)
))))