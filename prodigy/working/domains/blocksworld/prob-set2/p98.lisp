(setf (current-problem)
  (create-problem
    (name p98)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockH)
          (on blockH blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
))))