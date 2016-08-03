(setf (current-problem)
  (create-problem
    (name p15)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on blockA blockF)
          (on-table blockF)
))))