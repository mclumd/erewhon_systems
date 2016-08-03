(setf (current-problem)
  (create-problem
    (name p401)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockD)
          (on blockD blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))))