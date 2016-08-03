(setf (current-problem)
  (create-problem
    (name p87)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))))