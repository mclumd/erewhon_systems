(setf (current-problem)
  (create-problem
    (name p89)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on blockF blockG)
          (on-table blockG)
))))