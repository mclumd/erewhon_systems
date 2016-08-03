(setf (current-problem)
  (create-problem
    (name p529)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))))