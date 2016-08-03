(setf (current-problem)
  (create-problem
    (name p51)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))))