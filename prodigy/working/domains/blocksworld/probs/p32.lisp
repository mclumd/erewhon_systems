(setf (current-problem)
  (create-problem
    (name p32)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockA)
          (on blockA blockE)
          (on-table blockE)
))))