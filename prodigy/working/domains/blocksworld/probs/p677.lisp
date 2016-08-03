(setf (current-problem)
  (create-problem
    (name p677)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockB)
          (on blockB blockA)
          (on blockA blockD)
          (on blockD blockE)
          (on blockE blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on blockF blockE)
          (on blockE blockC)
          (on blockC blockD)
          (on blockD blockA)
          (on blockA blockH)
          (on-table blockH)
))))