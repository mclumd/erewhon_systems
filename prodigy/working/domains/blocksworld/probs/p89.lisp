(setf (current-problem)
  (create-problem
    (name p89)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))))