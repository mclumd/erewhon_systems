(setf (current-problem)
  (create-problem
    (name p174)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockG)
          (on blockG blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on blockG blockC)
          (on-table blockC)
))))