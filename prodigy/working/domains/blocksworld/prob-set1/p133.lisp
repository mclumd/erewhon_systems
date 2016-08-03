(setf (current-problem)
  (create-problem
    (name p133)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockE)
          (on blockE blockD)
          (on blockD blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on blockC blockH)
          (on blockH blockA)
          (on-table blockA)
))))