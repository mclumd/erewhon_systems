(setf (current-problem)
  (create-problem
    (name p366)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockB)
          (on blockB blockC)
          (on-table blockC)
))))