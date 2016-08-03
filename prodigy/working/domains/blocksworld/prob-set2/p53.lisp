(setf (current-problem)
  (create-problem
    (name p53)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockC)
          (on blockC blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockF)
          (on blockF blockB)
          (on-table blockB)
))))