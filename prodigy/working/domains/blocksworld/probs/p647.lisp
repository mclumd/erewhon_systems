(setf (current-problem)
  (create-problem
    (name p647)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockF)
          (on blockF blockC)
          (on blockC blockB)
          (on-table blockB)
))))