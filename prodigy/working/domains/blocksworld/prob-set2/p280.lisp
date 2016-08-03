(setf (current-problem)
  (create-problem
    (name p280)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))))