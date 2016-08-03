(setf (current-problem)
  (create-problem
    (name p17)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
))))