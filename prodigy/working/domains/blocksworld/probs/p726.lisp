(setf (current-problem)
  (create-problem
    (name p726)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))))