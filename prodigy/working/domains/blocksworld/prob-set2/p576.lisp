(setf (current-problem)
  (create-problem
    (name p576)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
))))