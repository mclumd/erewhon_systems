(setf (current-problem)
  (create-problem
    (name p473)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on blockG blockH)
          (on-table blockH)
))))