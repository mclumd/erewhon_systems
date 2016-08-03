(setf (current-problem)
  (create-problem
    (name p103)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
))))