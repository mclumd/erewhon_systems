(setf (current-problem)
  (create-problem
    (name p425)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
))))