(setf (current-problem)
  (create-problem
    (name p442)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
))))