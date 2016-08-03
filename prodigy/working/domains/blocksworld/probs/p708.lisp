(setf (current-problem)
  (create-problem
    (name p708)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
))))