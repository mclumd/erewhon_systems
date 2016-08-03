(setf (current-problem)
  (create-problem
    (name p863)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))))