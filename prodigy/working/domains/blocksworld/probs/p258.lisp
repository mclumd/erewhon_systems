(setf (current-problem)
  (create-problem
    (name p258)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockB)
          (on blockB blockF)
          (on blockF blockA)
          (on blockA blockD)
          (on-table blockD)
))))