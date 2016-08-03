(setf (current-problem)
  (create-problem
    (name p29)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockH)
          (on blockH blockG)
          (on blockG blockE)
          (on blockE blockA)
          (on blockA blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
))))