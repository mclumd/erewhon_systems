(setf (current-problem)
  (create-problem
    (name p965)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on blockG blockD)
          (on-table blockD)
))))