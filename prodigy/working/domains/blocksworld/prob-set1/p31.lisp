(setf (current-problem)
  (create-problem
    (name p31)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockG)
          (on blockG blockH)
          (on blockH blockC)
          (on blockC blockA)
          (on-table blockA)
))))