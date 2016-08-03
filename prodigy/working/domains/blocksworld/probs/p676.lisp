(setf (current-problem)
  (create-problem
    (name p676)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockA)
          (on blockA blockD)
          (on blockD blockH)
          (on blockH blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on blockE blockA)
          (on blockA blockC)
          (on blockC blockH)
          (on-table blockH)
))))