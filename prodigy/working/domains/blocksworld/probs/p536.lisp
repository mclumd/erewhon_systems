(setf (current-problem)
  (create-problem
    (name p536)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))))