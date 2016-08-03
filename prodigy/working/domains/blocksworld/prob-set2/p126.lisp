(setf (current-problem)
  (create-problem
    (name p126)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on blockF blockH)
          (on blockH blockD)
          (on blockD blockG)
          (on-table blockG)
))))