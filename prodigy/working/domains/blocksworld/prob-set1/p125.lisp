(setf (current-problem)
  (create-problem
    (name p125)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockH)
          (on blockH blockA)
          (on-table blockA)
))))