(setf (current-problem)
  (create-problem
    (name p9)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on blockH blockB)
          (on blockB blockC)
          (on blockC blockD)
          (on-table blockD)
))))