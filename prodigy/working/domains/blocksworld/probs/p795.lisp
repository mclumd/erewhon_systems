(setf (current-problem)
  (create-problem
    (name p795)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
))))