(setf (current-problem)
  (create-problem
    (name p29)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
))))