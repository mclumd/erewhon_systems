(setf (current-problem)
  (create-problem
    (name p830)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockF)
          (on blockF blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))))