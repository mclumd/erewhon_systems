(setf (current-problem)
  (create-problem
    (name p477)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockE)
          (on blockE blockH)
          (on blockH blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockC)
          (on blockC blockG)
          (on blockG blockA)
          (on-table blockA)
))))