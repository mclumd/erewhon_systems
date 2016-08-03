(setf (current-problem)
  (create-problem
    (name p535)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockB)
          (on blockB blockG)
          (on-table blockG)
))))