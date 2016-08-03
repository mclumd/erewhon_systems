(setf (current-problem)
  (create-problem
    (name p437)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on blockG blockD)
          (on blockD blockB)
          (on-table blockB)
))))