(setf (current-problem)
  (create-problem
    (name p119)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockA)
          (on blockA blockE)
          (on blockE blockB)
          (on-table blockB)
))))