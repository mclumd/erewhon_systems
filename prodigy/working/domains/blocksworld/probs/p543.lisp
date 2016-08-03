(setf (current-problem)
  (create-problem
    (name p543)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))))