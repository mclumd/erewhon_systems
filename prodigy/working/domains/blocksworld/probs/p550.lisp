(setf (current-problem)
  (create-problem
    (name p550)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on blockA blockG)
          (on blockG blockH)
          (on blockH blockC)
          (on-table blockC)
))))