(setf (current-problem)
  (create-problem
    (name p429)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on blockF blockB)
          (on blockB blockA)
          (on-table blockA)
))))