(setf (current-problem)
  (create-problem
    (name p430)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on blockC blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
))))