(setf (current-problem)
  (create-problem
    (name p85)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockC)
          (on blockC blockA)
          (on-table blockA)
))))