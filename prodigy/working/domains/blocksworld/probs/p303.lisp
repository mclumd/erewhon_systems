(setf (current-problem)
  (create-problem
    (name p303)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on blockC blockH)
          (on-table blockH)
))))