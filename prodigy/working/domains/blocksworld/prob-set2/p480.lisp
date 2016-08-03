(setf (current-problem)
  (create-problem
    (name p480)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on blockE blockC)
          (on blockC blockA)
          (on blockA blockD)
          (on blockD blockB)
          (on blockB blockG)
          (on blockG blockF)
          (on-table blockF)
))))