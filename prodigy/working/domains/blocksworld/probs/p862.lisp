(setf (current-problem)
  (create-problem
    (name p862)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on blockH blockE)
          (on-table blockE)
))))