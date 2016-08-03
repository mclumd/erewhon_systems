(setf (current-problem)
  (create-problem
    (name p512)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))))