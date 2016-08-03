(setf (current-problem)
  (create-problem
    (name p648)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockA)
          (on blockA blockH)
          (on-table blockH)
))))