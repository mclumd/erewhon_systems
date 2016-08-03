(setf (current-problem)
  (create-problem
    (name p306)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockB)
          (on blockB blockE)
          (on blockE blockC)
          (on blockC blockA)
          (on blockA blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
))))