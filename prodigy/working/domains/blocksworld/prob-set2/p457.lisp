(setf (current-problem)
  (create-problem
    (name p457)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockD)
          (on blockD blockH)
          (on blockH blockE)
          (on blockE blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockD)
          (on blockD blockA)
          (on blockA blockE)
          (on-table blockE)
))))