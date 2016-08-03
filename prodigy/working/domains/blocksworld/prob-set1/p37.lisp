(setf (current-problem)
  (create-problem
    (name p37)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockA)
          (on blockA blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockE)
          (on blockE blockD)
          (on blockD blockC)
          (on-table blockC)
))))