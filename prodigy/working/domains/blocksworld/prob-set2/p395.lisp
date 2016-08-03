(setf (current-problem)
  (create-problem
    (name p395)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockE)
          (on blockE blockF)
          (on blockF blockB)
          (on blockB blockD)
          (on blockD blockG)
          (on blockG blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockA)
          (on blockA blockE)
          (on blockE blockF)
          (on blockF blockC)
          (on-table blockC)
))))