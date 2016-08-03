(setf (current-problem)
  (create-problem
    (name p887)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
))))