(setf (current-problem)
  (create-problem
    (name p749)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on blockE blockH)
          (on blockH blockG)
          (on-table blockG)
))))