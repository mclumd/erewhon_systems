(setf (current-problem)
  (create-problem
    (name p478)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockG)
          (on blockG blockA)
          (on-table blockA)
))))