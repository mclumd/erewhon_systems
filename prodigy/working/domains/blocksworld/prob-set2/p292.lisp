(setf (current-problem)
  (create-problem
    (name p292)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on blockC blockG)
          (on-table blockG)
))))