(setf (current-problem)
  (create-problem
    (name p358)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockD)
          (on blockD blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))))