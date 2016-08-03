(setf (current-problem)
  (create-problem
    (name p286)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on blockF blockA)
          (on-table blockA)
))))