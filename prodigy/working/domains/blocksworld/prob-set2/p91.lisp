(setf (current-problem)
  (create-problem
    (name p91)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))))