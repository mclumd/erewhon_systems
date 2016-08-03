(setf (current-problem)
  (create-problem
    (name p374)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
))))