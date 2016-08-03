(setf (current-problem)
  (create-problem
    (name p152)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))))