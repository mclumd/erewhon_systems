(setf (current-problem)
  (create-problem
    (name p2)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
))))