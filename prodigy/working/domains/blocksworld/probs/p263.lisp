(setf (current-problem)
  (create-problem
    (name p263)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockA)
          (on blockA blockF)
          (on blockF blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
))))