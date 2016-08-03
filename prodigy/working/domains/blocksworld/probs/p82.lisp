(setf (current-problem)
  (create-problem
    (name p82)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
))))