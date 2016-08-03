(setf (current-problem)
  (create-problem
    (name p311)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
))))