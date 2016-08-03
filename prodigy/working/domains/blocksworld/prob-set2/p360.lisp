(setf (current-problem)
  (create-problem
    (name p360)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockD)
          (on blockD blockG)
          (on blockG blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
))))