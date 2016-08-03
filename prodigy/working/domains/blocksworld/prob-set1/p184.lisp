(setf (current-problem)
  (create-problem
    (name p184)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockG)
          (on blockG blockD)
          (on blockD blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
))))