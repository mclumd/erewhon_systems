(setf (current-problem)
  (create-problem
    (name p177)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockB)
          (on blockB blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockH)
          (on blockH blockG)
          (on blockG blockF)
          (on blockF blockA)
          (on-table blockA)
))))