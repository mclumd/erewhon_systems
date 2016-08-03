(setf (current-problem)
  (create-problem
    (name p804)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockD)
          (on blockD blockG)
          (on-table blockG)
))))