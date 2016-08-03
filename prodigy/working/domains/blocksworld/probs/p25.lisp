(setf (current-problem)
  (create-problem
    (name p25)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))))