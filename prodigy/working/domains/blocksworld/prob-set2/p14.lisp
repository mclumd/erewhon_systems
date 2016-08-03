(setf (current-problem)
  (create-problem
    (name p14)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockC)
          (on blockC blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))))