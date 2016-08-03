(setf (current-problem)
  (create-problem
    (name p148)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockH)
          (on blockH blockG)
          (on blockG blockA)
          (on-table blockA)
))))