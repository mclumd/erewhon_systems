(setf (current-problem)
  (create-problem
    (name p2)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockF)
          (on blockF blockH)
          (on-table blockH)
))))