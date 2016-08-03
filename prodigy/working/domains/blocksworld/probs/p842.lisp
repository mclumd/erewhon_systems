(setf (current-problem)
  (create-problem
    (name p842)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))))