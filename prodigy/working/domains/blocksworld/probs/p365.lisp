(setf (current-problem)
  (create-problem
    (name p365)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockG)
          (on blockG blockH)
          (on blockH blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on blockH blockD)
          (on-table blockD)
))))