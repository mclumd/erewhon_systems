(setf (current-problem)
  (create-problem
    (name p109)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on blockC blockH)
          (on blockH blockE)
          (on-table blockE)
))))