(setf (current-problem)
  (create-problem
    (name p344)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))))