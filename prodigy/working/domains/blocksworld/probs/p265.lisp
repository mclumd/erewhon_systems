(setf (current-problem)
  (create-problem
    (name p265)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockG)
          (on blockG blockH)
          (on blockH blockC)
          (on blockC blockA)
          (on blockA blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockG)
          (on blockG blockA)
          (on blockA blockE)
          (on blockE blockF)
          (on blockF blockH)
          (on-table blockH)
))))