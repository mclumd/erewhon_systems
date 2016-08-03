(setf (current-problem)
  (create-problem
    (name p330)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockA)
          (on blockA blockE)
          (on-table blockE)
))))