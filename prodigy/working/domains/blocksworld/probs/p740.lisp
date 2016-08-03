(setf (current-problem)
  (create-problem
    (name p740)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))))