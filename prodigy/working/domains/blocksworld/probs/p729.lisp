(setf (current-problem)
  (create-problem
    (name p729)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockA)
          (on blockA blockC)
          (on-table blockC)
))))