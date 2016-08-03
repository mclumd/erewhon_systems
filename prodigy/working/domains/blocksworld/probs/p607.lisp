(setf (current-problem)
  (create-problem
    (name p607)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))))