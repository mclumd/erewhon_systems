(setf (current-problem)
  (create-problem
    (name p713)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on blockG blockB)
          (on blockB blockD)
          (on blockD blockC)
          (on blockC blockE)
          (on-table blockE)
))))