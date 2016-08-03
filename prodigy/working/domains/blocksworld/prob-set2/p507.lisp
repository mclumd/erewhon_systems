(setf (current-problem)
  (create-problem
    (name p507)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
))))