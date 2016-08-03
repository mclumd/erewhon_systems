(setf (current-problem)
  (create-problem
    (name p802)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockG)
          (on blockG blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on blockE blockD)
          (on blockD blockH)
          (on-table blockH)
))))