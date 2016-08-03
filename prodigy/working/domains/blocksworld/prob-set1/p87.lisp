(setf (current-problem)
  (create-problem
    (name p87)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
))))