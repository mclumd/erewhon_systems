(setf (current-problem)
  (create-problem
    (name p104)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))))