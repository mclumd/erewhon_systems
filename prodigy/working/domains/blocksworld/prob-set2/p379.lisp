(setf (current-problem)
  (create-problem
    (name p379)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))))