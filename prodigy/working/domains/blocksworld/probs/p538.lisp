(setf (current-problem)
  (create-problem
    (name p538)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
))))