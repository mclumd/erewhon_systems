(setf (current-problem)
  (create-problem
    (name p47)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
))))