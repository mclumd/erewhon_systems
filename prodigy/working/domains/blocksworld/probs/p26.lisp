(setf (current-problem)
  (create-problem
    (name p26)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockB)
          (on blockB blockG)
          (on blockG blockH)
          (on-table blockH)
))))