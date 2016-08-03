(setf (current-problem)
  (create-problem
    (name p125)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockD)
          (on blockD blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
))))