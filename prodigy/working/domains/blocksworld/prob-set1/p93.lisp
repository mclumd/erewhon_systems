(setf (current-problem)
  (create-problem
    (name p93)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
))))