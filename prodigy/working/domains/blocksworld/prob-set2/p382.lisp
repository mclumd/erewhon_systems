(setf (current-problem)
  (create-problem
    (name p382)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))))