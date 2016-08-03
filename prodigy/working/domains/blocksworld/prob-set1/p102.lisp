(setf (current-problem)
  (create-problem
    (name p102)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on blockC blockG)
          (on blockG blockE)
          (on blockE blockA)
          (on blockA blockH)
          (on blockH blockF)
          (on-table blockF)
))))