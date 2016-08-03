(setf (current-problem)
  (create-problem
    (name p345)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
))))