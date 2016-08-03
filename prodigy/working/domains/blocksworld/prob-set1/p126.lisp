(setf (current-problem)
  (create-problem
    (name p126)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockG)
          (on blockG blockD)
          (on blockD blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on blockC blockG)
          (on blockG blockH)
          (on blockH blockF)
          (on-table blockF)
))))