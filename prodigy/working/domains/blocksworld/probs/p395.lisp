(setf (current-problem)
  (create-problem
    (name p395)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
))))