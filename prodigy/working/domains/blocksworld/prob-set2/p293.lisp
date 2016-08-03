(setf (current-problem)
  (create-problem
    (name p293)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on blockF blockB)
          (on blockB blockA)
          (on blockA blockE)
          (on-table blockE)
))))