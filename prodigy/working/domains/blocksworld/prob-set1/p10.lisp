(setf (current-problem)
  (create-problem
    (name p10)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockD)
          (on blockD blockH)
          (on-table blockH)
))))