(setf (current-problem)
  (create-problem
    (name p952)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockB)
          (on blockB blockA)
          (on blockA blockH)
          (on blockH blockD)
          (on blockD blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
))))