(setf (current-problem)
  (create-problem
    (name p550)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on blockD blockE)
          (on blockE blockA)
          (on-table blockA)
))))