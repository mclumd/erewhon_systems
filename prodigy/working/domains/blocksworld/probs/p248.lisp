(setf (current-problem)
  (create-problem
    (name p248)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockH)
          (on blockH blockC)
          (on blockC blockE)
          (on-table blockE)
))))