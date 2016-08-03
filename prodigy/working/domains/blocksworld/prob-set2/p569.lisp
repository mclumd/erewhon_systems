(setf (current-problem)
  (create-problem
    (name p569)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))))