(setf (current-problem)
  (create-problem
    (name p453)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockH)
          (on blockH blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockE)
          (on blockE blockH)
          (on-table blockH)
))))