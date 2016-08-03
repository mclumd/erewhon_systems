(setf (current-problem)
  (create-problem
    (name p954)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockF)
          (on blockF blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))))