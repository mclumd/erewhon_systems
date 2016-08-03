(setf (current-problem)
  (create-problem
    (name p182)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))))