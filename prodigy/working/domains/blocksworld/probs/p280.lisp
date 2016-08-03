(setf (current-problem)
  (create-problem
    (name p280)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))))