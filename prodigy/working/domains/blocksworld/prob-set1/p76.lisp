(setf (current-problem)
  (create-problem
    (name p76)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockC)
          (on blockC blockA)
          (on blockA blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockA)
          (on blockA blockG)
          (on blockG blockF)
          (on blockF blockE)
          (on blockE blockH)
          (on-table blockH)
))))