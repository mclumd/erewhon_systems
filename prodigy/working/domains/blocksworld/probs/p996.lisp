(setf (current-problem)
  (create-problem
    (name p996)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockC)
          (on blockC blockG)
          (on blockG blockE)
          (on blockE blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockG)
          (on blockG blockH)
          (on blockH blockF)
          (on blockF blockC)
          (on blockC blockA)
          (on-table blockA)
))))