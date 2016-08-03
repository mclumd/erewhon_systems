(setf (current-problem)
  (create-problem
    (name p82)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockC)
          (on blockC blockD)
          (on blockD blockA)
          (on blockA blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))))