(setf (current-problem)
  (create-problem
    (name p55)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockA)
          (on blockA blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on blockF blockB)
          (on blockB blockD)
          (on blockD blockA)
          (on-table blockA)
))))