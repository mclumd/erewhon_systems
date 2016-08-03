(setf (current-problem)
  (create-problem
    (name p83)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockC)
          (on blockC blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))))