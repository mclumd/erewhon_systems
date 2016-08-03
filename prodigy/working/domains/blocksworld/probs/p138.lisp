(setf (current-problem)
  (create-problem
    (name p138)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on blockH blockD)
          (on blockD blockB)
          (on-table blockB)
))))