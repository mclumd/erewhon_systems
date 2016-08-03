(setf (current-problem)
  (create-problem
    (name p47)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on blockE blockH)
          (on-table blockH)
))))