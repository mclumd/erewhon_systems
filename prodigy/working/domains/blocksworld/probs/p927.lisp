(setf (current-problem)
  (create-problem
    (name p927)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockA)
          (on blockA blockG)
          (on blockG blockF)
          (on blockF blockE)
          (on blockE blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))))