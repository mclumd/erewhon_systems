(setf (current-problem)
  (create-problem
    (name p370)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on blockG blockH)
          (on-table blockH)
))))