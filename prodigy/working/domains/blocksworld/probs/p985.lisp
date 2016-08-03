(setf (current-problem)
  (create-problem
    (name p985)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockE)
          (on blockE blockB)
          (on blockB blockF)
          (on blockF blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
))))