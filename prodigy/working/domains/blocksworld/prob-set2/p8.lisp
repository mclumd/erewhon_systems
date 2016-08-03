(setf (current-problem)
  (create-problem
    (name p8)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))))