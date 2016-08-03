(setf (current-problem)
  (create-problem
    (name p103)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockE)
          (on blockE blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on blockD blockC)
          (on blockC blockG)
          (on blockG blockH)
          (on-table blockH)
))))