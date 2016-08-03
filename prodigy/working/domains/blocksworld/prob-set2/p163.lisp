(setf (current-problem)
  (create-problem
    (name p163)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on blockH blockC)
          (on-table blockC)
))))