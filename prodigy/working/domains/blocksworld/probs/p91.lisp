(setf (current-problem)
  (create-problem
    (name p91)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockC)
          (on blockC blockB)
          (on blockB blockH)
          (on blockH blockG)
          (on-table blockG)
))))