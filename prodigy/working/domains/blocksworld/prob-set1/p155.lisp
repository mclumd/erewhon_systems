(setf (current-problem)
  (create-problem
    (name p155)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on blockD blockG)
          (on-table blockG)
))))