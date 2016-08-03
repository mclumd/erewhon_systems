(setf (current-problem)
  (create-problem
    (name p353)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
))))