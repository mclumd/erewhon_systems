(setf (current-problem)
  (create-problem
    (name p605)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))))