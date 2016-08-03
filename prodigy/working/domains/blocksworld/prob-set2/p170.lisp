(setf (current-problem)
  (create-problem
    (name p170)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockB)
          (on blockB blockF)
          (on blockF blockH)
          (on blockH blockE)
          (on-table blockE)
))))