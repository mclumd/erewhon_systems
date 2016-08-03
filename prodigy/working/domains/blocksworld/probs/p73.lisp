(setf (current-problem)
  (create-problem
    (name p73)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
))))