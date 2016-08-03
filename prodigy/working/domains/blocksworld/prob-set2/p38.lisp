(setf (current-problem)
  (create-problem
    (name p38)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))))