(setf (current-problem)
  (create-problem
    (name p417)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockA)
          (on blockA blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockD)
          (on blockD blockB)
          (on blockB blockG)
          (on blockG blockH)
          (on blockH blockA)
          (on-table blockA)
))))