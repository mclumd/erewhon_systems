(setf (current-problem)
  (create-problem
    (name p372)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockE)
          (on blockE blockH)
          (on-table blockH)
))))