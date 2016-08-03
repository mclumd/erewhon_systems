(setf (current-problem)
  (create-problem
    (name p839)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on blockE blockH)
          (on-table blockH)
))))