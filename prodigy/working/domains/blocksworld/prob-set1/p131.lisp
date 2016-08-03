(setf (current-problem)
  (create-problem
    (name p131)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on blockA blockG)
          (on-table blockG)
))))