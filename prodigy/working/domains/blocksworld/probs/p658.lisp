(setf (current-problem)
  (create-problem
    (name p658)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))))