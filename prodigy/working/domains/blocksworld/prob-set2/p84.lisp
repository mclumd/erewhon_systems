(setf (current-problem)
  (create-problem
    (name p84)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockD)
          (on blockD blockE)
          (on blockE blockB)
          (on blockB blockH)
          (on blockH blockA)
          (on blockA blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on blockA blockG)
          (on blockG blockD)
          (on blockD blockC)
          (on blockC blockB)
          (on-table blockB)
))))