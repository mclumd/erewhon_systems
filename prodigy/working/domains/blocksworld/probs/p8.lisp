(setf (current-problem)
  (create-problem
    (name p8)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
))))