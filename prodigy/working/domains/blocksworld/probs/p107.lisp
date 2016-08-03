(setf (current-problem)
  (create-problem
    (name p107)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
))))