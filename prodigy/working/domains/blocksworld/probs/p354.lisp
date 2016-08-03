(setf (current-problem)
  (create-problem
    (name p354)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
))))