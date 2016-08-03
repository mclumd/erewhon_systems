(setf (current-problem)
  (create-problem
    (name p45)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockD)
          (on blockD blockA)
          (on-table blockA)
))))