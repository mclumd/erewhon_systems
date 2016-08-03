(setf (current-problem)
  (create-problem
    (name p90)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockH)
          (on blockH blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))))