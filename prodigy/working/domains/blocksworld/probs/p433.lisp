(setf (current-problem)
  (create-problem
    (name p433)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockB)
          (on blockB blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))))