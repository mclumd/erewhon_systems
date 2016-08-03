(setf (current-problem)
  (create-problem
    (name p953)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
))))