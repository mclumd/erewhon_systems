(setf (current-problem)
  (create-problem
    (name p151)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockD)
          (on blockD blockA)
          (on blockA blockE)
          (on blockE blockC)
          (on blockC blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockG)
          (on blockG blockB)
          (on-table blockB)
))))