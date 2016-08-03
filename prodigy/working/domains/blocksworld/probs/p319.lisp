(setf (current-problem)
  (create-problem
    (name p319)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))))