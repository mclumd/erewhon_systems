(setf (current-problem)
  (create-problem
    (name p756)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockG)
          (on blockG blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on blockB blockG)
          (on blockG blockH)
          (on-table blockH)
))))