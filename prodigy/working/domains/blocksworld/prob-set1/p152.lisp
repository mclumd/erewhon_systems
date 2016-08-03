(setf (current-problem)
  (create-problem
    (name p152)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockH)
          (on blockH blockB)
          (on blockB blockC)
          (on-table blockC)
))))