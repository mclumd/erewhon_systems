(setf (current-problem)
  (create-problem
    (name p505)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
))))